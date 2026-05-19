import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatdoidraw/features/artworks/presentation/screens/create_artwork_screen.dart';
import 'package:whatdoidraw/features/auth/auth_provider.dart';
import 'package:whatdoidraw/features/content_creation/services/content_creation_service.dart';
import 'package:whatdoidraw/features/content_creation/views/screens/doodle_canvas_screen.dart';
import 'package:whatdoidraw/features/content_creation/views/widgets/doodle_painter.dart';
import 'package:whatdoidraw/features/feed/viewmodels/doodle_detail_artworks_notifier.dart';
import 'package:whatdoidraw/features/feed/viewmodels/doodle_detail_notifier.dart';
import 'package:whatdoidraw/l10n/app_localizations.dart';
import 'package:whatdoidraw/shared/models/doodle_model.dart';
import 'package:whatdoidraw/shared/models/stroke_model.dart';
import 'package:whatdoidraw/shared/widgets/artwork_card.dart';
import 'package:whatdoidraw/shared/widgets/idea_card.dart';
import 'package:whatdoidraw/shared/widgets/load_more_button.dart';

/// Pantalla que presenta un Doodle a tamaño completo con opciones interactivas y su genealogía.
class DoodleDetailScreen extends ConsumerStatefulWidget {
  final DoodleModel doodle;

  const DoodleDetailScreen({super.key, required this.doodle});

  @override
  ConsumerState<DoodleDetailScreen> createState() => _DoodleDetailScreenState();
}

class _DoodleDetailScreenState extends ConsumerState<DoodleDetailScreen> {
  String? _selectedOption;

  @override
  Widget build(BuildContext context) {
    final detailState = ref.watch(doodleDetailProvider(widget.doodle.id));
    final currentUser = ref.watch(authControllerProvider).value;
    final l10n = AppLocalizations.of(context)!;

    // We prefer to use the reactive doodle from notifier once loaded, otherwise fall back to widget.doodle
    final currentDoodle = detailState.doodle ?? widget.doodle;
    final isCreator = currentUser?.id == currentDoodle.userId;

    final strokes = currentDoodle.doodleData
        .map((e) => StrokeModel.fromJson(e as Map<String, dynamic>))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.doodleDetailTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            tooltip: 'Compartir Artwork',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Próximamente: Integración con Redes o Exportar Imagen.',
                  ),
                ),
              );
            },
          ),
          if (isCreator)
            IconButton(
              icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
              tooltip: 'Eliminar dibujo',
              onPressed: () => _confirmDeletion(context, ref, currentDoodle.id),
            ),
        ],
      ),
      body: detailState.isLoading
          ? const Center(child: CircularProgressIndicator())
          : detailState.errorMessage != null
          ? Center(child: Text('Error: ${detailState.errorMessage}'))
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Interactive Doodle Viewer
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Center(
                      child: AspectRatio(
                        aspectRatio: 3 / 4,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.1),
                                blurRadius: 10,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: InteractiveViewer(
                            maxScale: 3.0,
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
                      ),
                    ),
                  ),

                  // Action buttons
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24.0,
                      vertical: 12.0,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: FilledButton.icon(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DoodleCanvasScreen(
                                    ideaId: currentDoodle.ideaId,
                                  ),
                                ),
                              );
                            },
                            icon: const Icon(Icons.brush),
                            label: Text(l10n.btnCreateAnother),
                            style: FilledButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: FilledButton.icon(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CreateArtworkScreen(
                                    doodleId: currentDoodle.id,
                                    initialTags: currentDoodle.tags,
                                  ),
                                ),
                              );
                            },
                            icon: const Icon(Icons.publish_outlined),
                            label: Text(l10n.btnShareArtwork),
                            style: FilledButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              backgroundColor: Theme.of(
                                context,
                              ).colorScheme.tertiary,
                              foregroundColor: Theme.of(
                                context,
                              ).colorScheme.onTertiary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Dropdown Menu with 2 options
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24.0,
                      vertical: 16.0,
                    ),
                    child: InputDecorator(
                      decoration: InputDecoration(
                        labelText: l10n.exploreRelationsLabel,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        prefixIcon: const Icon(Icons.hub_outlined),
                        suffixIcon: _selectedOption != null
                            ? IconButton(
                                icon: const Icon(Icons.clear),
                                onPressed: () {
                                  setState(() {
                                    _selectedOption = null;
                                  });
                                },
                              )
                            : null,
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: _selectedOption,
                          isDense: true,
                          isExpanded: true,
                          hint: Text(l10n.exploreRelationsLabel),
                          items: [
                            if (detailState.parentIdea != null)
                              DropdownMenuItem(
                                value: 'idea',
                                child: Text(l10n.viewOriginalIdeaOption),
                              ),
                            DropdownMenuItem(
                              value: 'artworks',
                              child: Text(l10n.viewSharedArtworksOption),
                            ),
                          ],
                          onChanged: (val) {
                            setState(() {
                              _selectedOption = val;
                            });
                          },
                        ),
                      ),
                    ),
                  ),

                  // Selection content area
                  if (_selectedOption == 'idea' &&
                      detailState.parentIdea != null)
                    Padding(
                      padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                l10n.originalIdeaHeader,
                                style: Theme.of(context).textTheme.titleSmall
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              ),
                              IconButton(
                                icon: const Icon(Icons.visibility_off_outlined),
                                tooltip: 'Ocultar idea',
                                onPressed: () {
                                  setState(() {
                                    _selectedOption = null;
                                  });
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          IdeaCard(
                            idea: detailState.parentIdea!,
                            showDrawButton: true,
                            isClickable: false,
                          ),
                        ],
                      ),
                    ),

                  if (_selectedOption == 'artworks')
                    Consumer(
                      builder: (context, ref, _) {
                        final artworksState = ref.watch(
                          doodleDetailArtworksProvider(currentDoodle.id),
                        );
                        final artworksNotifier = ref.read(
                          doodleDetailArtworksProvider(
                            currentDoodle.id,
                          ).notifier,
                        );

                        return Padding(
                          padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    l10n.sharedArtworksHeader,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall
                                        ?.copyWith(fontWeight: FontWeight.bold),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.close),
                                    onPressed: () {
                                      setState(() {
                                        _selectedOption = null;
                                      });
                                    },
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              if (artworksState.isLoading)
                                const Center(child: CircularProgressIndicator())
                              else if (artworksState.errorMessage != null)
                                Center(
                                  child: Text(
                                    'Error: ${artworksState.errorMessage}',
                                  ),
                                )
                              else if (artworksState.artworks.isEmpty)
                                Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .surfaceContainerHighest
                                        .withValues(alpha: 0.3),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    l10n.emptyDoodleArtworksTitle,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(color: Colors.grey),
                                  ),
                                )
                              else ...[
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: artworksState.artworks.length,
                                  itemBuilder: (context, idx) {
                                    return Padding(
                                      padding: const EdgeInsets.only(
                                        bottom: 12.0,
                                      ),
                                      child: ArtworkCard(
                                        artwork: artworksState.artworks[idx],
                                      ),
                                    );
                                  },
                                ),
                                LoadMoreButton(
                                  hasMore: artworksState.hasMore,
                                  isLoading: artworksState.isLoadingMore,
                                  onPressed: () => artworksNotifier.loadMore(),
                                ),
                              ],
                            ],
                          ),
                        );
                      },
                    ),
                ],
              ),
            ),
    );
  }

  void _confirmDeletion(BuildContext context, WidgetRef ref, String doodleId) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('¿Eliminar Doodle?'),
        content: const Text('Esta acción no se puede deshacer.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: Colors.redAccent),
            onPressed: () async {
              Navigator.pop(ctx);
              try {
                await ref
                    .read(contentCreationServiceProvider)
                    .deleteDoodle(doodleId);

                if (context.mounted) {
                  Navigator.pop(context); // Vuelve atrás tras eliminar
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Doodle eliminado correctamente'),
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
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );
  }
}
