// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'content_creation_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Servicio responsable de persistir las creaciones de los usuarios en la nube.
///
/// Gestiona tanto la publicación de prompts de texto (Ideas) como la subida
/// de datos vectoriales complejos (Doodles).

@ProviderFor(contentCreationService)
final contentCreationServiceProvider = ContentCreationServiceProvider._();

/// Servicio responsable de persistir las creaciones de los usuarios en la nube.
///
/// Gestiona tanto la publicación de prompts de texto (Ideas) como la subida
/// de datos vectoriales complejos (Doodles).

final class ContentCreationServiceProvider
    extends
        $FunctionalProvider<
          ContentCreationService,
          ContentCreationService,
          ContentCreationService
        >
    with $Provider<ContentCreationService> {
  /// Servicio responsable de persistir las creaciones de los usuarios en la nube.
  ///
  /// Gestiona tanto la publicación de prompts de texto (Ideas) como la subida
  /// de datos vectoriales complejos (Doodles).
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
