// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'like_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(likeService)
final likeServiceProvider = LikeServiceProvider._();

final class LikeServiceProvider
    extends $FunctionalProvider<LikeService, LikeService, LikeService>
    with $Provider<LikeService> {
  LikeServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'likeServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$likeServiceHash();

  @$internal
  @override
  $ProviderElement<LikeService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  LikeService create(Ref ref) {
    return likeService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LikeService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LikeService>(value),
    );
  }
}

String _$likeServiceHash() => r'312b88419aa921b5840c7e0793955f6f04f0dda6';
