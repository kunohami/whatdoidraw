import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../shared/models/stroke_model.dart';
import '../../../core/providers/supabase_provider.dart';

part 'doodle_canvas_provider.g.dart';

// [DOC]: Usamos Notifier<List<StrokeModel>> para mantener en memoria una lista de 
// todos los trazos actuales. Es reactivo: cuando le añadimos un punto, 
// la pantalla se repinta al unísono automáticamente.

@riverpod
class DoodleCanvas extends _$DoodleCanvas {
  @override
  List<StrokeModel> build() {
    return []; // Inicialmente el lienzo está limpio (0 trazos)
  }

  // [DOC]: Cuando el dedo TOCA la pantalla (GestureDetector.onPanDown), 
  // iniciamos un NUEVO trazo en la lista con el primer punto de toque.
  void startStroke(double x, double y) {
    final newStroke = StrokeModel(
      points: [PointModel(x: x, y: y)],
      colorValue: 0xFFEEEEEE, // Blanco base (para tema oscuro)
      strokeWidth: 4.0,
    );
    state = [...state, newStroke];
  }

  // [DOC]: Cuando el dedo se ARRASTRA por la pantalla (GestureDetector.onPanUpdate),
  // buscamos el último trazo que creamos, y le añadimos nuevos puntos a su lista.
  void updateStroke(double x, double y) {
    if (state.isEmpty) return;

    final lastStrokeIndex = state.length - 1;
    final lastStroke = state[lastStrokeIndex];
    
    // Mutar los arreglos en Dart no notifica a Riverpod. Hay que crear copias limpias.
    final updatedPoints = [...lastStroke.points, PointModel(x: x, y: y)];
    final updatedStroke = lastStroke.copyWith(points: updatedPoints);

    final newState = List<StrokeModel>.from(state);
    newState[lastStrokeIndex] = updatedStroke;

    state = newState;
  }

  // [DOC]: ¡Herramienta de deshacer! Simplemente eliminos el último objeto "StrokeModel" 
  // de nuestra lista. Toda la pantalla se repintará sin ese trazo. ¡Pura magia algorítmica!
  void undo() {
    if (state.isNotEmpty) {
      final newState = List<StrokeModel>.from(state)..removeLast();
      state = newState;
    }
  }

  void clear() {
    state = [];
  }

  // [DOC]: Esta función transformará todos nuestros Trazo -> lista de puntos -> a un objeto JSON puro,
  // y lo enviará a Supabase referenciando la Idea original. ¡Sin usar convertidores externos!
  Future<void> submitDoodle(String? ideaId) async {
    if (state.isEmpty) return; // No permitimos panales vacíos

    // 1. Transformamos DART a JSON invocando el .toJson() automático de Freezed.
    final doodleJsonArray = state.map((stroke) => stroke.toJson()).toList();

    // 2. Extraer dependencias
    final supabase = ref.read(supabaseClientProvider);
    final userId = supabase.auth.currentUser?.id;

    if (userId == null) throw Exception('Inicia sesión para subir Doodles');

    // 3. Enviamos a la tabla
    await supabase.from('doodles').insert({
      'user_id': userId,
      'idea_id': ideaId,
      'doodle_data': doodleJsonArray, // Almacenado como JSONB
    });
    
    // Limpiamos el tapiz tras publicarlo
    clear();
  }
}
