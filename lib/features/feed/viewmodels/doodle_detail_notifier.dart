import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:whatdoidraw/features/feed/services/feed_service.dart';
import 'package:whatdoidraw/shared/models/doodle_model.dart';
import 'package:whatdoidraw/shared/models/idea_model.dart';

part 'doodle_detail_notifier.g.dart';

class DoodleDetailState {
  final DoodleModel? doodle;
  final IdeaModel? parentIdea;
  final bool isLoading;
  final String? errorMessage;

  DoodleDetailState({
    this.doodle,
    this.parentIdea,
    required this.isLoading,
    this.errorMessage,
  });

  DoodleDetailState copyWith({
    DoodleModel? doodle,
    IdeaModel? parentIdea,
    bool? isLoading,
    String? errorMessage,
  }) {
    return DoodleDetailState(
      doodle: doodle ?? this.doodle,
      parentIdea: parentIdea ?? this.parentIdea,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

@riverpod
class DoodleDetailNotifier extends _$DoodleDetailNotifier {
  @override
  DoodleDetailState build(String doodleId) {
    _fetchDoodleAndParent();
    return DoodleDetailState(isLoading: true);
  }

  Future<void> _fetchDoodleAndParent() async {
    try {
      final feedService = ref.read(feedServiceProvider);
      final doodle = await feedService.getDoodleById(doodleId);
      if (doodle == null) {
        state = DoodleDetailState(
          isLoading: false,
          errorMessage: 'Doodle no encontrado',
        );
        return;
      }

      IdeaModel? parentIdea;
      if (doodle.ideaId != null) {
        parentIdea = await feedService.getIdeaById(doodle.ideaId!);
      }

      state = DoodleDetailState(
        doodle: doodle,
        parentIdea: parentIdea,
        isLoading: false,
      );
    } catch (e) {
      state = DoodleDetailState(
        isLoading: false,
        errorMessage: e.toString(),
      );
    }
  }

  void updateDoodleLike({required bool isLiked, required int likesCount}) {
    if (state.doodle != null) {
      state = state.copyWith(
        doodle: state.doodle!.copyWith(isLiked: isLiked, likesCount: likesCount),
      );
    }
  }

  void updateIdeaLike(String ideaId, {required bool isLiked, required int likesCount}) {
    if (state.parentIdea?.id == ideaId) {
      state = state.copyWith(
        parentIdea: state.parentIdea!.copyWith(isLiked: isLiked, likesCount: likesCount),
      );
    }
  }
}
