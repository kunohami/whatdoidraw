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
  String get creationHubTitle => 'What are we creating today?';

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
}
