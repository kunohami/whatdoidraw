import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:whatdoidraw/core/constants/feed_constants.dart';
import 'package:whatdoidraw/core/providers/supabase_provider.dart';
import 'package:whatdoidraw/features/feed/models/feed_sort_order.dart';
import 'package:whatdoidraw/shared/models/artwork_model.dart';
import 'package:whatdoidraw/shared/models/doodle_model.dart';
import 'package:whatdoidraw/shared/models/idea_model.dart';

part 'feed_service.g.dart';

/// Servicio encargado de la recuperación de datos para el muro de ideas (Feed).
///
/// Utiliza queries paginadas en lugar de streams en tiempo real para controlar
/// el coste de consultas a Supabase. La UI puede solicitar más datos
/// explícitamente mediante el patrón "cargar más".
@riverpod
FeedService feedService(Ref ref) {
  return FeedService(ref.watch(supabaseClientProvider));
}

class FeedService {
  /// Cliente de Supabase inyectado para realizar peticiones.
  final SupabaseClient supabaseClient;

  FeedService(this.supabaseClient);

  /// Obtiene una página de ideas con filtros y ordenación opcionales.
  ///
  /// - [offset]: posición desde la que empezar (para paginación).
  /// - [limit]: número máximo de items a devolver.
  /// - [query]: texto libre para buscar en el contenido de la idea.
  /// - [tags]: lista de tags por los que filtrar (todos deben coincidir).
  /// - [sort]: ordenación por fecha reciente o aleatoria (shuffle en cliente).
  Future<List<IdeaModel>> fetchIdeas({
    int offset = 0,
    int limit = kIdeasPageSize,
    String query = '',
    List<String> tags = const [],
    FeedSortOrder sort = FeedSortOrder.recent,
    String? language,
  }) async {
    // En modo aleatorio pedimos un lote grande para hacer shuffle en cliente.
    final fetchLimit = sort == FeedSortOrder.random ? kRandomFetchSize : limit;

    var queryBuilder = supabaseClient
        .from('ideas')
        .select()
        .eq('is_active', true);

    if (query.isNotEmpty) {
      queryBuilder = queryBuilder.ilike('content', '%$query%');
    }

    if (tags.isNotEmpty) {
      queryBuilder = queryBuilder.contains('tags', tags);
    }

    if (language != null && language != 'all') {
      queryBuilder = queryBuilder.eq('language', language);
    }

    final data = await queryBuilder
        .order('created_at', ascending: false)
        .range(offset, offset + fetchLimit - 1);

    final ideas = (data as List).map((e) => IdeaModel.fromJson(e)).toList();

    if (sort == FeedSortOrder.random) {
      ideas.shuffle();
      return ideas.take(limit).toList();
    }

    return ideas;
  }

  /// Obtiene una página de doodles con filtros y ordenación opcionales.
  ///
  /// - [offset]: posición desde la que empezar (para paginación).
  /// - [limit]: número máximo de items a devolver.
  /// - [tags]: lista de tags por los que filtrar (todos deben coincidir).
  /// - [sort]: ordenación por fecha reciente o aleatoria (shuffle en cliente).
  Future<List<DoodleModel>> fetchDoodles({
    int offset = 0,
    int limit = kDoodlesPageSize,
    String query = '',
    List<String> tags = const [],
    FeedSortOrder sort = FeedSortOrder.random,
    String? language,
  }) async {
    final fetchLimit = sort == FeedSortOrder.random ? kRandomFetchSize : limit;

    var queryBuilder = supabaseClient
        .from('doodles')
        .select()
        .eq('is_active', true);

    if (query.isNotEmpty) {
      queryBuilder = queryBuilder.or('content.ilike.%$query%,tags.cs.{"$query"}');
    }

    if (tags.isNotEmpty) {
      queryBuilder = queryBuilder.contains('tags', tags);
    }

    final data = await queryBuilder
        .order('created_at', ascending: false)
        .range(offset, offset + fetchLimit - 1);

    final doodles = (data as List).map((e) => DoodleModel.fromJson(e)).toList();

    if (sort == FeedSortOrder.random) {
      doodles.shuffle();
      return doodles.take(limit).toList();
    }

    return doodles;
  }

  /// Obtiene una página de artworks con filtros y búsqueda opcional.
  ///
  /// - [offset]: posición desde la que empezar.
  /// - [limit]: número máximo de items.
  /// - [query]: búsqueda por nombre de artista o contenido (si lo hubiera).
  /// - [tags]: lista de tags por los que filtrar.
  Future<List<ArtworkModel>> fetchArtworks({
    int offset = 0,
    int limit = 10, // Por ahora valor por defecto
    String query = '',
    List<String> tags = const [],
    FeedSortOrder sort = FeedSortOrder.recent,
    String? language,
  }) async {
    final fetchLimit = sort == FeedSortOrder.random ? kRandomFetchSize : limit;

    // Join con la tabla 'users' para obtener el 'username'
    var queryBuilder = supabaseClient
        .from('artworks')
        .select('*, users!inner(username)')
        .eq('is_active', true);

    if (query.isNotEmpty) {
      // Búsqueda por username del artista o tags (usando or)
      // Nota: Para filtrar por nombre de usuario en el join usamos la sintaxis de Supabase
      queryBuilder = queryBuilder.or(
        'users.username.ilike.%$query%,tags.cs.{"$query"}',
      );
    }

    if (tags.isNotEmpty) {
      queryBuilder = queryBuilder.contains('tags', tags);
    }

    final data = await queryBuilder
        .order('created_at', ascending: false)
        .range(offset, offset + fetchLimit - 1);

    final artworks = (data as List).map((e) {
      final map = Map<String, dynamic>.from(e);
      // Extraemos el username del join para el campo authorName
      if (map['users'] != null) {
        map['authorName'] = map['users']['username'];
      }
      return ArtworkModel.fromJson(map);
    }).toList();

    if (sort == FeedSortOrder.random) {
      artworks.shuffle();
      return artworks.take(limit).toList();
    }

    return artworks;
  }
}
