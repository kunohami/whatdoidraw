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
}
