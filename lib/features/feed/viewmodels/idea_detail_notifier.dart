import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:whatdoidraw/features/feed/services/feed_service.dart';
import 'package:whatdoidraw/shared/models/artwork_model.dart';
import 'package:whatdoidraw/shared/models/doodle_model.dart';
import 'package:whatdoidraw/shared/models/idea_model.dart';

part 'idea_detail_notifier.g.dart';

class IdeaDetailState {
  final IdeaModel? idea;
  final List<dynamic> creations;
  final bool isLoading;
  final String? errorMessage;

  IdeaDetailState({
    this.idea,
    required this.creations,
    required this.isLoading,
    this.errorMessage,
  });

  IdeaDetailState copyWith({
    IdeaModel? idea,
    List<dynamic>? creations,
    bool? isLoading,
    String? errorMessage,
  }) {
    return IdeaDetailState(
      idea: idea ?? this.idea,
      creations: creations ?? this.creations,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

@riverpod
class IdeaDetailNotifier extends _$IdeaDetailNotifier {
  @override
  IdeaDetailState build(String ideaId) {
    _fetchIdeaAndCreations();
    return IdeaDetailState(creations: [], isLoading: true);
  }

  Future<void> _fetchIdeaAndCreations() async {
    try {
      final feedService = ref.read(feedServiceProvider);
      
      // Fetch the idea itself
      final idea = await feedService.getIdeaById(ideaId);
      if (idea == null) {
        state = IdeaDetailState(
          creations: [],
          isLoading: false,
          errorMessage: 'Idea no encontrada',
        );
        return;
      }

      // Fetch derived doodles and artworks
      final doodles = await feedService.getDoodlesByIdeaId(ideaId, limit: 100);
      final artworks = await feedService.getArtworksByIdeaId(ideaId, limit: 100);

      final combined = [...doodles, ...artworks];
      combined.sort((a, b) {
        final dateA = a is DoodleModel ? a.createdAt : (a as ArtworkModel).createdAt;
        final dateB = b is DoodleModel ? b.createdAt : (b as ArtworkModel).createdAt;
        if (dateA == null && dateB == null) return 0;
        if (dateA == null) return 1;
        if (dateB == null) return -1;
        return dateB.compareTo(dateA);
      });

      state = IdeaDetailState(
        idea: idea,
        creations: combined,
        isLoading: false,
      );
    } catch (e) {
      state = IdeaDetailState(
        creations: [],
        isLoading: false,
        errorMessage: e.toString(),
      );
    }
  }

  void updateIdeaLike({required bool isLiked, required int likesCount}) {
    if (state.idea != null) {
      state = state.copyWith(
        idea: state.idea!.copyWith(isLiked: isLiked, likesCount: likesCount),
      );
    }
  }

  void updateDoodleLike(String doodleId, {required bool isLiked, required int likesCount}) {
    final updated = state.creations.map((c) {
      if (c is DoodleModel && c.id == doodleId) {
        return c.copyWith(isLiked: isLiked, likesCount: likesCount);
      }
      return c;
    }).toList();
    state = state.copyWith(creations: updated);
  }

  void updateArtworkLike(String artworkId, {required bool isLiked, required int likesCount}) {
    final updated = state.creations.map((c) {
      if (c is ArtworkModel && c.id == artworkId) {
        return c.copyWith(isLiked: isLiked, likesCount: likesCount);
      }
      return c;
    }).toList();
    state = state.copyWith(creations: updated);
  }
}
