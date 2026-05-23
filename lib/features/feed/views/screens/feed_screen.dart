import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:whatdoidraw/features/feed/models/feed_sort_order.dart';
import 'package:whatdoidraw/features/feed/viewmodels/artworks_feed_notifier.dart';
import 'package:whatdoidraw/features/feed/viewmodels/doodles_feed_notifier.dart';
import 'package:whatdoidraw/features/feed/viewmodels/ideas_feed_notifier.dart';
import 'package:whatdoidraw/l10n/app_localizations.dart';
import 'package:whatdoidraw/shared/widgets/artwork_card.dart';
import 'package:whatdoidraw/shared/widgets/doodle_card.dart';
import 'package:whatdoidraw/shared/widgets/idea_card.dart';
import 'package:whatdoidraw/shared/widgets/load_more_button.dart';
import 'package:whatdoidraw/shared/widgets/tag_chip.dart';
import 'package:whatdoidraw/shared/widgets/tutorial_overlay.dart';
import 'package:whatdoidraw/features/notifications/views/screens/notifications_screen.dart';

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
      } else if (tab == 1) {
        ref.read(doodlesFeedProvider.notifier).updateSearch(query);
      } else if (tab == 2) {
        ref.read(artworksFeedProvider.notifier).updateSearch(query);
      }
    });
  }

  void _showFilterSheet() {
    final tab = _tabController.index;
    showModalBottomSheet(
      context: context,
      builder: (context) => Consumer(
        builder: (context, ref, _) {
          final l10n = AppLocalizations.of(context)!;
          // Variables locales para el estado del modal
          String? currentLang;
          FeedSortOrder? currentSort;

          // Obtenemos los valores iniciales según la pestaña activa
          final dynamic currentState = tab == 0
              ? ref.read(ideasFeedProvider)
              : tab == 1
              ? ref.read(doodlesFeedProvider)
              : ref.read(artworksFeedProvider);

          return SafeArea(
            child: StatefulBuilder(
              builder: (context, setModalState) {
                // Inicialización diferida del estado local con el tipo correcto
                currentLang ??= currentState.languageFilter;
                currentSort ??= currentState.sortOrder;

                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        l10n.feedFiltersTitle,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    if (tab == 0)
                      ListTile(
                        leading: const Icon(Icons.language),
                        title: Text(l10n.feedFilterLanguage),
                        trailing: DropdownButton<String>(
                          value: currentLang ?? 'all',
                          underline: const SizedBox(),
                          onChanged: (value) {
                            final newLang = value == 'all' ? null : value;
                            if (tab == 0) {
                              ref
                                  .read(ideasFeedProvider.notifier)
                                  .setLanguageFilter(newLang);
                            } else if (tab == 1) {
                              ref
                                  .read(doodlesFeedProvider.notifier)
                                  .setLanguageFilter(newLang);
                            } else {
                              ref
                                  .read(artworksFeedProvider.notifier)
                                  .setLanguageFilter(newLang);
                            }

                            setModalState(() {
                              currentLang = newLang;
                            });
                          },
                          items: [
                            DropdownMenuItem(
                              value: 'all',
                              child: Text(l10n.feedFilterAll),
                            ),
                            DropdownMenuItem(
                              value: 'es',
                              child: Text(l10n.languageSpanish),
                            ),
                            DropdownMenuItem(
                              value: 'en',
                              child: Text(l10n.languageEnglish),
                            ),
                          ],
                        ),
                      ),
                    ListTile(
                      leading: const Icon(Icons.sort),
                      title: Text(l10n.feedFilterSorting),
                      trailing: DropdownButton<FeedSortOrder>(
                        value: currentSort ?? FeedSortOrder.recent,
                        underline: const SizedBox(),
                        onChanged: (value) {
                          if (value == null) return;
                          setModalState(() {
                            currentSort = value;
                          });
                        },
                        items: [
                          DropdownMenuItem(
                            value: FeedSortOrder.recent,
                            child: Text(l10n.feedSortRecent),
                          ),
                          DropdownMenuItem(
                            value: FeedSortOrder.random,
                            child: Text(l10n.feedSortRandom),
                          ),
                          DropdownMenuItem(
                            value: FeedSortOrder.likes,
                            child: Text(l10n.feedSortPopular),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 8.0,
                      ),
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            if (tab == 0) {
                              final notifier = ref.read(
                                ideasFeedProvider.notifier,
                              );
                              notifier.setLanguageFilter(currentLang);
                              notifier.setSortOrder(
                                currentSort ?? FeedSortOrder.recent,
                              );
                            } else if (tab == 1) {
                              final notifier = ref.read(
                                doodlesFeedProvider.notifier,
                              );
                              notifier.setSortOrder(
                                currentSort ?? FeedSortOrder.recent,
                              );
                            } else {
                              final notifier = ref.read(
                                artworksFeedProvider.notifier,
                              );
                              notifier.setSortOrder(
                                currentSort ?? FeedSortOrder.recent,
                              );
                            }
                            Navigator.pop(context);
                          },
                          child: Text(l10n.feedApplyFilters),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final ideasState = ref.watch(ideasFeedProvider);
    final doodlesState = ref.watch(doodlesFeedProvider);
    final artworksState = ref.watch(artworksFeedProvider);

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.info_outline),
            tooltip: 'Ayuda',
            onPressed: () {
              TutorialOverlay.showFeedInfo(
                context,
                l10n,
                _tabController.index,
              );
            },
          ),
          titleSpacing: 0,
          title: Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: TabBar(
              controller: _tabController,
              labelPadding: EdgeInsets.zero,
              tabs: const [
                Tab(icon: Icon(Icons.lightbulb_outline, size: 20), text: 'Ideas'),
                Tab(icon: Icon(Icons.brush, size: 20), text: 'Doodles'),
                Tab(icon: Icon(Icons.art_track, size: 20), text: 'Artworks'),
              ],
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.notifications_none),
              tooltip: 'Notificaciones',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const NotificationsScreen(),
                  ),
                );
              },
            ),
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 12.0, 8.0, 8.0),
              child: Row(
                children: [
                  Expanded(
                    child: SearchBar(
                      constraints: const BoxConstraints(minHeight: 44, maxHeight: 44),
                      controller: _searchController,
                      hintText: l10n.feedSearchPlaceholder,
                      elevation: WidgetStateProperty.all(0),
                      backgroundColor: WidgetStateProperty.all(
                        Theme.of(context).colorScheme.surfaceContainerHighest
                            .withValues(alpha: 0.5),
                      ),
                      leading: const Icon(Icons.search, size: 20),
                      onChanged: _onSearchChanged,
                      trailing: [
                        if (_searchController.text.isNotEmpty)
                          IconButton(
                            icon: const Icon(Icons.clear, size: 20),
                            onPressed: () {
                              _searchController.clear();
                              _onSearchChanged('');
                            },
                          ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.filter_list),
                    onPressed: _showFilterSheet,
                    tooltip: l10n.feedFiltersTitle,
                  ),
                ],
              ),
            ),
            // Fila de tags activos
            ListenableBuilder(
              listenable: _tabController,
              builder: (context, _) {
                final tab = _tabController.index;
                final activeTags = tab == 0
                    ? ideasState.selectedTags
                    : tab == 1
                    ? doodlesState.selectedTags
                    : artworksState.selectedTags;

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
                                if (tab == 0) {
                                  ref
                                      .read(ideasFeedProvider.notifier)
                                      .toggleTag(tag);
                                } else if (tab == 1) {
                                  ref
                                      .read(doodlesFeedProvider.notifier)
                                      .toggleTag(tag);
                                } else {
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
                          if (tab == 0) {
                            ref.read(ideasFeedProvider.notifier).clearFilters();
                          } else if (tab == 1) {
                            ref
                                .read(doodlesFeedProvider.notifier)
                                .clearFilters();
                          } else {
                            ref
                                .read(artworksFeedProvider.notifier)
                                .clearFilters();
                          }
                        },
                        child: Text(l10n.feedClear),
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
                children: [
                  RefreshIndicator(
                    onRefresh: () async =>
                        ref.read(ideasFeedProvider.notifier).refresh(),
                    child: const _IdeasFeedTab(),
                  ),
                  RefreshIndicator(
                    onRefresh: () async =>
                        ref.read(doodlesFeedProvider.notifier).refresh(),
                    child: const _DoodlesFeedTab(),
                  ),
                  RefreshIndicator(
                    onRefresh: () async =>
                        ref.read(artworksFeedProvider.notifier).refresh(),
                    child: const _ArtworksFeedTab(),
                  ),
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
    final l10n = AppLocalizations.of(context)!;

    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.errorMessage != null) {
      return Center(child: Text('Error: ${state.errorMessage}'));
    }

    if (state.ideas.isEmpty) {
      return Center(child: Text(l10n.feedNoIdeas));
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
    final l10n = AppLocalizations.of(context)!;

    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.errorMessage != null) {
      return Center(child: Text('Error: ${state.errorMessage}'));
    }

    if (state.doodles.isEmpty) {
      return Center(child: Text(l10n.feedNoDoodles));
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
    final l10n = AppLocalizations.of(context)!;

    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.errorMessage != null) {
      return Center(child: Text('Error: ${state.errorMessage}'));
    }

    if (state.artworks.isEmpty) {
      return Center(child: Text(l10n.feedNoArtworks));
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
