import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:whatdoidraw/features/feed/models/feed_sort_order.dart';
import 'package:whatdoidraw/features/feed/viewmodels/artworks_feed_notifier.dart';
import 'package:whatdoidraw/features/feed/viewmodels/doodles_feed_notifier.dart';
import 'package:whatdoidraw/features/feed/viewmodels/ideas_feed_notifier.dart';
import 'package:whatdoidraw/shared/widgets/artwork_card.dart';
import 'package:whatdoidraw/shared/widgets/doodle_card.dart';
import 'package:whatdoidraw/shared/widgets/idea_card.dart';
import 'package:whatdoidraw/shared/widgets/load_more_button.dart';
import 'package:whatdoidraw/shared/widgets/tag_chip.dart';

/// Pantalla principal de Exploración ("Feed").
///
/// Divide el contenido público en tres categorías principales mediante pestañas:
/// Ideas, Doodles y Artworks (futuro). Incluye barra de búsqueda (Ideas),
/// filtrado por tags, ordenación y paginación con botón "Ver más".
class FeedScreen extends ConsumerStatefulWidget {
  const FeedScreen({super.key});

  @override
  ConsumerState<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends ConsumerState<FeedScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _searchController = TextEditingController();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 400), () {
      final tab = _tabController.index;
      if (tab == 0) {
        ref.read(ideasFeedProvider.notifier).updateSearch(query);
      } else if (tab == 2) {
        ref.read(artworksFeedProvider.notifier).updateSearch(query);
      }
    });
  }

  void _onRefresh() {
    final tab = _tabController.index;
    if (tab == 0) {
      ref.read(ideasFeedProvider.notifier).refresh();
    } else if (tab == 1) {
      ref.read(doodlesFeedProvider.notifier).refresh();
    } else if (tab == 2) {
      ref.read(artworksFeedProvider.notifier).refresh();
    }
  }

  void _onToggleSort() {
    final tab = _tabController.index;
    if (tab == 0) {
      ref.read(ideasFeedProvider.notifier).toggleSortOrder();
    } else if (tab == 1) {
      ref.read(doodlesFeedProvider.notifier).toggleSortOrder();
    } else if (tab == 2) {
      ref.read(artworksFeedProvider.notifier).toggleSortOrder();
    }
  }

  @override
  Widget build(BuildContext context) {
    final ideasState = ref.watch(ideasFeedProvider);
    final doodlesState = ref.watch(doodlesFeedProvider);
    final artworksState = ref.watch(artworksFeedProvider);

    // Determinamos el sort order según la pestaña activa para el icono del botón.
    final currentSort = _tabController.index == 0
        ? ideasState.sortOrder
        : _tabController.index == 1
        ? doodlesState.sortOrder
        : artworksState.sortOrder;

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Descubrimiento'),
          centerTitle: true,
          actions: [
            // Toggle de ordenación (solo en pestañas Ideas y Doodles)
            ListenableBuilder(
              listenable: _tabController,
              builder: (context, _) {
                if (_tabController.index == 2) return const SizedBox.shrink();
                return IconButton(
                  icon: Icon(
                    currentSort == FeedSortOrder.recent
                        ? Icons.access_time
                        : Icons.shuffle,
                    color: currentSort == FeedSortOrder.random
                        ? Theme.of(context).colorScheme.primary
                        : null,
                  ),
                  tooltip: currentSort == FeedSortOrder.recent
                      ? 'Cambiar a orden aleatorio'
                      : 'Cambiar a orden por fecha',
                  onPressed: _onToggleSort,
                );
              },
            ),
            // Botón de actualizar
            IconButton(
              icon: const Icon(Icons.refresh),
              tooltip: 'Actualizar',
              onPressed: _onRefresh,
            ),
          ],
          bottom: TabBar(
            controller: _tabController,
            tabs: const [
              Tab(icon: Icon(Icons.lightbulb_outline), text: 'Ideas'),
              Tab(icon: Icon(Icons.brush), text: 'Doodles'),
              Tab(icon: Icon(Icons.art_track), text: 'Artworks'),
            ],
          ),
        ),
        body: Column(
          children: [
            // Barra de búsqueda (solo para Ideas)
            ListenableBuilder(
              listenable: _tabController,
              builder: (context, _) {
                if (_tabController.index == 1) return const SizedBox.shrink();
                final isArtworks = _tabController.index == 2;
                return Padding(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                  child: SearchBar(
                    controller: _searchController,
                    hintText: isArtworks
                        ? 'Buscar por artista o tag...'
                        : 'Buscar ideas...',
                    leading: const Icon(Icons.search),
                    trailing: [
                      if (_searchController.text.isNotEmpty)
                        IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            _searchController.clear();
                            if (isArtworks) {
                              ref
                                  .read(artworksFeedProvider.notifier)
                                  .updateSearch('');
                            } else {
                              ref
                                  .read(ideasFeedProvider.notifier)
                                  .updateSearch('');
                            }
                          },
                        ),
                    ],
                    onChanged: _onSearchChanged,
                  ),
                );
              },
            ),
            // Fila de tags activos (Ideas)
            ListenableBuilder(
              listenable: _tabController,
              builder: (context, _) {
                final isIdeasTab = _tabController.index == 0;
                final isDoodlesTab = _tabController.index == 1;
                final isArtworksTab = _tabController.index == 2;

                final activeTags = isIdeasTab
                    ? ideasState.selectedTags
                    : isDoodlesTab
                    ? doodlesState.selectedTags
                    : isArtworksTab
                    ? artworksState.selectedTags
                    : <String>[];

                if (activeTags.isEmpty) return const SizedBox.shrink();

                return Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Wrap(
                          spacing: 6,
                          children: activeTags.map((tag) {
                            return TagChip(
                              tag: tag,
                              isActive: true,
                              onTap: () {
                                if (isIdeasTab) {
                                  ref
                                      .read(ideasFeedProvider.notifier)
                                      .toggleTag(tag);
                                } else if (isDoodlesTab) {
                                  ref
                                      .read(doodlesFeedProvider.notifier)
                                      .toggleTag(tag);
                                } else if (isArtworksTab) {
                                  ref
                                      .read(artworksFeedProvider.notifier)
                                      .toggleTag(tag);
                                }
                              },
                            );
                          }).toList(),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          if (isIdeasTab) {
                            ref.read(ideasFeedProvider.notifier).clearFilters();
                          } else if (isDoodlesTab) {
                            ref
                                .read(doodlesFeedProvider.notifier)
                                .clearFilters();
                          } else if (isArtworksTab) {
                            ref
                                .read(artworksFeedProvider.notifier)
                                .clearFilters();
                          }
                        },
                        child: const Text('Limpiar'),
                      ),
                    ],
                  ),
                );
              },
            ),
            // Contenido de las pestañas
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: const [
                  _IdeasFeedTab(),
                  _DoodlesFeedTab(),
                  _ArtworksFeedTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Pestaña de Ideas con lista paginada, búsqueda y filtro por tags.
class _IdeasFeedTab extends ConsumerWidget {
  const _IdeasFeedTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(ideasFeedProvider);
    final notifier = ref.read(ideasFeedProvider.notifier);

    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.errorMessage != null) {
      return Center(child: Text('Error: ${state.errorMessage}'));
    }

    if (state.ideas.isEmpty) {
      return const Center(child: Text('No hay ideas que coincidan.'));
    }

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      itemCount: state.ideas.length + 1, // +1 para el botón "Ver más"
      itemBuilder: (context, index) {
        if (index == state.ideas.length) {
          return LoadMoreButton(
            hasMore: state.hasMore,
            isLoading: state.isLoadingMore,
            isRandomMode: state.sortOrder == FeedSortOrder.random,
            onPressed: () => notifier.loadMore(),
          );
        }
        return IdeaCard(
          idea: state.ideas[index],
          activeFilterTags: state.selectedTags,
          onTagTap: (tag) => notifier.toggleTag(tag),
        );
      },
    );
  }
}

/// Pestaña de Doodles con grid paginado y filtro por tags.
class _DoodlesFeedTab extends ConsumerWidget {
  const _DoodlesFeedTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(doodlesFeedProvider);
    final notifier = ref.read(doodlesFeedProvider.notifier);

    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.errorMessage != null) {
      return Center(child: Text('Error: ${state.errorMessage}'));
    }

    if (state.doodles.isEmpty) {
      return const Center(child: Text('No hay doodles que coincidan.'));
    }

    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.all(16),
          sliver: SliverGrid(
            delegate: SliverChildBuilderDelegate(
              (context, index) => DoodleCard(
                doodle: state.doodles[index],
                activeFilterTags: state.selectedTags,
                onTagTap: (tag) => notifier.toggleTag(tag),
              ),
              childCount: state.doodles.length,
            ),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 0.75,
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: LoadMoreButton(
            hasMore: state.hasMore,
            isLoading: state.isLoadingMore,
            isRandomMode: state.sortOrder == FeedSortOrder.random,
            onPressed: () => notifier.loadMore(),
          ),
        ),
      ],
    );
  }
}

/// Pestaña de Artworks con lista paginada y búsqueda.
class _ArtworksFeedTab extends ConsumerWidget {
  const _ArtworksFeedTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(artworksFeedProvider);
    final notifier = ref.read(artworksFeedProvider.notifier);

    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.errorMessage != null) {
      return Center(child: Text('Error: ${state.errorMessage}'));
    }

    if (state.artworks.isEmpty) {
      return const Center(child: Text('No hay obras que coincidan.'));
    }

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      itemCount: state.artworks.length + 1,
      itemBuilder: (context, index) {
        if (index == state.artworks.length) {
          return LoadMoreButton(
            hasMore: state.hasMore,
            isLoading: state.isLoadingMore,
            isRandomMode: state.sortOrder == FeedSortOrder.random,
            onPressed: () => notifier.loadMore(),
          );
        }
        return ArtworkCard(
          artwork: state.artworks[index],
          activeFilterTags: state.selectedTags,
          onTagTap: (tag) => notifier.toggleTag(tag),
        );
      },
    );
  }
}
