import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:whatdoidraw/features/auth/auth_provider.dart';
import 'package:whatdoidraw/features/profile/services/profile_service.dart';
import 'package:whatdoidraw/shared/models/artwork_model.dart';
import 'package:whatdoidraw/shared/models/doodle_model.dart';
import 'package:whatdoidraw/shared/models/idea_model.dart';
import 'package:whatdoidraw/shared/models/user_model.dart';

part 'profile_viewmodel.g.dart';

/// Proveedor que retorna el perfil del usuario autenticado actual.
///
/// Combina el estado de la sesión (`authControllerProvider`) con
/// el backend (`profileServiceProvider`) para exponer directamente
/// la información del creador en la UI de forma reactiva.
@riverpod
Future<UserModel?> currentUserProfile(Ref ref) async {
  final user = await ref.watch(authControllerProvider.future);
  if (user == null) return null;

  final profileService = ref.watch(profileServiceProvider);
  return profileService.getUserProfile(user.id);
}

/// Expone la lista de Ideas creadas por el usuario autenticado.
///
/// Al ser un `FutureProvider` (a través de `@riverpod`), maneja automáticamente
/// los estados de carga (`loading`), éxito (`data`) y error (`error`).
@riverpod
Future<List<IdeaModel>> currentUserIdeas(Ref ref) async {
  final user = await ref.watch(authControllerProvider.future);
  if (user == null) return [];

  final profileService = ref.watch(profileServiceProvider);
  return profileService.getUserIdeas(user.id);
}

/// Retorna la colección de dibujos (Doodles) del usuario.
///
/// Si no hay un usuario autenticado activo, expone una lista vacía.
@riverpod
Future<List<DoodleModel>> currentUserDoodles(Ref ref) async {
  final user = await ref.watch(authControllerProvider.future);
  if (user == null) return [];

  final profileService = ref.watch(profileServiceProvider);
  return profileService.getUserDoodles(user.id);
}

@riverpod
Future<List<ArtworkModel>> currentUserArtworks(Ref ref) async {
  final user = await ref.watch(authControllerProvider.future);
  if (user == null) return [];

  final profileService = ref.watch(profileServiceProvider);
  return profileService.getUserArtworks(user.id);
}
