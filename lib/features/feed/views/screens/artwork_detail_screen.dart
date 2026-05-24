import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatdoidraw/features/auth/auth_provider.dart';
import 'package:whatdoidraw/features/content_creation/services/content_creation_service.dart';
import 'package:whatdoidraw/features/feed/viewmodels/artwork_detail_notifier.dart';
import 'package:whatdoidraw/features/feed/viewmodels/artworks_feed_notifier.dart';
import 'package:whatdoidraw/features/feed/viewmodels/doodles_feed_notifier.dart';
import 'package:whatdoidraw/features/feed/viewmodels/ideas_feed_notifier.dart';
import 'package:whatdoidraw/features/interaction/viewmodels/like_viewmodel.dart';
import 'package:whatdoidraw/features/profile/views/screens/profile_screen.dart';
import 'package:whatdoidraw/l10n/app_localizations.dart';
import 'package:whatdoidraw/shared/models/artwork_model.dart';
import 'package:whatdoidraw/shared/widgets/doodle_card.dart';
import 'package:whatdoidraw/shared/widgets/idea_card.dart';
import 'package:whatdoidraw/shared/widgets/moving_gradient_placeholder.dart';
import 'package:whatdoidraw/shared/widgets/tag_chip.dart';

class ArtworkDetailScreen extends ConsumerWidget {
  final String artworkId;
  final ArtworkModel initialArtwork;

  const ArtworkDetailScreen({
    super.key,
    required this.artworkId,
    required this.initialArtwork,
  });

  Future<void> _launchUrl(String urlString) async {
    final url = Uri.parse(urlString);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $urlString');
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(artworkDetailProvider(artworkId));
    final currentArtwork = state.artwork ?? initialArtwork;
    final currentUser = ref.watch(authControllerProvider).value;
    final l10n = AppLocalizations.of(context)!;

    final isCreator = currentUser?.id == currentArtwork.userId;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.artworkDetailTitle),
        actions: [
          if (isCreator)
            IconButton(
              icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
              tooltip: l10n.deleteArtworkTooltip,
              onPressed: () => _confirmDeletion(context, ref, currentArtwork.id),
            ),
        ],
      ),
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : state.errorMessage != null
          ? Center(child: Text('Error: ${state.errorMessage}'))
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Preview or premium placeholder
                  if (currentArtwork.previewUrl != null &&
                      currentArtwork.previewUrl!.isNotEmpty)
                    Image.network(
                      currentArtwork.previewUrl!,
                      height: 300,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          MovingGradientPlaceholder(
                            height: 300,
                            icon: Icons.link_off,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const FloatingIcon(icon: Icons.link_off),
                                const SizedBox(height: 16),
                                Text(
                                  l10n.previewError,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    shadows: [
                                      Shadow(
                                        blurRadius: 8,
                                        color: Colors.black45,
                                        offset: Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                    )
                  else
                    MovingGradientPlaceholder(
                      height: 300,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const FloatingIcon(icon: Icons.link),
                          const SizedBox(height: 16),
                          Text(
                            l10n.externalPlatformTitle,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              shadows: [
                                Shadow(
                                  blurRadius: 8,
                                  color: Colors.black45,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            l10n.viewOnPlatform(
                              Uri.parse(currentArtwork.externalLink).host,
                            ),
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.85),
                              fontSize: 14,
                              shadows: const [
                                Shadow(
                                  blurRadius: 8,
                                  color: Colors.black45,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                  // Info card & buttons (similar to ArtworkCard)
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProfileScreen(
                                  userId: currentArtwork.userId,
                                ),
                              ),
                            );
                          },
                          child: Text(
                            l10n.sharedBy(
                              currentArtwork.authorName ?? 'unknown',
                            ),
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        if (currentArtwork.tags.isNotEmpty) ...[
                          Wrap(
                            spacing: 8,
                            runSpacing: 6,
                            children: currentArtwork.tags.map((tag) {
                              return TagChip(tag: tag, isActive: false);
                            }).toList(),
                          ),
                          const SizedBox(height: 16),
                        ],

                        // Actions: Likes & Open link
                        Row(
                          children: [
                            Row(
                              children: [
                                IconButton(
                                  icon: Icon(
                                    currentArtwork.isLiked
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color: currentArtwork.isLiked
                                        ? Colors.red
                                        : null,
                                    size: 28,
                                  ),
                                  onPressed: () {
                                    ref
                                        .read(likeViewModelProvider.notifier)
                                        .toggleArtworkLike(currentArtwork);
                                  },
                                  tooltip: currentArtwork.isLiked
                                      ? 'Quitar like'
                                      : 'Dar like',
                                ),
                                if (currentArtwork.likesCount > 0)
                                  Padding(
                                    padding: const EdgeInsets.only(left: 4.0),
                                    child: Text(
                                      '${currentArtwork.likesCount}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                  ),
                              ],
                            ),
                            const Spacer(),
                            ElevatedButton.icon(
                              onPressed: () =>
                                  _launchUrl(currentArtwork.externalLink),
                              icon: const Icon(Icons.open_in_new),
                              label: Text(l10n.viewOriginalArtwork),
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 12,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const Divider(height: 1),

                  // Lineage Section (Parent creations)
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.inspirationGenealogyTitle,
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 16),

                        // If Doodle was the direct parent
                        if (currentArtwork.doodleId != null) ...[
                          // Case 1: Doodle based on Idea (shows both)
                          if (state.parentDoodle != null) ...[
                            if (state.doodleParentIdea != null) ...[
                              Text(
                                l10n.seedIdeaTraceTitle,
                                style: Theme.of(context).textTheme.bodyMedium
                                    ?.copyWith(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey[600],
                                    ),
                              ),
                              const SizedBox(height: 8),
                              IdeaCard(
                                idea: state.doodleParentIdea!,
                                showDrawButton: true,
                                isClickable: false,
                              ),
                              const SizedBox(height: 16),
                            ],

                            Text(
                              state.doodleParentIdea != null
                                  ? l10n.doodleTraceTitle
                                  : l10n.singleDoodleTraceTitle,
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey[600],
                                  ),
                            ),
                            const SizedBox(height: 8),
                            SizedBox(
                              height: 300,
                              child: DoodleCard(doodle: state.parentDoodle!),
                            ),
                          ] else ...[
                            // Doodle is deleted!
                            Text(
                              l10n.singleDoodleTraceTitle,
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey[600],
                                  ),
                            ),
                            const SizedBox(height: 8),
                            _buildDeletedPlaceholder(
                              context,
                              l10n.deletedDoodlePlaceholder,
                            ),
                          ],
                        ]
                        // If Idea was the direct parent (no Doodle)
                        else if (currentArtwork.ideaId != null) ...[
                          Text(
                            l10n.originalIdeaHeader,
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey[600],
                                ),
                          ),
                          const SizedBox(height: 8),
                          if (state.parentIdea != null)
                            IdeaCard(
                              idea: state.parentIdea!,
                              showDrawButton: true,
                              isClickable: false,
                            )
                          else
                            _buildDeletedPlaceholder(
                              context,
                              l10n.deletedIdeaPlaceholder,
                            ),
                        ]
                        // No lineage registered
                        else ...[
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .colorScheme
                                  .surfaceContainerHighest
                                  .withValues(alpha: 0.3),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              l10n.independentArtworkText,
                              textAlign: TextAlign.center,
                              style: const TextStyle(color: Colors.grey),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildDeletedPlaceholder(BuildContext context, String message) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: colorScheme.outlineVariant.withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.info_outline,
            color: colorScheme.secondary,
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                    fontStyle: FontStyle.italic,
                  ),
            ),
          ),
        ],
      ),
    );
  }

  void _confirmDeletion(BuildContext context, WidgetRef ref, String artworkId) {
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.deleteArtworkDialogTitle),
        content: Text(l10n.deleteArtworkDialogContent),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(l10n.btnCancel),
          ),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: Colors.redAccent),
            onPressed: () async {
              Navigator.pop(ctx);
              try {
                await ref
                    .read(contentCreationServiceProvider)
                    .deleteArtwork(artworkId);

                // Invalidate all relevant feeds so they refresh
                ref.invalidate(ideasFeedProvider);
                ref.invalidate(doodlesFeedProvider);
                ref.invalidate(artworksFeedProvider);

                if (context.mounted) {
                  Navigator.pop(context); // Vuelve atrás tras eliminar
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(l10n.deleteArtworkSuccess),
                    ),
                  );
                }
              } catch (e) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error al eliminar: $e')),
                  );
                }
              }
            },
            child: Text(l10n.btnDelete),
          ),
        ],
      ),
    );
  }
}
