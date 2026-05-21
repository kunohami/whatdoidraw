import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:whatdoidraw/features/auth/auth_provider.dart';
import 'package:whatdoidraw/features/profile/services/profile_service.dart';
import 'package:whatdoidraw/shared/models/artwork_model.dart';
import 'package:whatdoidraw/shared/models/doodle_model.dart';
import 'package:whatdoidraw/shared/models/idea_model.dart';
import 'package:whatdoidraw/shared/models/user_model.dart';

part 'profile_viewmodel.g.dart';

/// Proveedor parametrizado que retorna el perfil de cualquier usuario dado su [userId].
@riverpod
Future<UserModel> userProfile(Ref ref, String userId) async {
  final profileService = ref.watch(profileServiceProvider);
  return profileService.getUserProfile(userId);
}

/// Proveedor parametrizado que retorna las ideas creadas por cualquier usuario dado su [userId].
@riverpod
Future<List<IdeaModel>> userIdeas(Ref ref, String userId) async {
  final profileService = ref.watch(profileServiceProvider);
  return profileService.getUserIdeas(userId);
}

/// Proveedor parametrizado que retorna los doodles creados por cualquier usuario dado su [userId].
@riverpod
Future<List<DoodleModel>> userDoodles(Ref ref, String userId) async {
  final profileService = ref.watch(profileServiceProvider);
  return profileService.getUserDoodles(userId);
}

/// Proveedor parametrizado que retorna los artworks creados por cualquier usuario dado su [userId].
@riverpod
Future<List<ArtworkModel>> userArtworks(Ref ref, String userId) async {
  final profileService = ref.watch(profileServiceProvider);
  return profileService.getUserArtworks(userId);
}

/// Proveedor que retorna el perfil del usuario autenticado actual.
///
/// Combina el estado de la sesión (`authControllerProvider`) con
/// el backend (`profileServiceProvider`) para exponer directamente
/// la información del creador en la UI de forma reactiva.
@riverpod
Future<UserModel?> currentUserProfile(Ref ref) async {
  final user = await ref.watch(authControllerProvider.future);
  if (user == null) return null;

  return ref.watch(userProfileProvider(user.id).future);
}

/// Expone la lista de Ideas creadas por el usuario autenticado.
///
/// Al ser un `FutureProvider` (a través de `@riverpod`), maneja automáticamente
/// los estados de carga (`loading`), éxito (`data`) y error (`error`).
@riverpod
Future<List<IdeaModel>> currentUserIdeas(Ref ref) async {
  final user = await ref.watch(authControllerProvider.future);
  if (user == null) return [];

  return ref.watch(userIdeasProvider(user.id).future);
}

/// Retorna la colección de dibujos (Doodles) del usuario.
///
/// Si no hay un usuario autenticado activo, expone una lista vacía.
@riverpod
Future<List<DoodleModel>> currentUserDoodles(Ref ref) async {
  final user = await ref.watch(authControllerProvider.future);
  if (user == null) return [];

  return ref.watch(userDoodlesProvider(user.id).future);
}

@riverpod
Future<List<ArtworkModel>> currentUserArtworks(Ref ref) async {
  final user = await ref.watch(authControllerProvider.future);
  if (user == null) return [];

  return ref.watch(userArtworksProvider(user.id).future);
}
