// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get settingsTitle => 'Settings';

  @override
  String get languageSetting => 'Language';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageSpanish => 'Español';

  @override
  String get navFeed => 'Feed';

  @override
  String get navCreate => 'Create';

  @override
  String get navProfile => 'Profile';

  @override
  String get profileTitle => 'My Profile';

  @override
  String get profileVerifiedArtist => 'Verified Artist';

  @override
  String get profileTooltipSettings => 'Settings';

  @override
  String get profileTooltipLogout => 'Log out';

  @override
  String get profileErrorLoading => 'Could not load profile';

  @override
  String get profileNoIdeas => 'You haven\'t published any ideas yet.';

  @override
  String get profileNoDoodles => 'You haven\'t drawn any doodles yet.';

  @override
  String get profileNoArtworks =>
      'You haven\'t published any final artworks yet.';

  @override
  String get creationHubTitle => 'Create';

  @override
  String get creationHubNewIdea => 'New Idea';

  @override
  String get creationHubNewIdeaSubtitle =>
      'Write a prompt to challenge other artists.';

  @override
  String get creationHubNewDoodle => 'New Doodle';

  @override
  String get creationHubNewDoodleSubtitle =>
      'Open the canvas and draw on your own.';

  @override
  String get creationHubBookmarks => 'Bookmarks';

  @override
  String get creationHubBookmarksSubtitle =>
      'Your favorite ideas and doodles ready to use.';

  @override
  String get feedFiltersTitle => 'Filters & Sorting';

  @override
  String get feedFilterLanguage => 'Language';

  @override
  String get feedFilterSorting => 'Sorting';

  @override
  String get feedFilterAll => 'All';

  @override
  String get feedSortRecent => 'Recent';

  @override
  String get feedSortRandom => 'Random';

  @override
  String get feedSortPopular => 'Most popular';

  @override
  String get feedApplyFilters => 'Apply filters';

  @override
  String get feedClear => 'Clear';

  @override
  String get feedSearchPlaceholder => 'Search...';

  @override
  String get feedNoIdeas => 'No matching ideas found.';

  @override
  String get feedNoDoodles => 'No matching doodles found.';

  @override
  String get feedNoArtworks => 'No matching artworks found.';

  @override
  String suggestedBy(String username) {
    return 'suggested by @$username';
  }

  @override
  String doodledBy(String username) {
    return 'doodled by @$username';
  }

  @override
  String sharedBy(String username) {
    return 'shared by @$username';
  }

  @override
  String get ideaDetailTitle => 'Idea Detail';

  @override
  String get derivedCreationsTitle => 'Derived Creations';

  @override
  String get emptyIdeaCreationsTitle =>
      'No doodles or artworks for this idea yet!';

  @override
  String get emptyIdeaCreationsSubtitle =>
      'Be the first to bring this idea to life by drawing a doodle.';

  @override
  String get doodleDetailTitle => 'Doodle Detail';

  @override
  String get exploreRelationsLabel => 'Explore Relationships';

  @override
  String get viewOriginalIdeaOption => 'See original idea';

  @override
  String get viewSharedArtworksOption => 'See shared artworks';

  @override
  String get originalIdeaHeader => 'Original Idea:';

  @override
  String get sharedArtworksHeader => 'Shared Artworks:';

  @override
  String get emptyDoodleArtworksTitle => 'No artworks for this doodle yet!';

  @override
  String get emptyDoodleArtworksSubtitle =>
      'Be the first to create an artwork based on this doodle.';

  @override
  String get btnShareArtwork => 'Share Artwork';

  @override
  String get btnCreateAnother => 'Create another';

  @override
  String get artworkDetailTitle => 'Artwork Detail';

  @override
  String get previewError => 'Error loading preview';

  @override
  String get externalPlatformTitle => 'Artwork on external platform';

  @override
  String viewOnPlatform(String platform) {
    return 'View on $platform';
  }

  @override
  String get inspirationGenealogyTitle => 'Inspiration & Genealogy:';

  @override
  String get independentArtworkText =>
      'This artwork was uploaded independently, without any linked doodle or seed idea.';

  @override
  String get seedIdeaTraceTitle => '1. Original Seed Idea:';

  @override
  String get doodleTraceTitle => '2. Inspirational Sketch (Doodle):';

  @override
  String get singleDoodleTraceTitle => 'Inspirational Sketch (Doodle):';

  @override
  String get viewOriginalArtwork => 'See original artwork';

  @override
  String get profileBioLabel => 'Short Bio';

  @override
  String get profileBioHint => 'Write a short status message...';

  @override
  String get profileBioUpdateSuccess => 'Short message updated successfully!';

  @override
  String get profileBioSave => 'Save';

  @override
  String get profileBioCancel => 'Cancel';

  @override
  String profileOf(String username) {
    return '$username\'s Space';
  }

  @override
  String get otherProfileNoIdeas => 'No ideas published yet.';

  @override
  String get otherProfileNoDoodles => 'No doodles drawn yet.';

  @override
  String get otherProfileNoArtworks => 'No artworks shared yet.';

  @override
  String get profileSearchHint => 'Search creator...';

  @override
  String profileSearchUserNotFound(String username) {
    return 'User \'@$username\' not found';
  }

  @override
  String get settingsUsernameTitle => 'Username';

  @override
  String get settingsUsernameSubtitle => 'Change your unique username';

  @override
  String settingsUsernameCooldownError(String hours, String minutes) {
    return 'You must wait 24 hours to change your username again. ${hours}h ${minutes}m remaining.';
  }

  @override
  String get settingsUsernameConfirmTitle => 'Change Username?';

  @override
  String settingsUsernameConfirmMessage(String username) {
    return 'Are you sure you want to change your username to \'@$username\'? You won\'t be able to change it again for the next 24 hours.';
  }

  @override
  String settingsUsernameAlreadyTaken(String username) {
    return 'The username \'@$username\' is already in use.';
  }

  @override
  String get settingsUsernameSuccess => 'Username updated successfully!';

  @override
  String get settingsUsernameInvalid =>
      'Username can only contain letters, numbers, and underscores (3-20 characters).';

  @override
  String get btnConfirm => 'Confirm';

  @override
  String get btnSave => 'Save';

  @override
  String get settingsTutorialReplay => 'Replay General Tutorial';

  @override
  String get settingsTutorialSection => 'Help & Support';

  @override
  String get tutorialWelcome =>
      'Hello! I\'m your creative companion in \"whatdoidraw\" Whether it\'s to give ideas or to inspire you, I hope you have a great time!';

  @override
  String get tutorialConcept =>
      'Our application is based on a very simple idea: to inspire and be inspired. There are three main ways to interact with the community.';

  @override
  String get tutorialIdeas =>
      '1. Ideas: Don\'t know what to draw? Explore ideas suggested by others, or write your own creative prompt to challenge others.';

  @override
  String get tutorialDoodles =>
      '2. Doodles: Sketch quick doodles based on those ideas... or whatever you want.';

  @override
  String get tutorialArtworks =>
      '3. Artworks: Take doodles to the next level. If you like an idea or a doodle and create an artwork, publish it on your social media and share the link here. The creator of the idea or doodle will know what you created and can stop by to see it.';

  @override
  String get tutorialReady =>
      'That\'s all! You can review this tutorial or the help for each screen at any time. Happy drawing!';

  @override
  String get infoFeedIdeas =>
      'Here you can explore creative ideas from other users. Use them as inspiration. If you like an idea, you can tap on it to create a doodle or share your final artwork.';

  @override
  String get infoFeedDoodles =>
      'Here you\'ll see the Doodles drawn by the community. If you see one you like and create your own artwork, share the link!';

  @override
  String get infoFeedArtworks =>
      'Here you\'ll find the finished Artworks uploaded by users. These works always stem from a doodle or an idea. Tap on them to explore the idea or doodle that inspired them.';

  @override
  String get infoCreationHub =>
      'This is your creation center. From here you can propose a new Idea for someone to draw, start painting a Doodle freely on our canvas, or access your Saved items to continue later.';

  @override
  String get infoCreateIdea =>
      'Here you can propose a text-based creative idea. Add tags so others can find it, along with the language it\'s written in. Your ideas will appear in the Ideas tab of the Feed, and other users can use them to draw doodles inspired by them... or even to create a more elaborate artwork.';

  @override
  String get infoDoodleCanvas =>
      'Welcome to our Canvas! Here you can draw your sketches in a simple way. Remember, we don\'t look for perfection—just to convey an idea—so follow your heart. Don\'t forget to add tags to make it easier to find. When you save your doodle, it will be published so other users can see it and, if they wish, use it to create a final Artwork.';

  @override
  String get themeDark => 'Dark';

  @override
  String get themeLight => 'Light Green';

  @override
  String get themeDarkGreen => 'Dark Green';

  @override
  String get themeDarkPlus => 'Dark Plus';

  @override
  String get canvasToolLine => 'Line';

  @override
  String get canvasToolBrush => 'Brush';

  @override
  String get canvasToolEraserLine => 'Erase Line';

  @override
  String get canvasToolEraserColor => 'Erase Color';

  @override
  String get canvasToolBackground => 'Background';

  @override
  String get canvasEraserLineHelper =>
      'Line Eraser active. Drag your finger over a line to erase it.';

  @override
  String get canvasEraserColorHelper =>
      'Color Eraser active. Drag your finger over a color stroke to erase it.';

  @override
  String get canvasBackgroundColorDialogTitle => 'Background Color';

  @override
  String get canvasDialogClose => 'Close';

  @override
  String get btnCancel => 'Cancel';

  @override
  String get btnDelete => 'Delete';

  @override
  String get deleteIdeaDialogTitle => 'Delete Idea?';

  @override
  String get deleteIdeaDialogContent =>
      'This action cannot be undone. Creations (doodles or artworks) inspired by this idea will remain active for their creators, but the original idea will disappear.';

  @override
  String get deleteIdeaSuccess => 'Idea deleted successfully';

  @override
  String get deleteIdeaTooltip => 'Delete idea';

  @override
  String get deleteDoodleDialogTitle => 'Delete Doodle?';

  @override
  String get deleteDoodleDialogContent => 'This action cannot be undone.';

  @override
  String get deleteDoodleSuccess => 'Doodle deleted successfully';

  @override
  String get deleteDoodleTooltip => 'Delete drawing';

  @override
  String get deleteArtworkDialogTitle => 'Delete Artwork?';

  @override
  String get deleteArtworkDialogContent => 'This action cannot be undone.';

  @override
  String get deleteArtworkSuccess => 'Artwork deleted successfully';

  @override
  String get deleteArtworkTooltip => 'Delete artwork';

  @override
  String get deletedIdeaPlaceholder =>
      'The original idea has been deleted by its creator.';

  @override
  String get deletedDoodlePlaceholder =>
      'The original doodle that inspired this artwork has been deleted by its creator.';

  @override
  String get settingsLogoutConfirmTitle => 'Log out?';

  @override
  String get settingsLogoutConfirmMessage =>
      'Are you sure you want to log out of your account?';
}
