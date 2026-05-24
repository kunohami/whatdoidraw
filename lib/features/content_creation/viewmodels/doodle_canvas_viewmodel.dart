import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:whatdoidraw/features/auth/auth_provider.dart';
import 'package:whatdoidraw/features/content_creation/services/content_creation_service.dart';
import 'package:whatdoidraw/shared/models/stroke_model.dart';

part 'doodle_canvas_viewmodel.freezed.dart';
part 'doodle_canvas_viewmodel.g.dart';

enum DrawingTool {
  pen,         // Líneas negras (capa de líneas)
  brush,       // Pincel de color (capa de color)
  eraserLine,  // Borrador de líneas
  eraserColor  // Borrador de color
}

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

    /// Etiquetas que el usuario ha asignado al doodle antes de publicarlo.
    @Default([]) List<String> tags,

    /// Indica si se está realizando una operación asíncrona (como subir a la nube).
    @Default(false) bool isSubmitting,

    /// Almacena un mensaje de error descriptivo si algo falla.
    String? errorMessage,

    /// Herramienta de dibujo actualmente seleccionada.
    @Default(DrawingTool.pen) DrawingTool activeTool,

    /// Color activo del pincel en formato ARGB.
    @Default(0xFFE53935) int brushColor,

    /// Grosor activo de la línea/pincel.
    @Default(4.0) double strokeWidth,

    /// Color de fondo del lienzo en formato ARGB.
    @Default(0xFFFFFFFF) int backgroundColor,

    /// Historial de estados anteriores de trazos para la función deshacer.
    @Default([]) List<List<StrokeModel>> undoHistory,
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

  /// Inicia un nuevo trazo en el lienzo al detectar el toque inicial o realiza el borrado.
  ///
  /// Recibe las coordenadas [x] e [y] locales al área de dibujo.
  void startStroke(double x, double y) {
    // Capturamos el estado actual del dibujo en el historial antes de realizar cualquier cambio
    final updatedHistory = [...state.undoHistory, state.strokes];

    if (state.activeTool == DrawingTool.eraserLine || state.activeTool == DrawingTool.eraserColor) {
      // Guardamos el historial primero en el estado para poder deshacer toda esta tirada de borrado
      state = state.copyWith(undoHistory: updatedHistory);
      eraseStrokeAt(x, y, isColorLayer: state.activeTool == DrawingTool.eraserColor);
      return;
    }

    final newStroke = StrokeModel(
      points: [PointModel(x: x, y: y)],
      colorValue: state.activeTool == DrawingTool.pen ? 0xFF000000 : state.brushColor,
      strokeWidth: state.strokeWidth,
      isColorLayer: state.activeTool == DrawingTool.brush,
    );

    // Actualizamos el estado sustituyendo la lista por una nueva copia (Reactividad).
    state = state.copyWith(
      undoHistory: updatedHistory,
      strokes: [...state.strokes, newStroke],
      errorMessage: null, // Limpiamos errores al empezar a dibujar de nuevo
    );
  }

  /// Actualiza el último trazo añadiendo nuevos puntos mientras se arrastra el dedo o borra continuamente.
  void updateStroke(double x, double y) {
    if (state.activeTool == DrawingTool.eraserLine || state.activeTool == DrawingTool.eraserColor) {
      eraseStrokeAt(x, y, isColorLayer: state.activeTool == DrawingTool.eraserColor);
      return;
    }

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

  /// Borra trazos en la capa seleccionada que estén cerca de las coordenadas dadas (radio de 20 píxeles).
  void eraseStrokeAt(double x, double y, {required bool isColorLayer}) {
    const eraserRadius = 20.0;
    final filteredStrokes = state.strokes.where((stroke) {
      if (stroke.isColorLayer != isColorLayer) return true;
      for (final point in stroke.points) {
        final dx = point.x - x;
        final dy = point.y - y;
        if (dx * dx + dy * dy < eraserRadius * eraserRadius) {
          return false; // Borramos el trazo completo que cruzó el borrador
        }
      }
      return true;
    }).toList();

    if (filteredStrokes.length != state.strokes.length) {
      state = state.copyWith(strokes: filteredStrokes);
    }
  }

  /// Cambia la herramienta de dibujo activa.
  void selectTool(DrawingTool tool) {
    state = state.copyWith(activeTool: tool);
  }

  /// Configura el color actual para el pincel.
  void setBrushColor(int color) {
    state = state.copyWith(brushColor: color);
  }

  /// Configura el grosor actual de la brocha o lápiz.
  void setStrokeWidth(double width) {
    state = state.copyWith(strokeWidth: width);
  }

  /// Configura el color de fondo del lienzo de dibujo.
  void setBackgroundColor(int color) {
    state = state.copyWith(backgroundColor: color);
  }

  /// Restaura el estado anterior del lienzo de dibujo (Deshace el último trazo, borrado o limpieza).
  void undo() {
    if (state.undoHistory.isNotEmpty) {
      final previousStrokes = state.undoHistory.last;
      final updatedHistory = List<List<StrokeModel>>.from(state.undoHistory)..removeLast();
      state = state.copyWith(
        strokes: previousStrokes,
        undoHistory: updatedHistory,
      );
    }
  }

  /// Limpia por completo el lienzo guardando el estado actual en el historial.
  void clear() {
    state = state.copyWith(
      undoHistory: [...state.undoHistory, state.strokes],
      strokes: [],
      errorMessage: null,
    );
  }

  /// Actualiza las etiquetas que se asociarán al doodle al publicarlo.
  void setTags(List<String> tags) {
    state = state.copyWith(tags: tags);
  }

  /// Persiste el dibujo actual en el servidor.
  ///
  /// Utiliza el [contentCreationServiceProvider] para la red y el
  /// [authControllerProvider] para identificar al autor de forma abstracta.
  /// Incluye los [tags] presentes en el estado del lienzo y el color de fondo.
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
          .insertDoodle(
            state.strokes, 
            user.id, 
            ideaId, 
            tags: state.tags,
            backgroundColor: state.backgroundColor,
          );

      // Si tiene éxito, limpiamos y desactivamos carga, y volvemos a valores por defecto
      state = state.copyWith(
        strokes: [], 
        tags: [], 
        undoHistory: [],
        isSubmitting: false,
        backgroundColor: 0xFFFFFFFF,
        activeTool: DrawingTool.pen,
        strokeWidth: 4.0,
      );
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
