import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../shared/models/stroke_model.dart';
import '../../../../core/providers/supabase_provider.dart';
import '../services/content_creation_service.dart';

part 'doodle_canvas_viewmodel.g.dart';

// [DOC]: Usamos Notifier<List<StrokeModel>> para mantener en memoria una lista de 
// todos los trazos actuales. Es reactivo: cuando le añadimos un punto, 
// la pantalla se repinta al unísono automáticamente.

@riverpod
class DoodleCanvas extends _$DoodleCanvas {
  @override
  List<StrokeModel> build() {
    return []; // Inicialmente el lienzo está limpio (0 trazos)
  }

  void startStroke(double x, double y) {
    final newStroke = StrokeModel(
      points: [PointModel(x: x, y: y)],
      colorValue: 0xFFEEEEEE, 
      strokeWidth: 4.0,
    );
    state = [...state, newStroke];
  }

  void updateStroke(double x, double y) {
    if (state.isEmpty) return;

    final lastStrokeIndex = state.length - 1;
    final lastStroke = state[lastStrokeIndex];
    
    final updatedPoints = [...lastStroke.points, PointModel(x: x, y: y)];
    final updatedStroke = lastStroke.copyWith(points: updatedPoints);

    final newState = List<StrokeModel>.from(state);
    newState[lastStrokeIndex] = updatedStroke;

    state = newState;
  }

  void undo() {
    if (state.isNotEmpty) {
      final newState = List<StrokeModel>.from(state)..removeLast();
      state = newState;
    }
  }

  void clear() {
    state = [];
  }

  // [DOC]: [LAYER: VIEWMODEL (MVVM)]
  // Llamamos al service de forma directa
  Future<void> submitDoodle(String? ideaId) async {
    if (state.isEmpty) return; 

    final supabase = ref.read(supabaseClientProvider);
    final userId = supabase.auth.currentUser?.id;

    if (userId == null) throw Exception('Inicia sesión para subir Doodles');

    await ref.read(contentCreationServiceProvider).insertDoodle(
      state, // El Service se encargará de mapearlo a JSON internamente.
      userId,
      ideaId,
    );
    
    clear();
  }
}
