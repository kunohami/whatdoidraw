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
  String get navFeed => 'Novedades';

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
  String get profileNoDoodles => 'Aún no has dibujado ningún boceto.';

  @override
  String get profileNoArtworks => 'Aún no has publicado ningún arte final.';

  @override
  String get creationHubTitle => 'Crear';

  @override
  String get creationHubNewIdea => 'Nueva Idea';

  @override
  String get creationHubNewIdeaSubtitle =>
      'Escribe un prompt para desafiar a los dibujantes.';

  @override
  String get creationHubNewDoodle => 'Nuevo Boceto';

  @override
  String get creationHubNewDoodleSubtitle =>
      'Abre el lienzo y dibuja por tu cuenta.';

  @override
  String get creationHubBookmarks => 'Guardados';

  @override
  String get creationHubBookmarksSubtitle =>
      'Tus ideas y bocetos favoritos listos para usar.';

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
  String get feedNoDoodles => 'No hay bocetos que coincidan.';

  @override
  String get feedNoArtworks => 'No hay arte que coincida.';

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
      '¡Aún no hay bocetos ni arte para esta idea!';

  @override
  String get emptyIdeaCreationsSubtitle =>
      'Sé el primero en dar vida a esta idea dibujando un boceto.';

  @override
  String get doodleDetailTitle => 'Detalle del Boceto';

  @override
  String get exploreRelationsLabel => 'Explorar relaciones';

  @override
  String get viewOriginalIdeaOption => 'Ver idea original';

  @override
  String get viewSharedArtworksOption => 'Ver arte compartido';

  @override
  String get originalIdeaHeader => 'Idea Original:';

  @override
  String get sharedArtworksHeader => 'Arte compartido:';

  @override
  String get emptyDoodleArtworksTitle => '¡Aún no hay arte para este boceto!';

  @override
  String get emptyDoodleArtworksSubtitle =>
      'Sé el primero en crear arte basado en este boceto.';

  @override
  String get btnShareArtwork => 'Compartir Arte';

  @override
  String get btnCreateAnother => 'Crear otro';

  @override
  String get artworkDetailTitle => 'Detalle del Arte';

  @override
  String get previewError => 'Error al cargar la previsualización';

  @override
  String get externalPlatformTitle => 'Arte en plataforma externa';

  @override
  String viewOnPlatform(String platform) {
    return 'Ver en $platform';
  }

  @override
  String get inspirationGenealogyTitle => 'Inspiración y Genealogía:';

  @override
  String get independentArtworkText =>
      'Este arte fue subido de forma independiente, sin un boceto o idea vinculados.';

  @override
  String get seedIdeaTraceTitle => '1. Idea Semilla Original:';

  @override
  String get doodleTraceTitle => '2. Boceto de Inspiración:';

  @override
  String get singleDoodleTraceTitle => 'Boceto de Inspiración:';

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
  String get otherProfileNoDoodles => 'Aún no ha dibujado ningún boceto.';

  @override
  String get otherProfileNoArtworks =>
      'Aún no ha compartido ningún arte final.';

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
      '¡Hola! Te doy la bienvenida a \"whatdoidraw\" Ya sea para dar ideas o para inspirarte,¡Espero que lo pases bien!';

  @override
  String get tutorialConcept =>
      'Esta aplicación se basa en una idea muy simple: inspirar y ser inspirado. Hay tres formas principales de interactuar con la comunidad.';

  @override
  String get tutorialIdeas =>
      '1. Ideas: ¿No sabes qué dibujar? Explora ideas sugeridas por otros, o escribe tu propio prompt creativo para desafiar a los demás.';

  @override
  String get tutorialDoodles =>
      '2. Bocetos: Dibuja bocetos rápidos basados en esas ideas... o lo que quieras.';

  @override
  String get tutorialArtworks =>
      '3. Arte: Lleva los bocetos al siguiente nivel. Si te gusta alguna idea o boceto y creas arte, publícalo en tu red social y comparte el enlace por aquí. El creador de la idea o boceto sabrá qué has creado y se podrá pasar a verlo. ';

  @override
  String get tutorialReady =>
      '¡Eso es todo! Puedes repasar este tutorial o las ayudas de cada pantalla en cualquier momento. ¡A inspirar!';

  @override
  String get infoFeedIdeas =>
      'Aquí puedes explorar las ideas creativas de otros usuarios. Úsalas como inspiración. Si una idea te gusta, puedes pulsar en ella para crear un boceto o compartir tu arte final';

  @override
  String get infoFeedDoodles =>
      'Aquí verás los bocetos dibujados por la comunidad. Si ves uno que te guste y creas arte por tu cuenta, ¡comparte el enlace!';

  @override
  String get infoFeedArtworks =>
      'Aquí está el arte terminado subido por los usuarios. Este arte siempre procede de un boceto o una idea. Puedes pulsar sobre él para explorar la idea o boceto que lo inspiraron.';

  @override
  String get infoCreationHub =>
      'Este es tu centro de creación. Desde aquí puedes proponer una nueva Idea para que alguien la dibuje, empezar a pintar libremente un boceto (en nuestro lienzo), o acceder a tus elementos guardados para continuar más tarde.';

  @override
  String get infoCreateIdea =>
      'Aquí puedes proponer una idea creativa en texto. Añade etiquetas para que la puedan encontrar y el idioma en que la has escrito. Tus ideas aparecerán en la pestaña Ideas de Novedades, y otros usuarios podrán usarlas para dibujar bocetos inspirados en ellas... O incluso para crear arte.';

  @override
  String get infoDoodleCanvas =>
      '¡Bienvenido a nuestro lienzo! Aquí puedes dibujar tus bocetos de manera sencilla. Recuerda, no buscamos la perfección, solo dar una idea, así que sigue tu corazón. No olvides añadir etiquetas para que se pueda encontrar más fácilmente. Cuando guardes tu boceto, se publicará para que otros usuarios puedan verlo y, si lo desean, usarlo para crear arte final.';

  @override
  String get themeDark => 'Oscuro';

  @override
  String get themeLight => 'Verde Claro';

  @override
  String get themeDarkGreen => 'Verde Oscuro';

  @override
  String get themeDarkPlus => 'Oscuro Plus';

  @override
  String get canvasToolLine => 'Línea';

  @override
  String get canvasToolBrush => 'Pincel';

  @override
  String get canvasToolEraserLine => 'Borrador Líneas';

  @override
  String get canvasToolEraserColor => 'Borrador Colores';

  @override
  String get canvasToolBackground => 'Fondo';

  @override
  String get canvasEraserLineHelper =>
      'Borrador de Líneas activo. Pasa el dedo por una línea para borrarla.';

  @override
  String get canvasEraserColorHelper =>
      'Borrador de Color activo. Pasa el dedo por una pincelada para borrarla.';

  @override
  String get canvasBackgroundColorDialogTitle => 'Color del Fondo';

  @override
  String get canvasDialogClose => 'Cerrar';

  @override
  String get btnCancel => 'Cancelar';

  @override
  String get btnDelete => 'Eliminar';

  @override
  String get deleteIdeaDialogTitle => '¿Eliminar Idea?';

  @override
  String get deleteIdeaDialogContent =>
      'Esta acción no se puede deshacer. Las creaciones (doodles o artworks) inspiradas en esta idea seguirán activas para sus creadores, pero la idea original desaparecerá.';

  @override
  String get deleteIdeaSuccess => 'Idea eliminada correctamente';

  @override
  String get deleteIdeaTooltip => 'Eliminar idea';

  @override
  String get deleteDoodleDialogTitle => '¿Eliminar Boceto?';

  @override
  String get deleteDoodleDialogContent => 'Esta acción no se puede deshacer.';

  @override
  String get deleteDoodleSuccess => 'Boceto eliminado correctamente';

  @override
  String get deleteDoodleTooltip => 'Eliminar boceto';

  @override
  String get deleteArtworkDialogTitle => '¿Eliminar Arte?';

  @override
  String get deleteArtworkDialogContent => 'Esta acción no se puede deshacer.';

  @override
  String get deleteArtworkSuccess => 'Arte eliminado correctamente';

  @override
  String get deleteArtworkTooltip => 'Eliminar arte';

  @override
  String get deletedIdeaPlaceholder =>
      'La idea original ha sido borrada por su creador.';

  @override
  String get deletedDoodlePlaceholder =>
      'El boceto original que inspiró este arte ha sido borrado por su creador.';

  @override
  String get settingsLogoutConfirmTitle => '¿Cerrar sesión?';

  @override
  String get settingsLogoutConfirmMessage =>
      '¿Estás seguro de que deseas cerrar sesión en tu cuenta?';

  @override
  String get canvasClearConfirmTitle => '¿Limpiar lienzo?';

  @override
  String get canvasClearConfirmMessage =>
      '¿Estás seguro de que deseas limpiar todo tu dibujo? Esta acción no se puede deshacer.';

  @override
  String get createIdeaSuccessDialogTitle => '¡Idea publicada!';

  @override
  String get createIdeaSuccessDialogContent =>
      '¿Te gustaría escribir otra idea creativa o prefieres salir?';

  @override
  String get btnWriteAnother => 'Escribir otra';

  @override
  String get btnExit => 'Salir';

  @override
  String get settingsSelectThemeTitle => 'Seleccionar Tema';

  @override
  String get settingsEmailAccount => 'Cuenta de correo';

  @override
  String get settingsNotAvailable => 'No disponible';

  @override
  String get settingsVisualTheme => 'Tema visual';

  @override
  String get settingsPushNotifications => 'Notificaciones en el móvil (Push)';

  @override
  String get settingsEmailNotifications => 'Notificaciones por Correo';

  @override
  String get tooltipHelp => 'Ayuda';

  @override
  String get tooltipNotifications => 'Notificaciones';

  @override
  String get tutorialSkip => 'Saltar tutorial';

  @override
  String get tutorialNext => 'Siguiente';

  @override
  String get tutorialStart => '¡Empezar!';

  @override
  String get tabIdeas => 'Ideas';

  @override
  String get tabDoodles => 'Bocetos';

  @override
  String get tabArtworks => 'Arte';

  @override
  String get bookmarksNoIdeas => 'No tienes ideas guardadas.';

  @override
  String get bookmarksNoDoodles => 'No tienes bocetos guardados.';

  @override
  String get createIdeaPromptQuestion =>
      '¿Qué te gustaría que alguien dibujara hoy?';

  @override
  String get createIdeaPromptHint => 'Ej: Un gato astronauta bebiendo café...';

  @override
  String get createIdeaSubmitBtn => 'Enviar Idea';

  @override
  String get canvasAddTagsTitle => 'Añadir etiquetas';

  @override
  String get canvasAddTagsSubtitle =>
      'Ayuda a otros a descubrir tu boceto con etiquetas descriptivas.';

  @override
  String get canvasPublishBtn => 'Publicar Boceto';

  @override
  String get canvasPublishAction => 'PUBLICAR';

  @override
  String get canvasUploading => 'Subiendo tu boceto...';

  @override
  String get createArtworkSuccessSnackBar => '¡Arte publicado correctamente!';

  @override
  String get createArtworkTitle => 'Publicar Arte';

  @override
  String get createArtworkInstruction =>
      'Enlaza tu obra final para compartirla. Si usas DeviantArt o Bluesky, se mostrará una miniatura automáticamente.';

  @override
  String get createArtworkUrlLabel => 'URL del Arte';

  @override
  String get createArtworkUrlHint => 'DeviantArt o Bluesky...';

  @override
  String get createArtworkUrlRequired => 'Introduce una URL';

  @override
  String get createArtworkUrlInvalid =>
      'Introduce una red social válida (Instagram, ArtStation, Cara, etc.)';

  @override
  String get createArtworkTagsLabel => 'Etiquetas (Tags)';

  @override
  String get createArtworkTagAddHint => 'Añadir etiqueta...';

  @override
  String get createArtworkLoadPreviewBtn => 'Cargar Vista Previa';

  @override
  String createArtworkAuthorFormat(String author, String provider) {
    return 'por $author ($provider)';
  }

  @override
  String get createArtworkNoThumbnailNote =>
      'Nota: No hay miniatura disponible para esta plataforma. Se mostrará solo el enlace.';

  @override
  String genericError(String error) {
    return 'Error: $error';
  }

  @override
  String get profileVisitorMode => 'Modo Visitante';

  @override
  String get profileExpandHint => 'Desliza hacia abajo para expandir';

  @override
  String get profileTooltipSearch => 'Buscar creadores';

  @override
  String get profileTooltipSearchAction => 'Buscar';
}
