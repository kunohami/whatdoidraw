// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get settingsTitle => 'Ajustes';

  @override
  String get languageSetting => 'Idioma';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageSpanish => 'Español';

  @override
  String get navFeed => 'Feed';

  @override
  String get navCreate => 'Crear';

  @override
  String get navProfile => 'Perfil';

  @override
  String get profileTitle => 'Mi Perfil';

  @override
  String get profileVerifiedArtist => 'Artista Verificado';

  @override
  String get profileTooltipSettings => 'Ajustes';

  @override
  String get profileTooltipLogout => 'Cerrar sesión';

  @override
  String get profileErrorLoading => 'No se pudo cargar el perfil';

  @override
  String get profileNoIdeas => 'Aún no has publicado ideas.';

  @override
  String get profileNoDoodles => 'Aún no has dibujado ningún doodle.';

  @override
  String get profileNoArtworks => 'Aún no has publicado ningún artwork final.';

  @override
  String get creationHubTitle => '¿Qué vamos a crear hoy?';

  @override
  String get creationHubNewIdea => 'Nueva Idea';

  @override
  String get creationHubNewIdeaSubtitle =>
      'Escribe un prompt para desafiar a los dibujantes.';

  @override
  String get creationHubNewDoodle => 'Nuevo Doodle';

  @override
  String get creationHubNewDoodleSubtitle =>
      'Abre el lienzo y dibuja por tu cuenta.';

  @override
  String get creationHubBookmarks => 'Guardados';

  @override
  String get creationHubBookmarksSubtitle =>
      'Tus ideas y doodles favoritos listos para usar.';

  @override
  String get feedFiltersTitle => 'Filtros y Ordenación';

  @override
  String get feedFilterLanguage => 'Idioma';

  @override
  String get feedFilterSorting => 'Ordenación';

  @override
  String get feedFilterAll => 'Todos';

  @override
  String get feedSortRecent => 'Reciente';

  @override
  String get feedSortRandom => 'Aleatorio';

  @override
  String get feedSortPopular => 'Más populares';

  @override
  String get feedApplyFilters => 'Aplicar filtros';

  @override
  String get feedClear => 'Limpiar';

  @override
  String get feedSearchPlaceholder => 'Buscar...';

  @override
  String get feedNoIdeas => 'No hay ideas que coincidan.';

  @override
  String get feedNoDoodles => 'No hay doodles que coincidan.';

  @override
  String get feedNoArtworks => 'No hay obras que coincidan.';

  @override
  String suggestedBy(String username) {
    return 'sugerido por @$username';
  }

  @override
  String doodledBy(String username) {
    return 'bocetado por @$username';
  }

  @override
  String sharedBy(String username) {
    return 'compartido por @$username';
  }
}
