// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Proveedor parametrizado que retorna el perfil de cualquier usuario dado su [userId].

@ProviderFor(userProfile)
final userProfileProvider = UserProfileFamily._();

/// Proveedor parametrizado que retorna el perfil de cualquier usuario dado su [userId].

final class UserProfileProvider
    extends
        $FunctionalProvider<
          AsyncValue<UserModel>,
          UserModel,
          FutureOr<UserModel>
        >
    with $FutureModifier<UserModel>, $FutureProvider<UserModel> {
  /// Proveedor parametrizado que retorna el perfil de cualquier usuario dado su [userId].
  UserProfileProvider._({
    required UserProfileFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'userProfileProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$userProfileHash();

  @override
  String toString() {
    return r'userProfileProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<UserModel> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<UserModel> create(Ref ref) {
    final argument = this.argument as String;
    return userProfile(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is UserProfileProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$userProfileHash() => r'8377d0328d9ba40519d4b30e4820c741eb50fc7f';

/// Proveedor parametrizado que retorna el perfil de cualquier usuario dado su [userId].

final class UserProfileFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<UserModel>, String> {
  UserProfileFamily._()
    : super(
        retry: null,
        name: r'userProfileProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Proveedor parametrizado que retorna el perfil de cualquier usuario dado su [userId].

  UserProfileProvider call(String userId) =>
      UserProfileProvider._(argument: userId, from: this);

  @override
  String toString() => r'userProfileProvider';
}

/// Proveedor parametrizado que retorna las ideas creadas por cualquier usuario dado su [userId].

@ProviderFor(userIdeas)
final userIdeasProvider = UserIdeasFamily._();

/// Proveedor parametrizado que retorna las ideas creadas por cualquier usuario dado su [userId].

final class UserIdeasProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<IdeaModel>>,
          List<IdeaModel>,
          FutureOr<List<IdeaModel>>
        >
    with $FutureModifier<List<IdeaModel>>, $FutureProvider<List<IdeaModel>> {
  /// Proveedor parametrizado que retorna las ideas creadas por cualquier usuario dado su [userId].
  UserIdeasProvider._({
    required UserIdeasFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'userIdeasProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$userIdeasHash();

  @override
  String toString() {
    return r'userIdeasProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<IdeaModel>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<IdeaModel>> create(Ref ref) {
    final argument = this.argument as String;
    return userIdeas(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is UserIdeasProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$userIdeasHash() => r'64187ec77b29752607cfcc2f9008bd9e976bdbe5';

/// Proveedor parametrizado que retorna las ideas creadas por cualquier usuario dado su [userId].

final class UserIdeasFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<IdeaModel>>, String> {
  UserIdeasFamily._()
    : super(
        retry: null,
        name: r'userIdeasProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Proveedor parametrizado que retorna las ideas creadas por cualquier usuario dado su [userId].

  UserIdeasProvider call(String userId) =>
      UserIdeasProvider._(argument: userId, from: this);

  @override
  String toString() => r'userIdeasProvider';
}

/// Proveedor parametrizado que retorna los doodles creados por cualquier usuario dado su [userId].

@ProviderFor(userDoodles)
final userDoodlesProvider = UserDoodlesFamily._();

/// Proveedor parametrizado que retorna los doodles creados por cualquier usuario dado su [userId].

final class UserDoodlesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<DoodleModel>>,
          List<DoodleModel>,
          FutureOr<List<DoodleModel>>
        >
    with
        $FutureModifier<List<DoodleModel>>,
        $FutureProvider<List<DoodleModel>> {
  /// Proveedor parametrizado que retorna los doodles creados por cualquier usuario dado su [userId].
  UserDoodlesProvider._({
    required UserDoodlesFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'userDoodlesProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$userDoodlesHash();

  @override
  String toString() {
    return r'userDoodlesProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<DoodleModel>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<DoodleModel>> create(Ref ref) {
    final argument = this.argument as String;
    return userDoodles(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is UserDoodlesProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$userDoodlesHash() => r'0851835423b38c6b30338471c1abba523f138e5c';

/// Proveedor parametrizado que retorna los doodles creados por cualquier usuario dado su [userId].

final class UserDoodlesFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<DoodleModel>>, String> {
  UserDoodlesFamily._()
    : super(
        retry: null,
        name: r'userDoodlesProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Proveedor parametrizado que retorna los doodles creados por cualquier usuario dado su [userId].

  UserDoodlesProvider call(String userId) =>
      UserDoodlesProvider._(argument: userId, from: this);

  @override
  String toString() => r'userDoodlesProvider';
}

/// Proveedor parametrizado que retorna los artworks creados por cualquier usuario dado su [userId].

@ProviderFor(userArtworks)
final userArtworksProvider = UserArtworksFamily._();

/// Proveedor parametrizado que retorna los artworks creados por cualquier usuario dado su [userId].

final class UserArtworksProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<ArtworkModel>>,
          List<ArtworkModel>,
          FutureOr<List<ArtworkModel>>
        >
    with
        $FutureModifier<List<ArtworkModel>>,
        $FutureProvider<List<ArtworkModel>> {
  /// Proveedor parametrizado que retorna los artworks creados por cualquier usuario dado su [userId].
  UserArtworksProvider._({
    required UserArtworksFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'userArtworksProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$userArtworksHash();

  @override
  String toString() {
    return r'userArtworksProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<ArtworkModel>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<ArtworkModel>> create(Ref ref) {
    final argument = this.argument as String;
    return userArtworks(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is UserArtworksProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$userArtworksHash() => r'851c2b7c6584c8e755c38a47409e542adaf6d015';

/// Proveedor parametrizado que retorna los artworks creados por cualquier usuario dado su [userId].

final class UserArtworksFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<ArtworkModel>>, String> {
  UserArtworksFamily._()
    : super(
        retry: null,
        name: r'userArtworksProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Proveedor parametrizado que retorna los artworks creados por cualquier usuario dado su [userId].

  UserArtworksProvider call(String userId) =>
      UserArtworksProvider._(argument: userId, from: this);

  @override
  String toString() => r'userArtworksProvider';
}

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
    r'15e0d501d7b5edb19ea7c423fd796b9cf8646c4b';

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

String _$currentUserIdeasHash() => r'6497b7806cba78e80ca4152d7dba597ddd0eebc1';

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
    r'67742944326f2a01a3eb7a8bc2c355abd810aa52';

@ProviderFor(currentUserArtworks)
final currentUserArtworksProvider = CurrentUserArtworksProvider._();

final class CurrentUserArtworksProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<ArtworkModel>>,
          List<ArtworkModel>,
          FutureOr<List<ArtworkModel>>
        >
    with
        $FutureModifier<List<ArtworkModel>>,
        $FutureProvider<List<ArtworkModel>> {
  CurrentUserArtworksProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currentUserArtworksProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currentUserArtworksHash();

  @$internal
  @override
  $FutureProviderElement<List<ArtworkModel>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<ArtworkModel>> create(Ref ref) {
    return currentUserArtworks(ref);
  }
}

String _$currentUserArtworksHash() =>
    r'75ce74ed471637ad4ef8affbc9b04dbc489c055c';
