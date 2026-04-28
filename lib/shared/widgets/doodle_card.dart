import 'package:flutter/material.dart';

import 'package:whatdoidraw/features/content_creation/views/widgets/doodle_painter.dart';
import 'package:whatdoidraw/features/feed/views/screens/doodle_detail_screen.dart';
import 'package:whatdoidraw/features/artworks/presentation/screens/create_artwork_screen.dart';
import 'package:whatdoidraw/shared/models/doodle_model.dart';
import 'package:whatdoidraw/shared/models/stroke_model.dart';
import 'package:whatdoidraw/shared/widgets/tag_chip.dart';

/// Widget reutilizable que renderiza una miniatura de un [DoodleModel].
///
/// Utiliza un [CustomPaint] sobre el motor nativo para redibujar los trazos.
/// Al tocar la tarjeta, navega hacia la vista de detalles.
/// Los tags se muestran como un overlay en la parte inferior de la tarjeta.
class DoodleCard extends StatelessWidget {
  /// El modelo del dibujo a renderizar.
  final DoodleModel doodle;

  /// Callback opcional para filtrar el feed por un tag al pulsarlo.
  final ValueChanged<String>? onTagTap;

  /// Lista de tags actualmente activos en el filtro del feed.
  final List<String> activeFilterTags;

  const DoodleCard({
    super.key,
    required this.doodle,
    this.onTagTap,
    this.activeFilterTags = const [],
  });

  @override
  Widget build(BuildContext context) {
    // Parsea los datos brutos guardados a entidades StrokeModel en memoria
    final strokes = doodle.doodleData
        .map((e) => StrokeModel.fromJson(e as Map<String, dynamic>))
        .toList();

    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
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
              child: Center(
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: SizedBox(
                    width: 600,
                    height: 800,
                    child: CustomPaint(
                      painter: DoodlePainter(strokes: strokes),
                      size: const Size(600, 800),
                    ),
                  ),
                ),
              ),
            ),
            // Tags overlay en la parte inferior de la tarjeta
            if (doodle.tags.isNotEmpty)
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.black.withValues(alpha: 0.5),
                        Colors.transparent,
                      ],
                    ),
                  ),
                  child: Wrap(
                    spacing: 4,
                    runSpacing: 2,
                    children: doodle.tags.take(3).map((tag) {
                      return TagChip(
                        tag: tag,
                        isActive: activeFilterTags.contains(tag),
                        onTap: onTagTap != null ? () => onTagTap!(tag) : null,
                      );
                    }).toList(),
                  ),
                ),
              ),
            Positioned(
              top: 4,
              right: 4,
              child: Material(
                color: Colors.white.withValues(alpha: 0.8),
                shape: const CircleBorder(),
                child: IconButton(
                  icon: const Icon(Icons.publish_outlined, size: 20),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CreateArtworkScreen(
                          doodleId: doodle.id,
                        ),
                      ),
                    );
                  },
                  tooltip: 'Publicar Artwork final',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
