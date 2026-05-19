import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:whatdoidraw/features/feed/services/feed_service.dart';
import 'package:whatdoidraw/shared/models/artwork_model.dart';
import 'package:whatdoidraw/shared/models/doodle_model.dart';
import 'package:whatdoidraw/shared/models/idea_model.dart';

part 'artwork_detail_notifier.g.dart';

class ArtworkDetailState {
  final ArtworkModel? artwork;
  final IdeaModel? parentIdea;
  final DoodleModel? parentDoodle;
  final IdeaModel? doodleParentIdea;
  final bool isLoading;
  final String? errorMessage;

  ArtworkDetailState({
    this.artwork,
    this.parentIdea,
    this.parentDoodle,
    this.doodleParentIdea,
    required this.isLoading,
    this.errorMessage,
  });

  ArtworkDetailState copyWith({
    ArtworkModel? artwork,
    IdeaModel? parentIdea,
    DoodleModel? parentDoodle,
    IdeaModel? doodleParentIdea,
    bool? isLoading,
    String? errorMessage,
  }) {
    return ArtworkDetailState(
      artwork: artwork ?? this.artwork,
      parentIdea: parentIdea ?? this.parentIdea,
      parentDoodle: parentDoodle ?? this.parentDoodle,
      doodleParentIdea: doodleParentIdea ?? this.doodleParentIdea,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

@riverpod
class ArtworkDetailNotifier extends _$ArtworkDetailNotifier {
  @override
  ArtworkDetailState build(String artworkId) {
    _fetchArtworkAndLineage();
    return ArtworkDetailState(isLoading: true);
  }

  Future<void> _fetchArtworkAndLineage() async {
    try {
      final feedService = ref.read(feedServiceProvider);
      final artwork = await feedService.getArtworkById(artworkId);
      if (artwork == null) {
        state = ArtworkDetailState(
          isLoading: false,
          errorMessage: 'Artwork no encontrado',
        );
        return;
      }

      IdeaModel? parentIdea;
      DoodleModel? parentDoodle;
      IdeaModel? doodleParentIdea;

      if (artwork.doodleId != null) {
        parentDoodle = await feedService.getDoodleById(artwork.doodleId!);
        if (parentDoodle != null && parentDoodle.ideaId != null) {
          doodleParentIdea = await feedService.getIdeaById(
            parentDoodle.ideaId!,
          );
        }
      } else if (artwork.ideaId != null) {
        parentIdea = await feedService.getIdeaById(artwork.ideaId!);
      }

      state = ArtworkDetailState(
        artwork: artwork,
        parentIdea: parentIdea,
        parentDoodle: parentDoodle,
        doodleParentIdea: doodleParentIdea,
        isLoading: false,
      );
    } catch (e) {
      state = ArtworkDetailState(isLoading: false, errorMessage: e.toString());
    }
  }

  void updateArtworkLike({required bool isLiked, required int likesCount}) {
    if (state.artwork != null) {
      state = state.copyWith(
        artwork: state.artwork!.copyWith(
          isLiked: isLiked,
          likesCount: likesCount,
        ),
      );
    }
  }

  void updateIdeaLike(
    String ideaId, {
    required bool isLiked,
    required int likesCount,
  }) {
    if (state.parentIdea?.id == ideaId) {
      state = state.copyWith(
        parentIdea: state.parentIdea!.copyWith(
          isLiked: isLiked,
          likesCount: likesCount,
        ),
      );
    }
    if (state.doodleParentIdea?.id == ideaId) {
      state = state.copyWith(
        doodleParentIdea: state.doodleParentIdea!.copyWith(
          isLiked: isLiked,
          likesCount: likesCount,
        ),
      );
    }
  }

  void updateDoodleLike(
    String doodleId, {
    required bool isLiked,
    required int likesCount,
  }) {
    if (state.parentDoodle?.id == doodleId) {
      state = state.copyWith(
        parentDoodle: state.parentDoodle!.copyWith(
          isLiked: isLiked,
          likesCount: likesCount,
        ),
      );
    }
  }
}
