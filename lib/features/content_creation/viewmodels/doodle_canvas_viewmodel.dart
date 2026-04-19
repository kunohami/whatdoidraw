import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:whatdoidraw/features/auth/auth_provider.dart';
import 'package:whatdoidraw/features/content_creation/services/content_creation_service.dart';
import 'package:whatdoidraw/shared/models/stroke_model.dart';

part 'doodle_canvas_viewmodel.freezed.dart';
part 'doodle_canvas_viewmodel.g.dart';

/// Representa el estado atómico y reactivo del lienzo de dibujo.
///
/// Siguiendo las mejores prácticas de MVVM, este objeto agrupa todos los datos
/// que la interfaz de usuario necesita para renderizarse y reaccionar a eventos
/// de negocio (como la carga o errores).
@freezed
abstract class DoodleCanvasState with _$DoodleCanvasState {
  const factory DoodleCanvasState({
    /// Lista de trazos vectoriales dibujados actualmente.
    @Default([]) List<StrokeModel> strokes,

    /// Indica si se está realizando una operación asíncrona (como subir a la nube).
    @Default(false) bool isSubmitting,

    /// Almacena un mensaje de error descriptivo si algo falla.
    String? errorMessage,
  }) = _DoodleCanvasState;
}

/// Gestor de la lógica de negocio para el lienzo de dibujo (ViewModel).
///
/// Este Notifier orquestra cómo los trazos físicos se transforman en estado
/// inmutable y cómo se persiste la creación del usuario.
@riverpod
class DoodleCanvas extends _$DoodleCanvas {
  @override
  DoodleCanvasState build() {
    // Estado inicial: Lienzo vacío y sin procesos activos.
    return const DoodleCanvasState();
  }

  /// Inicia un nuevo trazo en el lienzo al detectar el toque inicial.
  ///
  /// Recibe las coordenadas [x] e [y] locales al área de dibujo.
  void startStroke(double x, double y) {
    final newStroke = StrokeModel(
      points: [PointModel(x: x, y: y)],
      colorValue: 0xFF000000, // Negro absoluto por defecto
      strokeWidth: 4.0,
    );

    // Actualizamos el estado sustituyendo la lista por una nueva copia (Reactividad).
    state = state.copyWith(
      strokes: [...state.strokes, newStroke],
      errorMessage: null, // Limpiamos errores al empezar a dibujar de nuevo
    );
  }

  /// Actualiza el último trazo añadiendo nuevos puntos mientras se arrastra el dedo.
  void updateStroke(double x, double y) {
    if (state.strokes.isEmpty) return;

    final lastStrokeIndex = state.strokes.length - 1;
    final lastStroke = state.strokes[lastStrokeIndex];

    // Creamos copias inmutables de los datos para mantener la integridad del estado anterior.
    final updatedPoints = [...lastStroke.points, PointModel(x: x, y: y)];
    final updatedStroke = lastStroke.copyWith(points: updatedPoints);

    final newStrokes = List<StrokeModel>.from(state.strokes);
    newStrokes[lastStrokeIndex] = updatedStroke;

    state = state.copyWith(strokes: newStrokes);
  }

  /// Elimina el último trazo realizado (Función Deshacer).
  void undo() {
    if (state.strokes.isNotEmpty) {
      final newStrokes = List<StrokeModel>.from(state.strokes)..removeLast();
      state = state.copyWith(strokes: newStrokes);
    }
  }

  /// Limpia por completo el lienzo.
  void clear() {
    state = state.copyWith(strokes: [], errorMessage: null);
  }

  /// Persiste el dibujo actual en el servidor.
  ///
  /// Utiliza el [contentCreationServiceProvider] para la red y el
  /// [authControllerProvider] para identificar al autor de forma abstracta.
  Future<void> submitDoodle(String? ideaId) async {
    if (state.strokes.isEmpty) return;

    // Activamos el estado de carga
    state = state.copyWith(isSubmitting: true, errorMessage: null);

    try {
      // Obtenemos el usuario actual del controlador de autenticación central.
      // Notese que el ViewModel ya no conoce "Supabase" directamente.
      final user = ref.read(authControllerProvider).value;

      if (user == null) {
        throw Exception('Inicia sesión para poder publicar tus dibujos.');
      }

      await ref
          .read(contentCreationServiceProvider)
          .insertDoodle(state.strokes, user.id, ideaId);

      // Si tiene éxito, limpiamos y desactivamos carga
      state = state.copyWith(strokes: [], isSubmitting: false);
    } catch (e) {
      // En caso de error, lo exponemos de forma declarativa en el estado
      state = state.copyWith(
        isSubmitting: false,
        errorMessage: e.toString().contains('Exception:')
            ? e.toString().split('Exception: ')[1]
            : 'Error inesperado al publicar',
      );
    }
  }
}
