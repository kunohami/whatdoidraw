import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:whatdoidraw/core/constants/feed_constants.dart';
import 'package:whatdoidraw/features/feed/models/feed_sort_order.dart';
import 'package:whatdoidraw/features/feed/services/feed_service.dart';
import 'package:whatdoidraw/shared/models/artwork_model.dart';

part 'artworks_feed_notifier.g.dart';

/// Estado para la pestaña de Artworks del Feed.
class ArtworksFeedState {
  final List<ArtworkModel> artworks;
  final bool hasMore;
  final bool isLoading;
  final bool isLoadingMore;
  final String searchQuery;
  final List<String> selectedTags;
  final FeedSortOrder sortOrder;
  final String? errorMessage;

  const ArtworksFeedState({
    this.artworks = const [],
    this.hasMore = true,
    this.isLoading = false,
    this.isLoadingMore = false,
    this.searchQuery = '',
    this.selectedTags = const [],
    this.sortOrder = FeedSortOrder.recent,
    this.errorMessage,
  });

  ArtworksFeedState copyWith({
    List<ArtworkModel>? artworks,
    bool? hasMore,
    bool? isLoading,
    bool? isLoadingMore,
    String? searchQuery,
    List<String>? selectedTags,
    FeedSortOrder? sortOrder,
    String? errorMessage,
  }) {
    return ArtworksFeedState(
      artworks: artworks ?? this.artworks,
      hasMore: hasMore ?? this.hasMore,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      searchQuery: searchQuery ?? this.searchQuery,
      selectedTags: selectedTags ?? this.selectedTags,
      sortOrder: sortOrder ?? this.sortOrder,
      errorMessage: errorMessage,
    );
  }
}

@riverpod
class ArtworksFeed extends _$ArtworksFeed {
  int _offset = 0;

  @override
  ArtworksFeedState build() {
    Future.microtask(loadInitial);
    return const ArtworksFeedState();
  }

  Future<void> loadInitial() async {
    _offset = 0;
    state = state.copyWith(isLoading: true, artworks: [], errorMessage: null);
    try {
      final artworks = await ref.read(feedServiceProvider).fetchArtworks(
            offset: 0,
            query: state.searchQuery,
            tags: state.selectedTags,
            sort: state.sortOrder,
          );
      _offset = artworks.length;
      state = state.copyWith(
        artworks: artworks,
        isLoading: false,
        hasMore: artworks.length >= 10, // Usando el valor por defecto del servicio
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  Future<void> loadMore() async {
    if (!state.hasMore || state.isLoadingMore || state.isLoading) return;
    if (state.sortOrder == FeedSortOrder.random) {
      await loadInitial();
      return;
    }
    state = state.copyWith(isLoadingMore: true);
    try {
      final newArtworks = await ref.read(feedServiceProvider).fetchArtworks(
            offset: _offset,
            query: state.searchQuery,
            tags: state.selectedTags,
            sort: state.sortOrder,
          );
      _offset += newArtworks.length;
      state = state.copyWith(
        artworks: [...state.artworks, ...newArtworks],
        isLoadingMore: false,
        hasMore: newArtworks.length >= 10,
      );
    } catch (e) {
      state = state.copyWith(isLoadingMore: false, errorMessage: e.toString());
    }
  }

  Future<void> updateSearch(String query) async {
    state = state.copyWith(searchQuery: query);
    await loadInitial();
  }

  Future<void> toggleTag(String tag) async {
    final current = List<String>.from(state.selectedTags);
    if (current.contains(tag)) {
      current.remove(tag);
    } else {
      current.add(tag);
    }
    state = state.copyWith(selectedTags: current);
    await loadInitial();
  }

  Future<void> toggleSortOrder() async {
    final newOrder = state.sortOrder == FeedSortOrder.recent
        ? FeedSortOrder.random
        : FeedSortOrder.recent;
    state = state.copyWith(sortOrder: newOrder);
    await loadInitial();
  }

  Future<void> clearFilters() async {
    state = state.copyWith(
      searchQuery: '',
      selectedTags: [],
      sortOrder: FeedSortOrder.recent,
    );
    await loadInitial();
  }

  Future<void> refresh() async => loadInitial();
}
