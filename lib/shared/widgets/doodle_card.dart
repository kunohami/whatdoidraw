import 'package:flutter/material.dart';

import 'package:whatdoidraw/features/content_creation/views/widgets/doodle_painter.dart';
import 'package:whatdoidraw/features/feed/views/screens/doodle_detail_screen.dart';
import 'package:whatdoidraw/shared/models/doodle_model.dart';
import 'package:whatdoidraw/shared/models/stroke_model.dart';

/// Widget reutilizable que renderiza una miniatura de un [DoodleModel].
///
/// Utiliza un [CustomPaint] sobre el motor nativo para redibujar los trazos.
/// Al tocar la tarjeta, navega hacia la vista de detalles.
class DoodleCard extends StatelessWidget {
  /// El modelo del dibujo a renderizar
  final DoodleModel doodle;

  const DoodleCard({super.key, required this.doodle});

  @override
  Widget build(BuildContext context) {
    // Parsea los datos brutos guardados a entidades StrokeModel en memoria
    final strokes = doodle.doodleData
        .map((e) => StrokeModel.fromJson(e as Map<String, dynamic>))
        .toList();

    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 2,
      child: InkWell(
        onTap: () {
          // [DOC]: Navegación limpia parametrizada. 
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DoodleDetailScreen(doodle: doodle),
            ),
          );
        },
        child: Stack(
          fit: StackFit.expand,
          children: [
            Container(color: Colors.white), // Lienzo blanco
            Padding(
              padding: const EdgeInsets.all(8.0),
              // FittedBox escala automáticamente los trazos dentro del Card
              child: FittedBox(
                child: SizedBox(
                  width: 400,
                  height: 600,
                  child: CustomPaint(
                    painter: DoodlePainter(strokes: strokes),
                    size: Size.infinite,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
