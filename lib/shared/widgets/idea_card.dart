import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatdoidraw/features/artworks/presentation/screens/create_artwork_screen.dart';
import 'package:whatdoidraw/features/bookmarks/viewmodels/bookmark_viewmodel.dart';
import 'package:whatdoidraw/features/content_creation/views/screens/doodle_canvas_screen.dart';
import 'package:whatdoidraw/features/interaction/viewmodels/like_viewmodel.dart';
import 'package:whatdoidraw/l10n/app_localizations.dart';
import 'package:whatdoidraw/shared/models/idea_model.dart';
import 'package:whatdoidraw/shared/widgets/tag_chip.dart';

/// Widget reutilizable que visualiza una idea de forma estandarizada.
///
/// Encapsula una [IdeaModel] dentro de un [Card]. Se diseñó originalmente para
/// el feed global, pero su parámetro opcional [showDrawButton] permite que sea
/// reutilizado en el perfil sin forzar el inicio de dibujo cuando sólo se desea visualizar.
class IdeaCard extends ConsumerWidget {
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
  Widget build(BuildContext context, WidgetRef ref) {
    final isBookmarked =
        ref.watch(bookmarkedIdeasProvider).value?.any((i) => i.id == idea.id) ??
        false;

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
            const SizedBox(height: 4),
            GestureDetector(
              onTap: () {
                // TODO: Abrir el perfil del usuario (aún no implementado)
              },
              child: Text(
                AppLocalizations.of(
                  context,
                )!.suggestedBy(idea.authorName ?? 'unknown'),
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.w500,
                ),
              ),
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
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        idea.isLiked ? Icons.favorite : Icons.favorite_border,
                        color: idea.isLiked
                            ? Colors.red
                            : Theme.of(context).colorScheme.onSurfaceVariant
                                  .withValues(alpha: 0.7),
                        size: 20,
                      ),
                      onPressed: () {
                        ref
                            .read(likeViewModelProvider.notifier)
                            .toggleIdeaLike(idea);
                      },
                      tooltip: idea.isLiked ? 'Quitar like' : 'Dar like',
                      visualDensity: VisualDensity.compact,
                    ),
                    if (idea.likesCount > 0)
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Text(
                          '${idea.likesCount}',
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                        ),
                      ),
                  ],
                ),
                const Spacer(),
                if (showDrawButton)
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(
                          isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                          color: isBookmarked
                              ? Theme.of(context).colorScheme.primary
                              : null,
                        ),
                        onPressed: () {
                          ref
                              .read(bookmarkedIdeasProvider.notifier)
                              .toggleBookmark(idea);
                        },
                        tooltip: isBookmarked
                            ? 'Quitar guardado'
                            : 'Guardar idea',
                      ),
                      IconButton(
                        icon: const Icon(Icons.publish_outlined),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CreateArtworkScreen(
                                ideaId: idea.id,
                                initialTags: idea.tags,
                              ),
                            ),
                          );
                        },
                        tooltip: 'Publicar Artwork final',
                      ),
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
          ],
        ),
      ),
    );
  }
}
