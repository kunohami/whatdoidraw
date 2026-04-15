// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feed_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(feedService)
final feedServiceProvider = FeedServiceProvider._();

final class FeedServiceProvider
    extends $FunctionalProvider<FeedService, FeedService, FeedService>
    with $Provider<FeedService> {
  FeedServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'feedServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$feedServiceHash();

  @$internal
  @override
  $ProviderElement<FeedService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  FeedService create(Ref ref) {
    return feedService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FeedService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FeedService>(value),
    );
  }
}

String _$feedServiceHash() => r'97a1c4d8f442bb3116644bf3b3196b5f7294eb0c';
