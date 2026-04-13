// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'content_creation_di.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(contentCreationRemoteDataSource)
final contentCreationRemoteDataSourceProvider =
    ContentCreationRemoteDataSourceProvider._();

final class ContentCreationRemoteDataSourceProvider
    extends
        $FunctionalProvider<
          IContentCreationRemoteDataSource,
          IContentCreationRemoteDataSource,
          IContentCreationRemoteDataSource
        >
    with $Provider<IContentCreationRemoteDataSource> {
  ContentCreationRemoteDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'contentCreationRemoteDataSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$contentCreationRemoteDataSourceHash();

  @$internal
  @override
  $ProviderElement<IContentCreationRemoteDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  IContentCreationRemoteDataSource create(Ref ref) {
    return contentCreationRemoteDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(IContentCreationRemoteDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<IContentCreationRemoteDataSource>(
        value,
      ),
    );
  }
}

String _$contentCreationRemoteDataSourceHash() =>
    r'668d1467ad97bc5da59ba7405bb6c47ff34d9af2';

@ProviderFor(contentCreationRepository)
final contentCreationRepositoryProvider = ContentCreationRepositoryProvider._();

final class ContentCreationRepositoryProvider
    extends
        $FunctionalProvider<
          IContentCreationRepository,
          IContentCreationRepository,
          IContentCreationRepository
        >
    with $Provider<IContentCreationRepository> {
  ContentCreationRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'contentCreationRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$contentCreationRepositoryHash();

  @$internal
  @override
  $ProviderElement<IContentCreationRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  IContentCreationRepository create(Ref ref) {
    return contentCreationRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(IContentCreationRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<IContentCreationRepository>(value),
    );
  }
}

String _$contentCreationRepositoryHash() =>
    r'21b39fe12e641fb54be6fbcb661daf241c471dee';

@ProviderFor(submitIdeaUseCase)
final submitIdeaUseCaseProvider = SubmitIdeaUseCaseProvider._();

final class SubmitIdeaUseCaseProvider
    extends
        $FunctionalProvider<
          SubmitIdeaUseCase,
          SubmitIdeaUseCase,
          SubmitIdeaUseCase
        >
    with $Provider<SubmitIdeaUseCase> {
  SubmitIdeaUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'submitIdeaUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$submitIdeaUseCaseHash();

  @$internal
  @override
  $ProviderElement<SubmitIdeaUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SubmitIdeaUseCase create(Ref ref) {
    return submitIdeaUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SubmitIdeaUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SubmitIdeaUseCase>(value),
    );
  }
}

String _$submitIdeaUseCaseHash() => r'e86c58298d3e80d1036a8a193295b4cde8e80898';

@ProviderFor(submitDoodleUseCase)
final submitDoodleUseCaseProvider = SubmitDoodleUseCaseProvider._();

final class SubmitDoodleUseCaseProvider
    extends
        $FunctionalProvider<
          SubmitDoodleUseCase,
          SubmitDoodleUseCase,
          SubmitDoodleUseCase
        >
    with $Provider<SubmitDoodleUseCase> {
  SubmitDoodleUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'submitDoodleUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$submitDoodleUseCaseHash();

  @$internal
  @override
  $ProviderElement<SubmitDoodleUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SubmitDoodleUseCase create(Ref ref) {
    return submitDoodleUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SubmitDoodleUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SubmitDoodleUseCase>(value),
    );
  }
}

String _$submitDoodleUseCaseHash() =>
    r'0871cee1820b9f1052927ee839608abb9443ff77';
