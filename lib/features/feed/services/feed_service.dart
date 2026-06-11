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

    dynamic queryBuilder = supabaseClient
        .from('ideas')
        .select('*, users(username)')
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

    if (sort == FeedSortOrder.likes) {
      queryBuilder = queryBuilder
          .order('likes_count', ascending: false)
          .order('created_at', ascending: false);
    } else {
      queryBuilder = queryBuilder.order('created_at', ascending: false);
    }

    final data = await queryBuilder.range(offset, offset + fetchLimit - 1);

    var ideas = (data as List).map((e) {
      final map = Map<String, dynamic>.from(e);
      if (map['users'] != null) {
        map['authorName'] = map['users']['username'];
      }
      return IdeaModel.fromJson(map);
    }).toList();

    // Comprobar likes del usuario actual
    final userId = supabaseClient.auth.currentUser?.id;
    if (userId != null && ideas.isNotEmpty) {
      final ideaIds = ideas.map((i) => i.id).toList();
      final likedResponse = await supabaseClient
          .from('likes')
          .select('idea_id')
          .eq('user_id', userId)
          .inFilter('idea_id', ideaIds);

      final likedIds = (likedResponse as List)
          .map((r) => r['idea_id'] as String)
          .toSet();

      ideas = ideas
          .map((i) => i.copyWith(isLiked: likedIds.contains(i.id)))
          .toList();
    }

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

    dynamic queryBuilder = supabaseClient
        .from('doodles')
        .select('*, users(username)')
        .eq('is_active', true);

    if (query.isNotEmpty) {
      final normalizedTag = query.trim().toLowerCase().replaceAll(RegExp(r'[^a-z0-9\-]'), '');
      final sanitizedUserQuery = query.replaceAll(RegExp(r'[\\"{}]'), '');

      // 1. Fetch matching user IDs first to avoid PostgREST cross-table OR limitations
      final List<String> matchingUserIds = [];
      try {
        final usersData = await supabaseClient
            .from('users')
            .select('id')
            .ilike('username', '%$sanitizedUserQuery%');
        for (final u in usersData) {
          matchingUserIds.add(u['id'] as String);
        }
      } catch (e) {
        // Silently catch and proceed with tag-only search if user lookup fails
      }

      // 2. Perform local OR filter on doodles table
      if (matchingUserIds.isNotEmpty) {
        final idsInClause = matchingUserIds.join(',');
        queryBuilder = queryBuilder.or(
          'user_id.in.($idsInClause),tags.cs.{"$normalizedTag"}',
        );
      } else {
        queryBuilder = queryBuilder.or(
          'tags.cs.{"$normalizedTag"}',
        );
      }
    }

    if (tags.isNotEmpty) {
      queryBuilder = queryBuilder.contains('tags', tags);
    }

    if (sort == FeedSortOrder.likes) {
      queryBuilder = queryBuilder
          .order('likes_count', ascending: false)
          .order('created_at', ascending: false);
    } else {
      queryBuilder = queryBuilder.order('created_at', ascending: false);
    }

    final data = await queryBuilder.range(offset, offset + fetchLimit - 1);

    var doodles = (data as List).map((e) {
      final map = Map<String, dynamic>.from(e);
      if (map['users'] != null) {
        map['authorName'] = map['users']['username'];
      }
      return DoodleModel.fromJson(map);
    }).toList();

    // Comprobar likes del usuario actual
    final userId = supabaseClient.auth.currentUser?.id;
    if (userId != null && doodles.isNotEmpty) {
      final doodleIds = doodles.map((d) => d.id).toList();
      final likedResponse = await supabaseClient
          .from('likes')
          .select('doodle_id')
          .eq('user_id', userId)
          .inFilter('doodle_id', doodleIds);

      final likedIds = (likedResponse as List)
          .map((r) => r['doodle_id'] as String)
          .toSet();

      doodles = doodles
          .map((d) => d.copyWith(isLiked: likedIds.contains(d.id)))
          .toList();
    }

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
    dynamic queryBuilder = supabaseClient
        .from('artworks')
        .select('*, users(username)')
        .eq('is_active', true);

    if (query.isNotEmpty) {
      final normalizedTag = query.trim().toLowerCase().replaceAll(RegExp(r'[^a-z0-9\-]'), '');
      final sanitizedUserQuery = query.replaceAll(RegExp(r'[\\"{}]'), '');

      // 1. Fetch matching user IDs first to avoid PostgREST cross-table OR limitations
      final List<String> matchingUserIds = [];
      try {
        final usersData = await supabaseClient
            .from('users')
            .select('id')
            .ilike('username', '%$sanitizedUserQuery%');
        for (final u in usersData) {
          matchingUserIds.add(u['id'] as String);
        }
      } catch (e) {
        // Silently catch and proceed with tag-only search if user lookup fails
      }

      // 2. Perform local OR filter on artworks table
      if (matchingUserIds.isNotEmpty) {
        final idsInClause = matchingUserIds.join(',');
        queryBuilder = queryBuilder.or(
          'user_id.in.($idsInClause),tags.cs.{"$normalizedTag"}',
        );
      } else {
        queryBuilder = queryBuilder.or(
          'tags.cs.{"$normalizedTag"}',
        );
      }
    }

    if (tags.isNotEmpty) {
      queryBuilder = queryBuilder.contains('tags', tags);
    }

    if (sort == FeedSortOrder.likes) {
      queryBuilder = queryBuilder
          .order('likes_count', ascending: false)
          .order('created_at', ascending: false);
    } else {
      queryBuilder = queryBuilder.order('created_at', ascending: false);
    }

    final data = await queryBuilder.range(offset, offset + fetchLimit - 1);

    var artworks = (data as List).map((e) {
      final map = Map<String, dynamic>.from(e);
      // Extraemos el username del join para el campo authorName
      if (map['users'] != null) {
        map['authorName'] = map['users']['username'];
      }
      return ArtworkModel.fromJson(map);
    }).toList();

    // Comprobar likes del usuario actual
    final userId = supabaseClient.auth.currentUser?.id;
    if (userId != null && artworks.isNotEmpty) {
      final artworkIds = artworks.map((a) => a.id).toList();
      final likedResponse = await supabaseClient
          .from('likes')
          .select('artwork_id')
          .eq('user_id', userId)
          .inFilter('artwork_id', artworkIds);

      final likedIds = (likedResponse as List)
          .map((r) => r['artwork_id'] as String)
          .toSet();

      artworks = artworks
          .map((a) => a.copyWith(isLiked: likedIds.contains(a.id)))
          .toList();
    }

    if (sort == FeedSortOrder.random) {
      artworks.shuffle();
      return artworks.take(limit).toList();
    }

    return artworks;
  }

  Future<IdeaModel?> getIdeaById(String id) async {
    try {
      final data = await supabaseClient
          .from('ideas')
          .select('*, users(username)')
          .eq('id', id)
          .single();
      final map = Map<String, dynamic>.from(data);
      if (map['users'] != null) {
        map['authorName'] = map['users']['username'];
      }
      var idea = IdeaModel.fromJson(map);

      final userId = supabaseClient.auth.currentUser?.id;
      if (userId != null) {
        final likedResponse = await supabaseClient
            .from('likes')
            .select('idea_id')
            .eq('user_id', userId)
            .eq('idea_id', id);
        if ((likedResponse as List).isNotEmpty) {
          idea = idea.copyWith(isLiked: true);
        }
      }
      return idea;
    } catch (e) {
      return null;
    }
  }

  Future<DoodleModel?> getDoodleById(String id) async {
    try {
      final data = await supabaseClient
          .from('doodles')
          .select('*, users(username)')
          .eq('id', id)
          .single();
      final map = Map<String, dynamic>.from(data);
      if (map['users'] != null) {
        map['authorName'] = map['users']['username'];
      }
      var doodle = DoodleModel.fromJson(map);

      final userId = supabaseClient.auth.currentUser?.id;
      if (userId != null) {
        final likedResponse = await supabaseClient
            .from('likes')
            .select('doodle_id')
            .eq('user_id', userId)
            .eq('doodle_id', id);
        if ((likedResponse as List).isNotEmpty) {
          doodle = doodle.copyWith(isLiked: true);
        }
      }
      return doodle;
    } catch (e) {
      return null;
    }
  }

  Future<ArtworkModel?> getArtworkById(String id) async {
    try {
      final data = await supabaseClient
          .from('artworks')
          .select('*, users(username)')
          .eq('id', id)
          .single();
      final map = Map<String, dynamic>.from(data);
      if (map['users'] != null) {
        map['authorName'] = map['users']['username'];
      }
      var artwork = ArtworkModel.fromJson(map);

      final userId = supabaseClient.auth.currentUser?.id;
      if (userId != null) {
        final likedResponse = await supabaseClient
            .from('likes')
            .select('artwork_id')
            .eq('user_id', userId)
            .eq('artwork_id', id);
        if ((likedResponse as List).isNotEmpty) {
          artwork = artwork.copyWith(isLiked: true);
        }
      }
      return artwork;
    } catch (e) {
      return null;
    }
  }

  Future<List<DoodleModel>> getDoodlesByIdeaId(
    String ideaId, {
    int offset = 0,
    int limit = 10,
  }) async {
    try {
      final data = await supabaseClient
          .from('doodles')
          .select('*, users(username)')
          .eq('idea_id', ideaId)
          .eq('is_active', true)
          .order('created_at', ascending: false)
          .range(offset, offset + limit - 1);

      var doodles = (data as List).map((e) {
        final map = Map<String, dynamic>.from(e);
        if (map['users'] != null) {
          map['authorName'] = map['users']['username'];
        }
        return DoodleModel.fromJson(map);
      }).toList();

      final userId = supabaseClient.auth.currentUser?.id;
      if (userId != null && doodles.isNotEmpty) {
        final doodleIds = doodles.map((d) => d.id).toList();
        final likedResponse = await supabaseClient
            .from('likes')
            .select('doodle_id')
            .eq('user_id', userId)
            .inFilter('doodle_id', doodleIds);

        final likedIds = (likedResponse as List)
            .map((r) => r['doodle_id'] as String)
            .toSet();

        doodles = doodles
            .map((d) => d.copyWith(isLiked: likedIds.contains(d.id)))
            .toList();
      }
      return doodles;
    } catch (e) {
      return [];
    }
  }

  Future<List<ArtworkModel>> getArtworksByIdeaId(
    String ideaId, {
    int offset = 0,
    int limit = 10,
  }) async {
    try {
      final data = await supabaseClient
          .from('artworks')
          .select('*, users(username)')
          .eq('idea_id', ideaId)
          .eq('is_active', true)
          .order('created_at', ascending: false)
          .range(offset, offset + limit - 1);

      var artworks = (data as List).map((e) {
        final map = Map<String, dynamic>.from(e);
        if (map['users'] != null) {
          map['authorName'] = map['users']['username'];
        }
        return ArtworkModel.fromJson(map);
      }).toList();

      final userId = supabaseClient.auth.currentUser?.id;
      if (userId != null && artworks.isNotEmpty) {
        final artworkIds = artworks.map((a) => a.id).toList();
        final likedResponse = await supabaseClient
            .from('likes')
            .select('artwork_id')
            .eq('user_id', userId)
            .inFilter('artwork_id', artworkIds);

        final likedIds = (likedResponse as List)
            .map((r) => r['artwork_id'] as String)
            .toSet();

        artworks = artworks
            .map((a) => a.copyWith(isLiked: likedIds.contains(a.id)))
            .toList();
      }
      return artworks;
    } catch (e) {
      return [];
    }
  }

  Future<List<ArtworkModel>> getArtworksByDoodleId(
    String doodleId, {
    int offset = 0,
    int limit = 10,
  }) async {
    try {
      final data = await supabaseClient
          .from('artworks')
          .select('*, users(username)')
          .eq('doodle_id', doodleId)
          .eq('is_active', true)
          .order('created_at', ascending: false)
          .range(offset, offset + limit - 1);

      var artworks = (data as List).map((e) {
        final map = Map<String, dynamic>.from(e);
        if (map['users'] != null) {
          map['authorName'] = map['users']['username'];
        }
        return ArtworkModel.fromJson(map);
      }).toList();

      final userId = supabaseClient.auth.currentUser?.id;
      if (userId != null && artworks.isNotEmpty) {
        final artworkIds = artworks.map((a) => a.id).toList();
        final likedResponse = await supabaseClient
            .from('likes')
            .select('artwork_id')
            .eq('user_id', userId)
            .inFilter('artwork_id', artworkIds);

        final likedIds = (likedResponse as List)
            .map((r) => r['artwork_id'] as String)
            .toSet();

        artworks = artworks
            .map((a) => a.copyWith(isLiked: likedIds.contains(a.id)))
            .toList();
      }
      return artworks;
    } catch (e) {
      return [];
    }
  }
}
