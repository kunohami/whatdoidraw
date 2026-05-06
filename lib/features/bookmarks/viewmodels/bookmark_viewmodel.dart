import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:whatdoidraw/features/bookmarks/data/services/bookmark_service.dart';
import 'package:whatdoidraw/shared/models/doodle_model.dart';
import 'package:whatdoidraw/shared/models/idea_model.dart';

part 'bookmark_viewmodel.g.dart';

@riverpod
BookmarkService bookmarkService(Ref ref) {
  return BookmarkService(Supabase.instance.client);
}

@riverpod
class BookmarkedIdeas extends _$BookmarkedIdeas {
  BookmarkService get _service => ref.read(bookmarkServiceProvider);

  @override
  FutureOr<List<IdeaModel>> build() async {
    return _service.getUserBookmarkedIdeas();
  }

  Future<void> toggleBookmark(IdeaModel idea) async {
    final currentState = state.value;
    if (currentState == null) return;

    final isBookmarked = currentState.any((i) => i.id == idea.id);

    // Optimistic UI update
    if (isBookmarked) {
      state = AsyncValue.data(
        currentState.where((i) => i.id != idea.id).toList(),
      );
    } else {
      state = AsyncValue.data([idea, ...currentState]);
    }

    try {
      await _service.toggleIdeaBookmark(idea.id);
    } catch (e) {
      // Revert if error
      state = AsyncValue.data(currentState);
    }
  }

  bool isBookmarked(String ideaId) {
    return state.value?.any((i) => i.id == ideaId) ?? false;
  }
}

@riverpod
class BookmarkedDoodles extends _$BookmarkedDoodles {
  BookmarkService get _service => ref.read(bookmarkServiceProvider);

  @override
  FutureOr<List<DoodleModel>> build() async {
    return _service.getUserBookmarkedDoodles();
  }

  Future<void> toggleBookmark(DoodleModel doodle) async {
    final currentState = state.value;
    if (currentState == null) return;

    final isBookmarked = currentState.any((d) => d.id == doodle.id);

    // Optimistic UI update
    if (isBookmarked) {
      state = AsyncValue.data(
        currentState.where((d) => d.id != doodle.id).toList(),
      );
    } else {
      state = AsyncValue.data([doodle, ...currentState]);
    }

    try {
      await _service.toggleDoodleBookmark(doodle.id);
    } catch (e) {
      // Revert if error
      state = AsyncValue.data(currentState);
    }
  }

  bool isBookmarked(String doodleId) {
    return state.value?.any((d) => d.id == doodleId) ?? false;
  }
}
