import 'package:flutter/material.dart';

import 'package:whatdoidraw/features/content_creation/views/screens/doodle_canvas_screen.dart';
import 'package:whatdoidraw/shared/models/idea_model.dart';
import 'package:whatdoidraw/shared/widgets/tag_chip.dart';

/// Widget reutilizable que visualiza una idea de forma estandarizada.
///
/// Encapsula una [IdeaModel] dentro de un [Card]. Se diseñó originalmente para
/// el feed global, pero su parámetro opcional [showDrawButton] permite que sea
/// reutilizado en el perfil sin forzar el inicio de dibujo cuando sólo se desea visualizar.
class IdeaCard extends StatelessWidget {
  final IdeaModel idea;
  final bool showDrawButton;

  /// Callback opcional para filtrar el feed por un tag al pulsarlo.
  final ValueChanged<String>? onTagTap;

  /// Lista de tags actualmente activos en el filtro del feed (para estilo "activo").
  final List<String> activeFilterTags;

  const IdeaCard({
    super.key,
    required this.idea,
    this.showDrawButton = true,
    this.onTagTap,
    this.activeFilterTags = const [],
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              idea.content,
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(height: 1.4),
            ),
            // Etiquetas de la idea
            if (idea.tags.isNotEmpty) ...[
              const SizedBox(height: 10),
              Wrap(
                spacing: 6,
                runSpacing: 4,
                children: idea.tags.map((tag) {
                  return TagChip(
                    tag: tag,
                    isActive: activeFilterTags.contains(tag),
                    onTap: onTagTap != null ? () => onTagTap!(tag) : null,
                  );
                }).toList(),
              ),
            ],
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Una idea de un soñador',
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(color: Colors.grey),
                ),
                if (showDrawButton)
                  // [DOC]: Navegación en Flutter. Pasamos parámetros directamente
                  // por el constructor del Widget destino.
                  IconButton(
                    icon: const Icon(Icons.draw_outlined),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DoodleCanvasScreen(
                            ideaId: idea.id,
                            ideaPrompt: idea.content,
                          ),
                        ),
                      );
                    },
                    tooltip: 'Dibujar esta idea',
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
