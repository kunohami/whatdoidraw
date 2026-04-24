import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:whatdoidraw/core/constants/feed_constants.dart';
import 'package:whatdoidraw/features/feed/models/feed_sort_order.dart';
import 'package:whatdoidraw/features/feed/services/feed_service.dart';
import 'package:whatdoidraw/shared/models/idea_model.dart';

part 'ideas_feed_notifier.g.dart';

/// Estado inmutable que contiene toda la información necesaria para renderizar
/// la pestaña de Ideas del Feed.
class IdeasFeedState {
  /// Lista acumulada de ideas ya cargadas.
  final List<IdeaModel> ideas;

  /// Indica si hay más páginas disponibles en el servidor.
  final bool hasMore;

  /// Indica si se está cargando la primera página (carga inicial o refresh).
  final bool isLoading;

  /// Indica si se está cargando una página adicional ("cargar más").
  final bool isLoadingMore;

  /// Texto de búsqueda libre aplicado actualmente.
  final String searchQuery;

  /// Lista de tags activos como filtro.
  final List<String> selectedTags;

  /// Modo de ordenación activo.
  final FeedSortOrder sortOrder;

  /// Mensaje de error, si lo hay.
  final String? errorMessage;

  const IdeasFeedState({
    this.ideas = const [],
    this.hasMore = true,
    this.isLoading = false,
    this.isLoadingMore = false,
    this.searchQuery = '',
    this.selectedTags = const [],
    this.sortOrder = FeedSortOrder.recent,
    this.errorMessage,
  });

  IdeasFeedState copyWith({
    List<IdeaModel>? ideas,
    bool? hasMore,
    bool? isLoading,
    bool? isLoadingMore,
    String? searchQuery,
    List<String>? selectedTags,
    FeedSortOrder? sortOrder,
    String? errorMessage,
  }) {
    return IdeasFeedState(
      ideas: ideas ?? this.ideas,
      hasMore: hasMore ?? this.hasMore,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      searchQuery: searchQuery ?? this.searchQuery,
      selectedTags: selectedTags ?? this.selectedTags,
      sortOrder: sortOrder ?? this.sortOrder,
      errorMessage: errorMessage,
    );
  }
}

/// ViewModel que gestiona el feed de Ideas con paginación, búsqueda y ordenación.
///
/// Patrón: el notifier acumula resultados (`_items`) y la UI reacciona a cada
/// cambio de estado. El usuario puede pedir más items explícitamente con
/// [loadMore] o resetear con [refresh].
@riverpod
class IdeasFeedNotifier extends _$IdeasFeedNotifier {
  int _offset = 0;

  @override
  IdeasFeedState build() {
    // Cargamos la primera página automáticamente al inicializar.
    Future.microtask(loadInitial);
    return const IdeasFeedState();
  }

  /// Carga la primera página desde cero (usado en la inicialización y refresh).
  Future<void> loadInitial() async {
    _offset = 0;
    state = state.copyWith(isLoading: true, ideas: [], errorMessage: null);
    try {
      final ideas = await ref
          .read(feedServiceProvider)
          .fetchIdeas(
            offset: 0,
            query: state.searchQuery,
            tags: state.selectedTags,
            sort: state.sortOrder,
          );
      _offset = ideas.length;
      state = state.copyWith(
        ideas: ideas,
        isLoading: false,
        hasMore: ideas.length >= kIdeasPageSize,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  /// Carga la siguiente página y la añade a la lista existente.
  Future<void> loadMore() async {
    if (!state.hasMore || state.isLoadingMore || state.isLoading) return;
    // En modo aleatorio no hay paginación secuencial: se vuelve a barajar.
    if (state.sortOrder == FeedSortOrder.random) {
      await loadInitial();
      return;
    }
    state = state.copyWith(isLoadingMore: true);
    try {
      final newIdeas = await ref
          .read(feedServiceProvider)
          .fetchIdeas(
            offset: _offset,
            query: state.searchQuery,
            tags: state.selectedTags,
            sort: state.sortOrder,
          );
      _offset += newIdeas.length;
      state = state.copyWith(
        ideas: [...state.ideas, ...newIdeas],
        isLoadingMore: false,
        hasMore: newIdeas.length >= kIdeasPageSize,
      );
    } catch (e) {
      state = state.copyWith(isLoadingMore: false, errorMessage: e.toString());
    }
  }

  /// Actualiza el texto de búsqueda y recarga desde la primera página.
  Future<void> updateSearch(String query) async {
    state = state.copyWith(searchQuery: query);
    await loadInitial();
  }

  /// Añade o quita un tag del filtro activo y recarga.
  Future<void> toggleTag(String tag) async {
    final current = List<String>.from(state.selectedTags);
    if (current.contains(tag)) {
      current.remove(tag);
    } else {
      current.add(tag);
    }
    state = state.copyWith(selectedTags: current);
    await loadInitial();
  }

  /// Alterna entre orden cronológico y aleatorio, y recarga.
  Future<void> toggleSortOrder() async {
    final newOrder = state.sortOrder == FeedSortOrder.recent
        ? FeedSortOrder.random
        : FeedSortOrder.recent;
    state = state.copyWith(sortOrder: newOrder);
    await loadInitial();
  }

  /// Limpia todos los filtros activos y recarga.
  Future<void> clearFilters() async {
    state = state.copyWith(
      searchQuery: '',
      selectedTags: [],
      sortOrder: FeedSortOrder.recent,
    );
    await loadInitial();
  }

  /// Recarga el feed desde la primera página manteniendo los filtros actuales.
  Future<void> refresh() async => loadInitial();
}
