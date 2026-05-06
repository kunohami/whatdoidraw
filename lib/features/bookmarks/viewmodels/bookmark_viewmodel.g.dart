// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bookmark_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(bookmarkService)
final bookmarkServiceProvider = BookmarkServiceProvider._();

final class BookmarkServiceProvider
    extends
        $FunctionalProvider<BookmarkService, BookmarkService, BookmarkService>
    with $Provider<BookmarkService> {
  BookmarkServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'bookmarkServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$bookmarkServiceHash();

  @$internal
  @override
  $ProviderElement<BookmarkService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  BookmarkService create(Ref ref) {
    return bookmarkService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BookmarkService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BookmarkService>(value),
    );
  }
}

String _$bookmarkServiceHash() => r'085c275a3565427d3b27eca6dec1fdcf26d4a892';

@ProviderFor(BookmarkedIdeas)
final bookmarkedIdeasProvider = BookmarkedIdeasProvider._();

final class BookmarkedIdeasProvider
    extends $AsyncNotifierProvider<BookmarkedIdeas, List<IdeaModel>> {
  BookmarkedIdeasProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'bookmarkedIdeasProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$bookmarkedIdeasHash();

  @$internal
  @override
  BookmarkedIdeas create() => BookmarkedIdeas();
}

String _$bookmarkedIdeasHash() => r'9bda7c0e47193e3e5d64d4d0c6aa67dbdcdcc7d4';

abstract class _$BookmarkedIdeas extends $AsyncNotifier<List<IdeaModel>> {
  FutureOr<List<IdeaModel>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<IdeaModel>>, List<IdeaModel>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<IdeaModel>>, List<IdeaModel>>,
              AsyncValue<List<IdeaModel>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(BookmarkedDoodles)
final bookmarkedDoodlesProvider = BookmarkedDoodlesProvider._();

final class BookmarkedDoodlesProvider
    extends $AsyncNotifierProvider<BookmarkedDoodles, List<DoodleModel>> {
  BookmarkedDoodlesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'bookmarkedDoodlesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$bookmarkedDoodlesHash();

  @$internal
  @override
  BookmarkedDoodles create() => BookmarkedDoodles();
}

String _$bookmarkedDoodlesHash() => r'46734c29913c283da7def57dc3645ca4e97d412c';

abstract class _$BookmarkedDoodles extends $AsyncNotifier<List<DoodleModel>> {
  FutureOr<List<DoodleModel>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<DoodleModel>>, List<DoodleModel>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<DoodleModel>>, List<DoodleModel>>,
              AsyncValue<List<DoodleModel>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
