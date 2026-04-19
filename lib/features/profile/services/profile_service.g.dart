// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Proveedor de Riverpod para instanciar el [ProfileService].
///
/// Inyecta automáticamente el cliente de Supabase asegurando
/// que toda la aplicación comparta la misma conexión.

@ProviderFor(profileService)
final profileServiceProvider = ProfileServiceProvider._();

/// Proveedor de Riverpod para instanciar el [ProfileService].
///
/// Inyecta automáticamente el cliente de Supabase asegurando
/// que toda la aplicación comparta la misma conexión.

final class ProfileServiceProvider
    extends $FunctionalProvider<ProfileService, ProfileService, ProfileService>
    with $Provider<ProfileService> {
  /// Proveedor de Riverpod para instanciar el [ProfileService].
  ///
  /// Inyecta automáticamente el cliente de Supabase asegurando
  /// que toda la aplicación comparta la misma conexión.
  ProfileServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'profileServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$profileServiceHash();

  @$internal
  @override
  $ProviderElement<ProfileService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ProfileService create(Ref ref) {
    return profileService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ProfileService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ProfileService>(value),
    );
  }
}

String _$profileServiceHash() => r'79c4c71025a54351580ee23d673fb2a9426bed07';
