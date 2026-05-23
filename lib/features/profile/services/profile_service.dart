import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:whatdoidraw/core/providers/supabase_provider.dart';
import 'package:whatdoidraw/shared/models/artwork_model.dart';
import 'package:whatdoidraw/shared/models/doodle_model.dart';
import 'package:whatdoidraw/shared/models/idea_model.dart';
import 'package:whatdoidraw/shared/models/user_model.dart';

part 'profile_service.g.dart';

/// Proveedor de Riverpod para instanciar el [ProfileService].
///
/// Inyecta automáticamente el cliente de Supabase asegurando
/// que toda la aplicación comparta la misma conexión.
@riverpod
ProfileService profileService(Ref ref) {
  return ProfileService(ref.watch(supabaseClientProvider));
}

/// Servicio dedicado a la obtención de datos para el perfil del usuario.
///
/// Siguiendo la arquitectura MVVM, este servicio actúa como el Model/Repository
/// que se comunica con Supabase para traer los datos crudos y serializarlos
/// en entidades inmutables usando Freezed.
class ProfileService {
  /// Instancia del cliente de Supabase inyectada vía constructor.
  final SupabaseClient supabase;

  ProfileService(this.supabase);

  /// Obtiene los datos públicos del perfil de un usuario dado su [userId].
  ///
  /// Hace una consulta a la tabla `users` asegurando un solo elemento (`.single()`).
  Future<UserModel> getUserProfile(String userId) async {
    final response = await supabase
        .from('users')
        .select()
        .eq('id', userId)
        .single();

    return UserModel.fromJson(response);
  }

  /// Obtiene el historial de Ideas (prompts) creadas por un usuario con [userId].
  ///
  /// Ordena los resultados desde el más reciente al más antiguo.
  Future<List<IdeaModel>> getUserIdeas(String userId) async {
    final response = await supabase
        .from('ideas')
        .select('*, users(username)')
        .eq('user_id', userId)
        .order('created_at', ascending: false);

    return (response as List).map((data) {
      final map = Map<String, dynamic>.from(data);
      if (map['users'] != null) {
        map['authorName'] = map['users']['username'];
      }
      return IdeaModel.fromJson(map);
    }).toList();
  }

  /// Obtiene todos los Doodles dibujados por el usuario especificado.
  ///
  /// Trae los datos vectoriales brutos, listos para ser renderizados por
  /// el motor gráfico nativo de la app.
  Future<List<DoodleModel>> getUserDoodles(String userId) async {
    final response = await supabase
        .from('doodles')
        .select('*, users(username)')
        .eq('user_id', userId)
        .order('created_at', ascending: false);

    return (response as List).map((data) {
      final map = Map<String, dynamic>.from(data);
      if (map['users'] != null) {
        map['authorName'] = map['users']['username'];
      }
      return DoodleModel.fromJson(map);
    }).toList();
  }

  /// Obtiene un doodle específico por su ID.
  /// Usado para cargar avatares personalizados.
  Future<DoodleModel?> getDoodleById(String doodleId) async {
    final response = await supabase.from('doodles').select('*, users(username)').eq('id', doodleId);

    final list = response as List;
    if (list.isEmpty) return null;
    final map = Map<String, dynamic>.from(list.first);
    if (map['users'] != null) map['authorName'] = map['users']['username'];
    return DoodleModel.fromJson(map);
  }

  Future<ArtworkModel?> getArtworkById(String artworkId) async {
    final response = await supabase.from('artworks').select('*, users(username)').eq('id', artworkId);

    final list = response as List;
    if (list.isEmpty) return null;
    final map = Map<String, dynamic>.from(list.first);
    if (map['users'] != null) map['authorName'] = map['users']['username'];
    return ArtworkModel.fromJson(map);
  }

  Future<List<ArtworkModel>> getUserArtworks(String userId) async {
    final response = await supabase
        .from('artworks')
        .select('*, users(username)')
        .eq('user_id', userId)
        .order('created_at', ascending: false);

    return (response as List).map((data) {
      final map = Map<String, dynamic>.from(data);
      if (map['users'] != null) {
        map['authorName'] = map['users']['username'];
      }
      return ArtworkModel.fromJson(map);
    }).toList();
  }

  /// Actualiza el mensaje corto (bio) de un usuario.
  Future<UserModel> updateShortMessage(
    String userId,
    String shortMessage,
  ) async {
    final response = await supabase
        .from('users')
        .update({'short_message': shortMessage})
        .eq('id', userId)
        .select()
        .single();

    return UserModel.fromJson(response);
  }

  /// Busca un usuario por su nombre de usuario (username) exacto (caso insensitivo).
  Future<UserModel?> getUserByUsername(String username) async {
    final response = await supabase
        .from('users')
        .select()
        .ilike('username', username);

    final list = response as List;
    if (list.isEmpty) return null;
    return UserModel.fromJson(list.first as Map<String, dynamic>);
  }

  /// Verifica si un nombre de usuario ya está tomado por otro usuario diferente de [currentUserId].
  Future<bool> isUsernameTaken(String username, String currentUserId) async {
    final response = await supabase
        .from('users')
        .select('id')
        .ilike('username', username)
        .neq('id', currentUserId);

    final list = response as List;
    return list.isNotEmpty;
  }

  /// Actualiza el nombre de usuario y guarda la fecha del cambio para el cooldown de 24 horas.
  Future<UserModel> updateUsername(String userId, String username) async {
    final now = DateTime.now().toUtc().toIso8601String();
    final response = await supabase
        .from('users')
        .update({'username': username, 'username_updated_at': now})
        .eq('id', userId)
        .select()
        .single();

    return UserModel.fromJson(response);
  }

  /// Actualiza la URL o URI del avatar del usuario.
  Future<UserModel> updateUserAvatar(String userId, String avatarUrl) async {
    final response = await supabase
        .from('users')
        .update({'avatar_url': avatarUrl})
        .eq('id', userId)
        .select()
        .single();

    return UserModel.fromJson(response);
  }

  /// Actualiza las preferencias de notificaciones.
  Future<UserModel> updateNotificationPreferences(
    String userId, {
    required bool emailNotifications,
    required bool pushNotifications,
  }) async {
    final response = await supabase
        .from('users')
        .update({
          'email_notifications': emailNotifications,
          'push_notifications': pushNotifications,
        })
        .eq('id', userId)
        .select()
        .single();

    return UserModel.fromJson(response);
  }

  /// Actualiza la preferencia push y el token FCM del usuario.
  Future<UserModel> updatePushSettings(
    String userId, {
    required bool hasSeenPushPrompt,
    required bool pushNotifications,
    String? fcmToken,
  }) async {
    final Map<String, dynamic> updateData = {
      'has_seen_push_prompt': hasSeenPushPrompt,
      'push_notifications': pushNotifications,
    };
    if (fcmToken != null) {
      updateData['fcm_token'] = fcmToken;
    }

    final response = await supabase
        .from('users')
        .update(updateData)
        .eq('id', userId)
        .select()
        .single();

    return UserModel.fromJson(response);
  }
}
