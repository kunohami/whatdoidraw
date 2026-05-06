import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:whatdoidraw/shared/models/doodle_model.dart';
import 'package:whatdoidraw/shared/models/idea_model.dart';

class BookmarkService {
  final SupabaseClient _supabase;

  BookmarkService(this._supabase);

  // --- Ideas ---

  Future<void> toggleIdeaBookmark(String ideaId) async {
    final userId = _supabase.auth.currentUser?.id;
    if (userId == null) throw Exception('Usuario no autenticado');

    // Comprobar si ya existe
    final existing = await _supabase
        .from('bookmarks')
        .select('id')
        .eq('user_id', userId)
        .eq('idea_id', ideaId)
        .maybeSingle();

    if (existing != null) {
      // Eliminar
      await _supabase.from('bookmarks').delete().eq('id', existing['id']);
    } else {
      // Añadir
      await _supabase.from('bookmarks').insert({
        'user_id': userId,
        'idea_id': ideaId,
      });
    }
  }

  Future<List<IdeaModel>> getUserBookmarkedIdeas() async {
    final userId = _supabase.auth.currentUser?.id;
    if (userId == null) throw Exception('Usuario no autenticado');

    final response = await _supabase
        .from('bookmarks')
        .select('''
          idea_id,
          ideas:idea_id (
            id,
            user_id,
            content,
            tags,
            created_at,
            language
          )
        ''')
        .eq('user_id', userId)
        .not('idea_id', 'is', null)
        .order('created_at', ascending: false);

    return response
        .map((row) => row['ideas'] as Map<String, dynamic>)
        .map((data) => IdeaModel.fromJson(data))
        .toList();
  }

  // --- Doodles ---

  Future<void> toggleDoodleBookmark(String doodleId) async {
    final userId = _supabase.auth.currentUser?.id;
    if (userId == null) throw Exception('Usuario no autenticado');

    // Comprobar si ya existe
    final existing = await _supabase
        .from('bookmarks')
        .select('id')
        .eq('user_id', userId)
        .eq('doodle_id', doodleId)
        .maybeSingle();

    if (existing != null) {
      // Eliminar
      await _supabase.from('bookmarks').delete().eq('id', existing['id']);
    } else {
      // Añadir
      await _supabase.from('bookmarks').insert({
        'user_id': userId,
        'doodle_id': doodleId,
      });
    }
  }

  Future<List<DoodleModel>> getUserBookmarkedDoodles() async {
    final userId = _supabase.auth.currentUser?.id;
    if (userId == null) throw Exception('Usuario no autenticado');

    final response = await _supabase
        .from('bookmarks')
        .select('''
          doodle_id,
          doodles:doodle_id (
            id,
            user_id,
            idea_id,
            doodle_data,
            tags,
            created_at
          )
        ''')
        .eq('user_id', userId)
        .not('doodle_id', 'is', null)
        .order('created_at', ascending: false);

    return response
        .map((row) => row['doodles'] as Map<String, dynamic>)
        .map((data) => DoodleModel.fromJson(data))
        .toList();
  }
}
