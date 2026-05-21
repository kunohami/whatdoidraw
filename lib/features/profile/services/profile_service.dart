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
        .select()
        .eq('user_id', userId)
        .order('created_at', ascending: false);

    return (response as List).map((data) => IdeaModel.fromJson(data)).toList();
  }

  /// Obtiene todos los Doodles dibujados por el usuario especificado.
  ///
  /// Trae los datos vectoriales brutos, listos para ser renderizados por
  /// el motor gráfico nativo de la app.
  Future<List<DoodleModel>> getUserDoodles(String userId) async {
    final response = await supabase
        .from('doodles')
        .select()
        .eq('user_id', userId)
        .order('created_at', ascending: false);

    return (response as List)
        .map((data) => DoodleModel.fromJson(data))
        .toList();
  }

  Future<List<ArtworkModel>> getUserArtworks(String userId) async {
    final response = await supabase
        .from('artworks')
        .select()
        .eq('user_id', userId)
        .order('created_at', ascending: false);

    return (response as List)
        .map((data) => ArtworkModel.fromJson(data))
        .toList();
  }

  /// Actualiza el mensaje corto (bio) de un usuario.
  Future<UserModel> updateShortMessage(String userId, String shortMessage) async {
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
}
