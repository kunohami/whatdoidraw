// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'artworks_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(artworksRepository)
final artworksRepositoryProvider = ArtworksRepositoryProvider._();

final class ArtworksRepositoryProvider
    extends
        $FunctionalProvider<
          ArtworksRepository,
          ArtworksRepository,
          ArtworksRepository
        >
    with $Provider<ArtworksRepository> {
  ArtworksRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'artworksRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$artworksRepositoryHash();

  @$internal
  @override
  $ProviderElement<ArtworksRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ArtworksRepository create(Ref ref) {
    return artworksRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ArtworksRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ArtworksRepository>(value),
    );
  }
}

String _$artworksRepositoryHash() =>
    r'e880da382c2220d9a18c5cf1e4db4044153a7316';
