// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'artwork_link_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ArtworkLinkService)
final artworkLinkServiceProvider = ArtworkLinkServiceProvider._();

final class ArtworkLinkServiceProvider
    extends $NotifierProvider<ArtworkLinkService, void> {
  ArtworkLinkServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'artworkLinkServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$artworkLinkServiceHash();

  @$internal
  @override
  ArtworkLinkService create() => ArtworkLinkService();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$artworkLinkServiceHash() =>
    r'22680995fc99d454d5c88bfe2f08cf731aa7dcc3';

abstract class _$ArtworkLinkService extends $Notifier<void> {
  void build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<void, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<void, void>,
              void,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
