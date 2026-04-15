// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'content_creation_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(contentCreationService)
final contentCreationServiceProvider = ContentCreationServiceProvider._();

final class ContentCreationServiceProvider
    extends
        $FunctionalProvider<
          ContentCreationService,
          ContentCreationService,
          ContentCreationService
        >
    with $Provider<ContentCreationService> {
  ContentCreationServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'contentCreationServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$contentCreationServiceHash();

  @$internal
  @override
  $ProviderElement<ContentCreationService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ContentCreationService create(Ref ref) {
    return contentCreationService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ContentCreationService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ContentCreationService>(value),
    );
  }
}

String _$contentCreationServiceHash() =>
    r'a12b8bb6d241d586ebba82bafbce395a08374d01';
