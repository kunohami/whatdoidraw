import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatdoidraw/features/feed/views/screens/artwork_detail_screen.dart';
import 'package:whatdoidraw/features/interaction/viewmodels/like_viewmodel.dart';
import 'package:whatdoidraw/features/profile/views/screens/profile_screen.dart';
import 'package:whatdoidraw/l10n/app_localizations.dart';
import 'package:whatdoidraw/shared/models/artwork_model.dart';
import 'package:whatdoidraw/shared/widgets/moving_gradient_placeholder.dart';
import 'package:whatdoidraw/shared/widgets/tag_chip.dart';

class ArtworkCard extends ConsumerWidget {
  final ArtworkModel artwork;
  final ValueChanged<String>? onTagTap;
  final List<String> activeFilterTags;
  final bool isClickable;

  const ArtworkCard({
    super.key,
    required this.artwork,
    this.onTagTap,
    this.activeFilterTags = const [],
    this.isClickable = true,
  });

  Future<void> _launchUrl() async {
    final url = Uri.parse(artwork.externalLink);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch ${artwork.externalLink}');
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InkWell(
            onTap: isClickable
                ? () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ArtworkDetailScreen(
                          artworkId: artwork.id,
                          initialArtwork: artwork,
                        ),
                      ),
                    );
                  }
                : null,
            child: Column(
              children: [
                if (artwork.previewUrl != null &&
                    artwork.previewUrl!.isNotEmpty)
                  Image.network(
                    artwork.previewUrl!,
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        const MovingGradientPlaceholder(
                          height: 200,
                          icon: Icons.link_off,
                        ),
                  )
                else
                  const MovingGradientPlaceholder(
                    height: 200,
                    icon: Icons.link,
                  ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ProfileScreen(userId: artwork.userId),
                            ),
                          );
                        },
                        child: Text(
                          AppLocalizations.of(
                            context,
                          )!.sharedBy(artwork.authorName ?? 'unknown'),
                          style: Theme.of(context).textTheme.titleSmall
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                        ),
                      ),
                      if (artwork.tags.isNotEmpty) ...[
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 6,
                          runSpacing: 4,
                          children: artwork.tags.map((tag) {
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
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        artwork.isLiked
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: artwork.isLiked ? Colors.red : null,
                        size: 20,
                      ),
                      onPressed: () {
                        ref
                            .read(likeViewModelProvider.notifier)
                            .toggleArtworkLike(artwork);
                      },
                      tooltip: artwork.isLiked ? 'Quitar like' : 'Dar like',
                      visualDensity: VisualDensity.compact,
                    ),
                    if (artwork.likesCount > 0)
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Text(
                          '${artwork.likesCount}',
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
                IconButton(
                  icon: const Icon(Icons.open_in_new, size: 20),
                  onPressed: _launchUrl,
                  tooltip: 'Abrir enlace externo',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
