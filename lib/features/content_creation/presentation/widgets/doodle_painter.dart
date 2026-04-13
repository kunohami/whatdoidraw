import 'package:flutter/material.dart';
import '../../../../shared/models/stroke_model.dart';
import 'dart:ui';

// [DOC]: Esta es la pieza arquitectónica clave. CustomPainter es el "pincel"
// nativo de bajo nivel de Flutter. 
// A diferencia de un Widget, esto dibuja instrucciones crudas sobre la GPU 
// cada vez que hay cambios en los parámetros. Sumamente rápido e ideal para juegos.

class DoodlePainter extends CustomPainter {
  final List<StrokeModel> strokes;

  DoodlePainter({required this.strokes});

  @override
  void paint(Canvas canvas, Size size) {

    for (final stroke in strokes) {
      if (stroke.points.isEmpty) continue;

      // [DOC]: 'Paint' es la brocha en sí. 
      // Le ajustamos el borde redondeado para que las intersecciones de 
      // puntos no se vean afiladas ni pixeladas.
      final paint = Paint()
        ..color = Color(stroke.colorValue)
        ..strokeWidth = stroke.strokeWidth
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round
        ..style = PaintingStyle.stroke; // Obligatorio 'stroke', sino pinta manchas.

      // [DOC]: Un 'Path' (Camino) agrupa uniones de puntos.
      final path = Path();
      
      // Movemos la brocha (en el aire, sin pintar) a la coordenada de inicio
      path.moveTo(stroke.points.first.x, stroke.points.first.y);

      // Deslizamos la brocha rozando el papel sobre el resto de coordenadas
      for (int i = 1; i < stroke.points.length; i++) {
        path.lineTo(stroke.points[i].x, stroke.points[i].y);
      }

      // Le pasamos el diseño al motor gráfico nativo.
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant DoodlePainter oldDelegate) {
    // Si devuelves "true", obliga a redibujar el papel cuando detecta mínimos cambios.
    // Riverpod invocará este repintado cuando state cambie de número de elementos.
    return true; 
  }
}
