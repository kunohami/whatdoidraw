import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:whatdoidraw/features/feed/viewmodels/artwork_detail_notifier.dart';
import 'package:whatdoidraw/features/feed/viewmodels/artworks_feed_notifier.dart';
import 'package:whatdoidraw/features/feed/viewmodels/doodle_detail_artworks_notifier.dart';
import 'package:whatdoidraw/features/feed/viewmodels/doodle_detail_notifier.dart';
import 'package:whatdoidraw/features/feed/viewmodels/doodles_feed_notifier.dart';
import 'package:whatdoidraw/features/feed/viewmodels/idea_detail_notifier.dart';
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
      idea,
      isLiked: !previousIsLiked,
      likesCount: previousIsLiked ? previousCount - 1 : previousCount + 1,
    );

    try {
      await service.toggleLike(itemId: idea.id, type: 'idea_id');
    } catch (e) {
      // Revertir en caso de error
      _updateIdeaInFeed(
        idea,
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
      doodle,
      isLiked: !previousIsLiked,
      likesCount: previousIsLiked ? previousCount - 1 : previousCount + 1,
    );

    try {
      await service.toggleLike(itemId: doodle.id, type: 'doodle_id');
    } catch (e) {
      _updateDoodleInFeed(
        doodle,
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
      artwork,
      isLiked: !previousIsLiked,
      likesCount: previousIsLiked ? previousCount - 1 : previousCount + 1,
    );

    try {
      await service.toggleLike(itemId: artwork.id, type: 'artwork_id');
    } catch (e) {
      _updateArtworkInFeed(
        artwork,
        isLiked: previousIsLiked,
        likesCount: previousCount,
      );
    }
  }

  void _updateIdeaInFeed(
    IdeaModel idea, {
    required bool isLiked,
    required int likesCount,
  }) {
    final id = idea.id;
    final notifier = ref.read(ideasFeedProvider.notifier);
    final currentState = ref.read(ideasFeedProvider);

    final updatedIdeas = currentState.ideas.map((i) {
      if (i.id == id) {
        return i.copyWith(isLiked: isLiked, likesCount: likesCount);
      }
      return i;
    }).toList();

    notifier.updateStateFromLike(updatedIdeas);

    // Update IdeaDetailNotifier
    try {
      ref.read(ideaDetailProvider(id).notifier).updateIdeaLike(
        isLiked: isLiked,
        likesCount: likesCount,
      );
    } catch (_) {}
  }

  void _updateDoodleInFeed(
    DoodleModel doodle, {
    required bool isLiked,
    required int likesCount,
  }) {
    final id = doodle.id;
    final notifier = ref.read(doodlesFeedProvider.notifier);
    final currentState = ref.read(doodlesFeedProvider);

    final updatedDoodles = currentState.doodles.map((d) {
      if (d.id == id) {
        return d.copyWith(isLiked: isLiked, likesCount: likesCount);
      }
      return d;
    }).toList();

    notifier.updateStateFromLike(updatedDoodles);

    // Update DoodleDetailNotifier
    try {
      ref.read(doodleDetailProvider(id).notifier).updateDoodleLike(
        isLiked: isLiked,
        likesCount: likesCount,
      );
    } catch (_) {}

    // Update IdeaDetailNotifier if it has an ideaId
    if (doodle.ideaId != null) {
      try {
        ref.read(ideaDetailProvider(doodle.ideaId!).notifier).updateDoodleLike(
          id,
          isLiked: isLiked,
          likesCount: likesCount,
        );
      } catch (_) {}
    }
  }

  void _updateArtworkInFeed(
    ArtworkModel artwork, {
    required bool isLiked,
    required int likesCount,
  }) {
    final id = artwork.id;
    final notifier = ref.read(artworksFeedProvider.notifier);
    final currentState = ref.read(artworksFeedProvider);

    final updatedArtworks = currentState.artworks.map((a) {
      if (a.id == id) {
        return a.copyWith(isLiked: isLiked, likesCount: likesCount);
      }
      return a;
    }).toList();

    notifier.updateStateFromLike(updatedArtworks);

    // Update ArtworkDetailNotifier
    try {
      ref.read(artworkDetailProvider(id).notifier).updateArtworkLike(
        isLiked: isLiked,
        likesCount: likesCount,
      );
    } catch (_) {}

    // Update IdeaDetailNotifier if it has an ideaId
    if (artwork.ideaId != null) {
      try {
        ref.read(ideaDetailProvider(artwork.ideaId!).notifier).updateArtworkLike(
          id,
          isLiked: isLiked,
          likesCount: likesCount,
        );
      } catch (_) {}
    }

    // Update DoodleDetailArtworksNotifier if it has a doodleId
    if (artwork.doodleId != null) {
      try {
        ref.read(doodleDetailArtworksProvider(artwork.doodleId!).notifier).updateArtworkLike(
          id,
          isLiked: isLiked,
          likesCount: likesCount,
        );
      } catch (_) {}
    }
  }
}
