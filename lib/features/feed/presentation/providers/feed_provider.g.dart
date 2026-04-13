// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feed_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(feedRemoteDataSource)
final feedRemoteDataSourceProvider = FeedRemoteDataSourceProvider._();

final class FeedRemoteDataSourceProvider
    extends
        $FunctionalProvider<
          IFeedRemoteDataSource,
          IFeedRemoteDataSource,
          IFeedRemoteDataSource
        >
    with $Provider<IFeedRemoteDataSource> {
  FeedRemoteDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'feedRemoteDataSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$feedRemoteDataSourceHash();

  @$internal
  @override
  $ProviderElement<IFeedRemoteDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  IFeedRemoteDataSource create(Ref ref) {
    return feedRemoteDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(IFeedRemoteDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<IFeedRemoteDataSource>(value),
    );
  }
}

String _$feedRemoteDataSourceHash() =>
    r'a43bb6b2ca744e042cc9e6e56fd5d66e6b677fac';

@ProviderFor(feedRepository)
final feedRepositoryProvider = FeedRepositoryProvider._();

final class FeedRepositoryProvider
    extends
        $FunctionalProvider<IFeedRepository, IFeedRepository, IFeedRepository>
    with $Provider<IFeedRepository> {
  FeedRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'feedRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$feedRepositoryHash();

  @$internal
  @override
  $ProviderElement<IFeedRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  IFeedRepository create(Ref ref) {
    return feedRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(IFeedRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<IFeedRepository>(value),
    );
  }
}

String _$feedRepositoryHash() => r'b288d596c9ea166942e67540dee67f658c7ca066';

@ProviderFor(getIdeasStreamUseCase)
final getIdeasStreamUseCaseProvider = GetIdeasStreamUseCaseProvider._();

final class GetIdeasStreamUseCaseProvider
    extends
        $FunctionalProvider<
          GetIdeasStreamUseCase,
          GetIdeasStreamUseCase,
          GetIdeasStreamUseCase
        >
    with $Provider<GetIdeasStreamUseCase> {
  GetIdeasStreamUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getIdeasStreamUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getIdeasStreamUseCaseHash();

  @$internal
  @override
  $ProviderElement<GetIdeasStreamUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GetIdeasStreamUseCase create(Ref ref) {
    return getIdeasStreamUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetIdeasStreamUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetIdeasStreamUseCase>(value),
    );
  }
}

String _$getIdeasStreamUseCaseHash() =>
    r'65c01c6ffa4c52d08929fa0b96d355d7f17aaa76';

@ProviderFor(ideasStream)
final ideasStreamProvider = IdeasStreamProvider._();

final class IdeasStreamProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<IdeaModel>>,
          List<IdeaModel>,
          Stream<List<IdeaModel>>
        >
    with $FutureModifier<List<IdeaModel>>, $StreamProvider<List<IdeaModel>> {
  IdeasStreamProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'ideasStreamProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$ideasStreamHash();

  @$internal
  @override
  $StreamProviderElement<List<IdeaModel>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<IdeaModel>> create(Ref ref) {
    return ideasStream(ref);
  }
}

String _$ideasStreamHash() => r'e4345e287abd882c9ac90b60f874db2879aaa230';
