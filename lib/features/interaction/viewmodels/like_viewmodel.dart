import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:whatdoidraw/features/feed/viewmodels/artworks_feed_notifier.dart';
import 'package:whatdoidraw/features/feed/viewmodels/doodles_feed_notifier.dart';
import 'package:whatdoidraw/features/feed/viewmodels/ideas_feed_notifier.dart';
import 'package:whatdoidraw/features/interaction/data/services/like_service.dart';
import 'package:whatdoidraw/shared/models/artwork_model.dart';
import 'package:whatdoidraw/shared/models/doodle_model.dart';
import 'package:whatdoidraw/shared/models/idea_model.dart';

part 'like_viewmodel.g.dart';

@riverpod
class LikeViewModel extends _$LikeViewModel {
  @override
  void build() {}

  /// Alterna el like de una Idea y actualiza el estado del feed de forma optimista.
  Future<void> toggleIdeaLike(IdeaModel idea) async {
    final service = ref.read(likeServiceProvider);
    final previousIsLiked = idea.isLiked;
    final previousCount = idea.likesCount;

    // Actualización optimista en el feed
    _updateIdeaInFeed(
      idea.id,
      isLiked: !previousIsLiked,
      likesCount: previousIsLiked ? previousCount - 1 : previousCount + 1,
    );

    try {
      await service.toggleLike(itemId: idea.id, type: 'idea_id');
    } catch (e) {
      // Revertir en caso de error
      _updateIdeaInFeed(
        idea.id,
        isLiked: previousIsLiked,
        likesCount: previousCount,
      );
    }
  }

  /// Alterna el like de un Doodle y actualiza el estado del feed de forma optimista.
  Future<void> toggleDoodleLike(DoodleModel doodle) async {
    final service = ref.read(likeServiceProvider);
    final previousIsLiked = doodle.isLiked;
    final previousCount = doodle.likesCount;

    _updateDoodleInFeed(
      doodle.id,
      isLiked: !previousIsLiked,
      likesCount: previousIsLiked ? previousCount - 1 : previousCount + 1,
    );

    try {
      await service.toggleLike(itemId: doodle.id, type: 'doodle_id');
    } catch (e) {
      _updateDoodleInFeed(
        doodle.id,
        isLiked: previousIsLiked,
        likesCount: previousCount,
      );
    }
  }

  /// Alterna el like de un Artwork y actualiza el estado del feed de forma optimista.
  Future<void> toggleArtworkLike(ArtworkModel artwork) async {
    final service = ref.read(likeServiceProvider);
    final previousIsLiked = artwork.isLiked;
    final previousCount = artwork.likesCount;

    _updateArtworkInFeed(
      artwork.id,
      isLiked: !previousIsLiked,
      likesCount: previousIsLiked ? previousCount - 1 : previousCount + 1,
    );

    try {
      await service.toggleLike(itemId: artwork.id, type: 'artwork_id');
    } catch (e) {
      _updateArtworkInFeed(
        artwork.id,
        isLiked: previousIsLiked,
        likesCount: previousCount,
      );
    }
  }

  void _updateIdeaInFeed(String id, {required bool isLiked, required int likesCount}) {
    final notifier = ref.read(ideasFeedProvider.notifier);
    final currentState = ref.read(ideasFeedProvider);
    
    final updatedIdeas = currentState.ideas.map((i) {
      if (i.id == id) {
        return i.copyWith(isLiked: isLiked, likesCount: likesCount);
      }
      return i;
    }).toList();

    notifier.updateStateFromLike(updatedIdeas);
  }

  void _updateDoodleInFeed(String id, {required bool isLiked, required int likesCount}) {
    final notifier = ref.read(doodlesFeedProvider.notifier);
    final currentState = ref.read(doodlesFeedProvider);
    
    final updatedDoodles = currentState.doodles.map((d) {
      if (d.id == id) {
        return d.copyWith(isLiked: isLiked, likesCount: likesCount);
      }
      return d;
    }).toList();

    notifier.updateStateFromLike(updatedDoodles);
  }

  void _updateArtworkInFeed(String id, {required bool isLiked, required int likesCount}) {
    final notifier = ref.read(artworksFeedProvider.notifier);
    final currentState = ref.read(artworksFeedProvider);
    
    final updatedArtworks = currentState.artworks.map((a) {
      if (a.id == id) {
        return a.copyWith(isLiked: isLiked, likesCount: likesCount);
      }
      return a;
    }).toList();

    notifier.updateStateFromLike(updatedArtworks);
  }
}
