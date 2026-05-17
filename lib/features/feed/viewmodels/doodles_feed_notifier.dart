import 'dart:ui';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:whatdoidraw/core/constants/feed_constants.dart';
import 'package:whatdoidraw/features/feed/models/feed_sort_order.dart';
import 'package:whatdoidraw/features/feed/services/feed_service.dart';
import 'package:whatdoidraw/shared/models/doodle_model.dart';

part 'doodles_feed_notifier.g.dart';

/// Estado inmutable que contiene toda la información necesaria para renderizar
/// la pestaña de Doodles del Feed.
class DoodlesFeedState {
  /// Lista acumulada de doodles ya cargados.
  final List<DoodleModel> doodles;

  /// Indica si hay más páginas disponibles en el servidor.
  final bool hasMore;

  /// Indica si se está cargando la primera página.
  final bool isLoading;

  /// Indica si se está cargando una página adicional ("cargar más").
  final bool isLoadingMore;

  /// Texto de búsqueda libre.
  final String searchQuery;

  /// Lista de tags activos como filtro.
  final List<String> selectedTags;

  /// Modo de ordenación activo.
  final FeedSortOrder sortOrder;

  /// Filtro de idioma activo.
  final String? languageFilter;

  /// Mensaje de error, si lo hay.
  final String? errorMessage;

  const DoodlesFeedState({
    this.doodles = const [],
    this.hasMore = true,
    this.isLoading = false,
    this.isLoadingMore = false,
    this.searchQuery = '',
    this.selectedTags = const [],
    this.sortOrder = FeedSortOrder.recent,
    this.languageFilter,
    this.errorMessage,
  });

  DoodlesFeedState copyWith({
    List<DoodleModel>? doodles,
    bool? hasMore,
    bool? isLoading,
    bool? isLoadingMore,
    String? searchQuery,
    List<String>? selectedTags,
    FeedSortOrder? sortOrder,
    String? languageFilter,
    String? errorMessage,
  }) {
    return DoodlesFeedState(
      doodles: doodles ?? this.doodles,
      hasMore: hasMore ?? this.hasMore,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      searchQuery: searchQuery ?? this.searchQuery,
      selectedTags: selectedTags ?? this.selectedTags,
      sortOrder: sortOrder ?? this.sortOrder,
      languageFilter: languageFilter ?? this.languageFilter,
      errorMessage: errorMessage,
    );
  }
}

/// ViewModel que gestiona el feed de Doodles con paginación y filtros por tags.
@riverpod
class DoodlesFeedNotifier extends _$DoodlesFeedNotifier {
  int _offset = 0;

  @override
  DoodlesFeedState build() {
    final locale = PlatformDispatcher.instance.locale.languageCode;
    final defaultLanguage = locale.startsWith('es') ? 'es' : 'en';

    Future.microtask(loadInitial);
    return DoodlesFeedState(languageFilter: defaultLanguage);
  }

  /// Carga la primera página desde cero.
  Future<void> loadInitial() async {
    _offset = 0;
    state = state.copyWith(isLoading: true, doodles: [], errorMessage: null);
    try {
      final doodles = await ref
          .read(feedServiceProvider)
          .fetchDoodles(
            offset: 0,
            query: state.searchQuery,
            tags: state.selectedTags,
            sort: state.sortOrder,
            language: state.languageFilter,
          );
      _offset = doodles.length;
      state = state.copyWith(
        doodles: doodles,
        isLoading: false,
        hasMore: doodles.length >= kDoodlesPageSize,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  /// Carga la siguiente página y la añade a la lista existente.
  Future<void> loadMore() async {
    if (!state.hasMore || state.isLoadingMore || state.isLoading) return;
    if (state.sortOrder == FeedSortOrder.random) {
      await loadInitial();
      return;
    }
    state = state.copyWith(isLoadingMore: true);
    try {
      final newDoodles = await ref
          .read(feedServiceProvider)
          .fetchDoodles(
            offset: _offset,
            query: state.searchQuery,
            tags: state.selectedTags,
            sort: state.sortOrder,
            language: state.languageFilter,
          );
      _offset += newDoodles.length;
      state = state.copyWith(
        doodles: [...state.doodles, ...newDoodles],
        isLoadingMore: false,
        hasMore: newDoodles.length >= kDoodlesPageSize,
      );
    } catch (e) {
      state = state.copyWith(isLoadingMore: false, errorMessage: e.toString());
    }
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

  /// Cambia el modo de ordenación y recarga.
  Future<void> setSortOrder(FeedSortOrder order) async {
    state = state.copyWith(sortOrder: order);
    await loadInitial();
  }

  /// Alterna entre orden cronológico y aleatorio, y recarga.
  Future<void> toggleSortOrder() async {
    final newOrder = state.sortOrder == FeedSortOrder.recent
        ? FeedSortOrder.random
        : FeedSortOrder.recent;
    await setSortOrder(newOrder);
  }

  /// Limpia todos los filtros activos y recarga.
  Future<void> clearFilters() async {
    final locale = PlatformDispatcher.instance.locale.languageCode;
    final defaultLanguage = locale.startsWith('es') ? 'es' : 'en';

    state = state.copyWith(
      selectedTags: [],
      sortOrder: FeedSortOrder.recent,
      searchQuery: '',
      languageFilter: defaultLanguage,
    );
    await loadInitial();
  }

  /// Actualiza el texto de búsqueda y recarga.
  Future<void> updateSearch(String query) async {
    state = state.copyWith(searchQuery: query);
    await loadInitial();
  }

  Future<void> setLanguageFilter(String? language) async {
    state = state.copyWith(languageFilter: language);
  }

  /// Recarga el feed desde la primera página manteniendo los filtros actuales.
  Future<void> refresh() async => loadInitial();

  /// Actualiza la lista de doodles (usado para updates optimistas de likes).
  void updateStateFromLike(List<DoodleModel> updatedDoodles) {
    state = state.copyWith(doodles: updatedDoodles);
  }
}
