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

  @override
  String get ideaDetailTitle => 'Detalle de la Idea';

  @override
  String get derivedCreationsTitle => 'Creaciones derivadas';

  @override
  String get emptyIdeaCreationsTitle =>
      '¡Aún no hay doodles ni obras de arte para esta idea!';

  @override
  String get emptyIdeaCreationsSubtitle =>
      'Sé el primero en dar vida a esta idea dibujando un boceto.';

  @override
  String get doodleDetailTitle => 'Detalle del Doodle';

  @override
  String get exploreRelationsLabel => 'Explorar relaciones';

  @override
  String get viewOriginalIdeaOption => 'Ver idea original';

  @override
  String get viewSharedArtworksOption => 'Ver obras de arte compartidas';

  @override
  String get originalIdeaHeader => 'Idea Original:';

  @override
  String get sharedArtworksHeader => 'Obras de arte compartidas:';

  @override
  String get emptyDoodleArtworksTitle =>
      '¡Aún no hay obras de arte para este doodle!';

  @override
  String get emptyDoodleArtworksSubtitle =>
      'Sé el primero en crear una obra de arte basada en este doodle.';

  @override
  String get btnShareArtwork => 'Compartir Obra';

  @override
  String get btnCreateAnother => 'Crear otro';

  @override
  String get artworkDetailTitle => 'Detalle de la Obra';

  @override
  String get previewError => 'Error al cargar la previsualización';

  @override
  String get externalPlatformTitle => 'Obra en plataforma externa';

  @override
  String viewOnPlatform(String platform) {
    return 'Ver en $platform';
  }

  @override
  String get inspirationGenealogyTitle => 'Inspiración y Genealogía:';

  @override
  String get independentArtworkText =>
      'Esta obra fue subida de forma independiente, sin un boceto o idea vinculada.';

  @override
  String get seedIdeaTraceTitle => '1. Idea Semilla Original:';

  @override
  String get doodleTraceTitle => '2. Boceto (Doodle) de Inspiración:';

  @override
  String get singleDoodleTraceTitle => 'Boceto (Doodle) de Inspiración:';

  @override
  String get viewOriginalArtwork => 'Ver obra original';

  @override
  String get profileBioLabel => 'Mensaje Corto';

  @override
  String get profileBioHint => 'Escribe un mensaje de estado corto...';

  @override
  String get profileBioUpdateSuccess =>
      '¡Mensaje de estado actualizado con éxito!';

  @override
  String get profileBioSave => 'Guardar';

  @override
  String get profileBioCancel => 'Cancelar';

  @override
  String profileOf(String username) {
    return 'Espacio de $username';
  }

  @override
  String get otherProfileNoIdeas => 'Aún no ha publicado ideas.';

  @override
  String get otherProfileNoDoodles => 'Aún no ha dibujado ningún doodle.';

  @override
  String get otherProfileNoArtworks =>
      'Aún no ha compartido ningún artwork final.';

  @override
  String get profileSearchHint => 'Buscar creador...';

  @override
  String profileSearchUserNotFound(String username) {
    return 'Usuario \'@$username\' no encontrado';
  }
}
