import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:whatdoidraw/features/feed/services/feed_service.dart';
import 'package:whatdoidraw/shared/models/artwork_model.dart';

part 'doodle_detail_artworks_notifier.g.dart';

class DoodleDetailArtworksState {
  final List<ArtworkModel> artworks;
  final bool isLoading;
  final bool isLoadingMore;
  final bool hasMore;
  final String? errorMessage;

  DoodleDetailArtworksState({
    required this.artworks,
    required this.isLoading,
    required this.isLoadingMore,
    required this.hasMore,
    this.errorMessage,
  });

  DoodleDetailArtworksState copyWith({
    List<ArtworkModel>? artworks,
    bool? isLoading,
    bool? isLoadingMore,
    bool? hasMore,
    String? errorMessage,
  }) {
    return DoodleDetailArtworksState(
      artworks: artworks ?? this.artworks,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasMore: hasMore ?? this.hasMore,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

@riverpod
class DoodleDetailArtworksNotifier extends _$DoodleDetailArtworksNotifier {
  @override
  DoodleDetailArtworksState build(String doodleId) {
    _fetchArtworks();
    return DoodleDetailArtworksState(
      artworks: [],
      isLoading: true,
      isLoadingMore: false,
      hasMore: true,
    );
  }

  Future<void> _fetchArtworks() async {
    try {
      final feedService = ref.read(feedServiceProvider);
      final list = await feedService.getArtworksByDoodleId(
        doodleId,
        offset: 0,
        limit: 10,
      );
      state = DoodleDetailArtworksState(
        artworks: list,
        isLoading: false,
        isLoadingMore: false,
        hasMore: list.length == 10,
      );
    } catch (e) {
      state = DoodleDetailArtworksState(
        artworks: [],
        isLoading: false,
        isLoadingMore: false,
        hasMore: false,
        errorMessage: e.toString(),
      );
    }
  }

  Future<void> loadMore() async {
    if (state.isLoadingMore || !state.hasMore) return;
    state = state.copyWith(isLoadingMore: true);
    try {
      final feedService = ref.read(feedServiceProvider);
      final list = await feedService.getArtworksByDoodleId(
        doodleId,
        offset: state.artworks.length,
        limit: 10,
      );
      state = state.copyWith(
        artworks: [...state.artworks, ...list],
        isLoadingMore: false,
        hasMore: list.length == 10,
      );
    } catch (e) {
      state = state.copyWith(isLoadingMore: false, errorMessage: e.toString());
    }
  }

  void updateArtworkLike(
    String artworkId, {
    required bool isLiked,
    required int likesCount,
  }) {
    final updated = state.artworks.map((a) {
      if (a.id == artworkId) {
        return a.copyWith(isLiked: isLiked, likesCount: likesCount);
      }
      return a;
    }).toList();
    state = state.copyWith(artworks: updated);
  }
}
