import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:whatdoidraw/core/providers/supabase_provider.dart';

part 'like_service.g.dart';

@riverpod
LikeService likeService(Ref ref) {
  return LikeService(ref.watch(supabaseClientProvider));
}

class LikeService {
  final SupabaseClient _supabase;

  LikeService(this._supabase);

  /// Alterna el estado de "like" para un ítem específico.
  ///
  /// [type] puede ser 'idea_id', 'doodle_id' o 'artwork_id'.
  Future<bool> toggleLike({
    required String itemId,
    required String type, // 'idea_id', 'doodle_id', 'artwork_id'
  }) async {
    final userId = _supabase.auth.currentUser?.id;
    if (userId == null) throw Exception('Usuario no autenticado');

    // Comprobar si ya existe el like
    final existing = await _supabase
        .from('likes')
        .select('id')
        .eq('user_id', userId)
        .eq(type, itemId)
        .maybeSingle();

    if (existing != null) {
      // Eliminar like
      await _supabase.from('likes').delete().eq('id', existing['id']);
      return false; // Ahora no tiene like
    } else {
      // Añadir like
      await _supabase.from('likes').insert({'user_id': userId, type: itemId});
      return true; // Ahora tiene like
    }
  }

  /// Comprueba si el usuario actual ha dado like a una lista de IDs.
  /// Devuelve un set con los IDs que tienen like.
  Future<Set<String>> getLikedItemIds({
    required List<String> itemIds,
    required String type,
  }) async {
    final userId = _supabase.auth.currentUser?.id;
    if (userId == null) return {};

    final response = await _supabase
        .from('likes')
        .select(type)
        .eq('user_id', userId)
        .inFilter(type, itemIds);

    return (response as List).map((row) => row[type] as String).toSet();
  }
}
