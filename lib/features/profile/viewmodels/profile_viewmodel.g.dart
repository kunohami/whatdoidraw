// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Proveedor que retorna el perfil del usuario autenticado actual.
///
/// Combina el estado de la sesión (`authControllerProvider`) con
/// el backend (`profileServiceProvider`) para exponer directamente
/// la información del creador en la UI de forma reactiva.

@ProviderFor(currentUserProfile)
final currentUserProfileProvider = CurrentUserProfileProvider._();

/// Proveedor que retorna el perfil del usuario autenticado actual.
///
/// Combina el estado de la sesión (`authControllerProvider`) con
/// el backend (`profileServiceProvider`) para exponer directamente
/// la información del creador en la UI de forma reactiva.

final class CurrentUserProfileProvider
    extends
        $FunctionalProvider<
          AsyncValue<UserModel?>,
          UserModel?,
          FutureOr<UserModel?>
        >
    with $FutureModifier<UserModel?>, $FutureProvider<UserModel?> {
  /// Proveedor que retorna el perfil del usuario autenticado actual.
  ///
  /// Combina el estado de la sesión (`authControllerProvider`) con
  /// el backend (`profileServiceProvider`) para exponer directamente
  /// la información del creador en la UI de forma reactiva.
  CurrentUserProfileProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currentUserProfileProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currentUserProfileHash();

  @$internal
  @override
  $FutureProviderElement<UserModel?> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<UserModel?> create(Ref ref) {
    return currentUserProfile(ref);
  }
}

String _$currentUserProfileHash() =>
    r'8756fbeee6a13093bbd31f69c11503b5027e17f1';

/// Expone la lista de Ideas creadas por el usuario autenticado.
///
/// Al ser un `FutureProvider` (a través de `@riverpod`), maneja automáticamente
/// los estados de carga (`loading`), éxito (`data`) y error (`error`).

@ProviderFor(currentUserIdeas)
final currentUserIdeasProvider = CurrentUserIdeasProvider._();

/// Expone la lista de Ideas creadas por el usuario autenticado.
///
/// Al ser un `FutureProvider` (a través de `@riverpod`), maneja automáticamente
/// los estados de carga (`loading`), éxito (`data`) y error (`error`).

final class CurrentUserIdeasProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<IdeaModel>>,
          List<IdeaModel>,
          FutureOr<List<IdeaModel>>
        >
    with $FutureModifier<List<IdeaModel>>, $FutureProvider<List<IdeaModel>> {
  /// Expone la lista de Ideas creadas por el usuario autenticado.
  ///
  /// Al ser un `FutureProvider` (a través de `@riverpod`), maneja automáticamente
  /// los estados de carga (`loading`), éxito (`data`) y error (`error`).
  CurrentUserIdeasProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currentUserIdeasProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currentUserIdeasHash();

  @$internal
  @override
  $FutureProviderElement<List<IdeaModel>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<IdeaModel>> create(Ref ref) {
    return currentUserIdeas(ref);
  }
}

String _$currentUserIdeasHash() => r'0de5927813f549290d889f539de45f26a01066c8';

/// Retorna la colección de dibujos (Doodles) del usuario.
///
/// Si no hay un usuario autenticado activo, expone una lista vacía.

@ProviderFor(currentUserDoodles)
final currentUserDoodlesProvider = CurrentUserDoodlesProvider._();

/// Retorna la colección de dibujos (Doodles) del usuario.
///
/// Si no hay un usuario autenticado activo, expone una lista vacía.

final class CurrentUserDoodlesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<DoodleModel>>,
          List<DoodleModel>,
          FutureOr<List<DoodleModel>>
        >
    with
        $FutureModifier<List<DoodleModel>>,
        $FutureProvider<List<DoodleModel>> {
  /// Retorna la colección de dibujos (Doodles) del usuario.
  ///
  /// Si no hay un usuario autenticado activo, expone una lista vacía.
  CurrentUserDoodlesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currentUserDoodlesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currentUserDoodlesHash();

  @$internal
  @override
  $FutureProviderElement<List<DoodleModel>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<DoodleModel>> create(Ref ref) {
    return currentUserDoodles(ref);
  }
}

String _$currentUserDoodlesHash() =>
    r'0f8c3e0cb457154ecaa5fc7ada6f7fe1ad4c2867';
