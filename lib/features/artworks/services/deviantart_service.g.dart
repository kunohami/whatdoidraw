// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deviantart_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(deviantArtService)
final deviantArtServiceProvider = DeviantArtServiceProvider._();

final class DeviantArtServiceProvider
    extends
        $FunctionalProvider<
          DeviantArtService,
          DeviantArtService,
          DeviantArtService
        >
    with $Provider<DeviantArtService> {
  DeviantArtServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'deviantArtServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$deviantArtServiceHash();

  @$internal
  @override
  $ProviderElement<DeviantArtService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  DeviantArtService create(Ref ref) {
    return deviantArtService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DeviantArtService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DeviantArtService>(value),
    );
  }
}

String _$deviantArtServiceHash() => r'f54b523a15c49f6bc75b8ce8317b53446066aa39';
