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

  @override
  String get settingsUsernameTitle => 'Nombre de usuario';

  @override
  String get settingsUsernameSubtitle => 'Cambia tu nombre de usuario único';

  @override
  String settingsUsernameCooldownError(String hours, String minutes) {
    return 'Debes esperar 24 horas para cambiar tu nombre de usuario de nuevo. Faltan ${hours}h ${minutes}m.';
  }

  @override
  String get settingsUsernameConfirmTitle => '¿Cambiar nombre de usuario?';

  @override
  String settingsUsernameConfirmMessage(String username) {
    return '¿Estás seguro de que deseas cambiar tu nombre de usuario a \'@$username\'? No podrás volver a cambiarlo durante las próximas 24 horas.';
  }

  @override
  String settingsUsernameAlreadyTaken(String username) {
    return 'El nombre de usuario \'@$username\' ya está en uso.';
  }

  @override
  String get settingsUsernameSuccess =>
      '¡Nombre de usuario actualizado con éxito!';

  @override
  String get settingsUsernameInvalid =>
      'El nombre de usuario solo puede contener letras, números y guiones bajos (3-20 caracteres).';

  @override
  String get btnConfirm => 'Confirmar';

  @override
  String get btnSave => 'Guardar';

  @override
  String get settingsTutorialReplay => 'Repetir Tutorial General';

  @override
  String get settingsTutorialSection => 'Ayuda y Soporte';

  @override
  String get tutorialWelcome =>
      '¡Hola! Soy tu compañero creativo en \"whatdoidraw\" Ya sea para dar ideas o para inspirarte,¡Espero que lo pases bien!';

  @override
  String get tutorialConcept =>
      'Nuestra aplicación se basa en una idea muy simple: inspirar y ser inspirado. Hay tres formas principales de interactuar con la comunidad.';

  @override
  String get tutorialIdeas =>
      '1. Ideas: ¿No sabes qué dibujar? Explora ideas sugeridas por otros, o escribe tu propio prompt creativo para desafiar a los demás.';

  @override
  String get tutorialDoodles =>
      '2. Doodles: Dibuja bocetos rápidos basados en esas ideas... o lo que quieras.';

  @override
  String get tutorialArtworks =>
      '3. Artworks: Lleva los doodles al siguiente nivel. Si te gusta alguna idea o boceto y creas una pieza de arte, publícala en tu red social y comparte el enlace por aquí. El creador de la idea o doodle sabrá que has creado y se podrá pasar a verlo. ';

  @override
  String get tutorialReady =>
      '¡Eso es todo! Puedes repasar este tutorial o las ayudas de cada pantalla en cualquier momento. ¡Feliz dibujo!';

  @override
  String get infoFeedIdeas =>
      'Aquí puedes explorar las ideas creativas de otros usuarios. Úsalas como inspiración. Si una idea te gusta, puedes pulsar en ella para crear un doodle (boceto) o compartir tu creación final (Artwork)';

  @override
  String get infoFeedDoodles =>
      'Aquí verás los Doodles dibujados por la comunidad. Si ves uno que te guste y creas alguna pieza de arte por tu cuenta, ¡comparte el link!';

  @override
  String get infoFeedArtworks =>
      'Aquí están las obras de arte terminadas (Artworks) subidas por los usuarios. Estas obras siempre proceden de un doodle o una idea. Puedes pulsar sobre ellas para explorar la idea o doodle que las inspiraron.';

  @override
  String get infoCreationHub =>
      'Este es tu centro de creación. Desde aquí puedes proponer una nueva Idea para que alguien la dibuje, empezar a pintar libremente un Doodle (un boceto en nuestro lienzo), o acceder a tus elementos Guardados para continuar más tarde.';

  @override
  String get infoCreateIdea =>
      'Aquí puedes proponer una idea creativa en texto. Añade etiquetas para que la puedan encontrar y el idioma en que la has escrito. Tus ideas aparecerán en la pestaña Ideas del Feed, y otros usuarios podrán usarlas para dibujar doodles inspirados en ellas... O incluso para hacer una obra más elaborada.';

  @override
  String get infoDoodleCanvas =>
      '¡Bienvenido a nuestro Lienzo! Aquí puedes dibujar tus bocetos de manera sencilla. Recuerda, no buscamos la perfección, solo dar una idea, así que sigue tu corazón. No olvides añadir etiquetas para que se pueda encontrar más fácilmente. Cuando guardes tu doodle, se publicará para que otros usuarios puedan verlo y, si lo desean, usarlo para crear una obra final (Artwork).';
}
