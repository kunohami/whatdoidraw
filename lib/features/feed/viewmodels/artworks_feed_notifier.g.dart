// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'artworks_feed_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ArtworksFeed)
final artworksFeedProvider = ArtworksFeedProvider._();

final class ArtworksFeedProvider
    extends $NotifierProvider<ArtworksFeed, ArtworksFeedState> {
  ArtworksFeedProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'artworksFeedProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$artworksFeedHash();

  @$internal
  @override
  ArtworksFeed create() => ArtworksFeed();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ArtworksFeedState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ArtworksFeedState>(value),
    );
  }
}

String _$artworksFeedHash() => r'36c8965c589e0b8fd924cbbc93f7fa3d4567f353';

abstract class _$ArtworksFeed extends $Notifier<ArtworksFeedState> {
  ArtworksFeedState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<ArtworksFeedState, ArtworksFeedState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ArtworksFeedState, ArtworksFeedState>,
              ArtworksFeedState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
