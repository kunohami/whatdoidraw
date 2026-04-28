import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatdoidraw/shared/models/artwork_model.dart';
import 'package:whatdoidraw/shared/widgets/tag_chip.dart';

class ArtworkCard extends StatelessWidget {
  final ArtworkModel artwork;
  final ValueChanged<String>? onTagTap;
  final List<String> activeFilterTags;

  const ArtworkCard({
    super.key,
    required this.artwork,
    this.onTagTap,
    this.activeFilterTags = const [],
  });

  Future<void> _launchUrl() async {
    final url = Uri.parse(artwork.externalLink);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch ${artwork.externalLink}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 2,
      child: InkWell(
        onTap: _launchUrl,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (artwork.previewUrl != null)
              Image.network(
                artwork.previewUrl!,
                height: 200,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 200,
                  color: Colors.grey[200],
                  child: const Icon(Icons.broken_image, color: Colors.grey),
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Obra de ${artwork.authorName ?? "Artista desconocido"}',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
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
                          onTap: onTagTap != null ? () => onTagTap!(tag) : null,
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
    );
  }
}
