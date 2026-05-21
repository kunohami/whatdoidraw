import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatdoidraw/features/bookmarks/viewmodels/bookmark_viewmodel.dart';
import 'package:whatdoidraw/features/content_creation/views/widgets/doodle_painter.dart';
import 'package:whatdoidraw/features/feed/views/screens/doodle_detail_screen.dart';
import 'package:whatdoidraw/features/interaction/viewmodels/like_viewmodel.dart';
import 'package:whatdoidraw/features/profile/views/screens/profile_screen.dart';
import 'package:whatdoidraw/l10n/app_localizations.dart';
import 'package:whatdoidraw/shared/models/doodle_model.dart';
import 'package:whatdoidraw/shared/models/stroke_model.dart';
import 'package:whatdoidraw/shared/widgets/tag_chip.dart';

/// Widget reutilizable que renderiza una miniatura de un [DoodleModel].
///
/// Utiliza un [CustomPaint] sobre el motor nativo para redibujar los trazos.
/// Al tocar la tarjeta, navega hacia la vista de detalles.
/// Los tags se muestran como un overlay en la parte inferior de la tarjeta.
class DoodleCard extends ConsumerWidget {
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
  Widget build(BuildContext context, WidgetRef ref) {
    final isBookmarked =
        ref
            .watch(bookmarkedDoodlesProvider)
            .value
            ?.any((d) => d.id == doodle.id) ??
        false;

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
            // Overlay de autor y tags en la parte inferior de la tarjeta
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.black.withValues(alpha: 0.7),
                      Colors.transparent,
                    ],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ProfileScreen(userId: doodle.userId),
                          ),
                        );
                      },
                      child: Text(
                        AppLocalizations.of(
                          context,
                        )!.doodledBy(doodle.authorName ?? 'unknown'),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          shadows: [
                            const Shadow(
                              offset: Offset(0, 1),
                              blurRadius: 2,
                              color: Colors.black54,
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (doodle.tags.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Wrap(
                        spacing: 4,
                        runSpacing: 2,
                        children: doodle.tags.take(3).map((tag) {
                          return TagChip(
                            tag: tag,
                            isActive: activeFilterTags.contains(tag),
                            onTap: onTagTap != null
                                ? () => onTagTap!(tag)
                                : null,
                          );
                        }).toList(),
                      ),
                    ],
                  ],
                ),
              ),
            ),
            Positioned(
              top: 4,
              left: 4,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.8),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(
                        doodle.isLiked ? Icons.favorite : Icons.favorite_border,
                        size: 20,
                        color: doodle.isLiked ? Colors.red : null,
                      ),
                      onPressed: () {
                        ref
                            .read(likeViewModelProvider.notifier)
                            .toggleDoodleLike(doodle);
                      },
                      tooltip: doodle.isLiked ? 'Quitar like' : 'Dar like',
                      constraints: const BoxConstraints(),
                      padding: const EdgeInsets.all(8),
                    ),
                    if (doodle.likesCount > 0)
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Text(
                          '${doodle.likesCount}',
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                        ),
                      ),
                  ],
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
                  icon: Icon(
                    isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                    size: 20,
                    color: isBookmarked
                        ? Theme.of(context).colorScheme.primary
                        : null,
                  ),
                  onPressed: () {
                    ref
                        .read(bookmarkedDoodlesProvider.notifier)
                        .toggleBookmark(doodle);
                  },
                  tooltip: isBookmarked ? 'Quitar guardado' : 'Guardar doodle',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
