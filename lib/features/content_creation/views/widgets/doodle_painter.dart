import 'package:flutter/material.dart';

import 'package:whatdoidraw/shared/models/stroke_model.dart';

/// Motor gráfico encargado de renderizar los trazos en la GPU.
///
/// Al heredar de [CustomPainter], estamos hablando directamente con la capa
/// de bajo nivel de Flutter. Es ideal para aplicaciones de alto rendimiento
/// como lienzos de dibujo o videojuegos simples.
class DoodlePainter extends CustomPainter {
  /// Lista de trazos que el pintor debe dibujar en cada frame.
  final List<StrokeModel> strokes;

  DoodlePainter({required this.strokes});

  @override
  void paint(Canvas canvas, Size size) {
    // 1. Dibujamos los trazos de color (capa inferior)
    for (final stroke in strokes.where((s) => s.isColorLayer)) {
      _paintStroke(canvas, stroke);
    }

    // 2. Dibujamos los trazos de línea (capa superior - líneas negras)
    for (final stroke in strokes.where((s) => !s.isColorLayer)) {
      _paintStroke(canvas, stroke);
    }
  }

  void _paintStroke(Canvas canvas, StrokeModel stroke) {
    if (stroke.points.isEmpty) return;

    /// Configuramos la 'brocha' ([Paint]) para este trazo específico.
    final paint = Paint()
      ..color = Color(stroke.colorValue)
      ..strokeWidth = stroke.strokeWidth
      ..strokeCap = StrokeCap
          .round // Bordes redondeados para suavidad.
      ..strokeJoin = StrokeJoin
          .round // Uniones redondeadas.
      ..style = PaintingStyle.stroke; // Modo dibujo de líneas (no relleno).

    /// Un 'Path' es un objeto que agrupa una serie de instrucciones de
    /// movimiento para crear formas complejas.
    final path = Path();

    // Situamos el origen del camino en el primer punto del trazo.
    path.moveTo(stroke.points.first.x, stroke.points.first.y);

    // Conectamos el resto de puntos con líneas rectas.
    for (int i = 1; i < stroke.points.length; i++) {
      path.lineTo(stroke.points[i].x, stroke.points[i].y);
    }

    // Enviamos las instrucciones finales al [Canvas] nativo.
    canvas.drawPath(path, paint);
  }

  /// Determina si el sistema debe redibujar el lienzo.
  ///
  /// Retornar `true` garantiza que cada vez que la lista de [strokes] cambie
  /// en el ViewModel, Flutter ejecute el métido [paint] de nuevo.
  @override
  bool shouldRepaint(covariant DoodlePainter oldDelegate) {
    return true;
  }
}
