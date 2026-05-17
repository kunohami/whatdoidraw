import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:whatdoidraw/core/providers/supabase_provider.dart';
import 'package:whatdoidraw/shared/models/artwork_model.dart';

part 'artworks_repository.g.dart';

class ArtworksRepository {
  final SupabaseClient _supabase;

  ArtworksRepository(this._supabase);

  Future<void> createArtwork(ArtworkModel artwork) async {
    final Map<String, dynamic> data = artwork.toJson();
    // Quitar columnas virtuales, id y created_at para que Supabase los gestione.
    data.remove('id');
    data.remove('created_at');
    // Eliminar cualquier variante del nombre del autor (es una columna de JOIN)
    data.remove('authorName');
    data.remove('author_name');

    await _supabase.from('artworks').insert(data);
  }
}

@riverpod
ArtworksRepository artworksRepository(Ref ref) {
  final supabase = ref.watch(supabaseClientProvider);
  return ArtworksRepository(supabase);
}
