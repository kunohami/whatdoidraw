import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
  ];

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @languageSetting.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get languageSetting;

  /// No description provided for @languageEnglish.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get languageEnglish;

  /// No description provided for @languageSpanish.
  ///
  /// In en, this message translates to:
  /// **'Español'**
  String get languageSpanish;

  /// No description provided for @navFeed.
  ///
  /// In en, this message translates to:
  /// **'Feed'**
  String get navFeed;

  /// No description provided for @navCreate.
  ///
  /// In en, this message translates to:
  /// **'Create'**
  String get navCreate;

  /// No description provided for @navProfile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get navProfile;

  /// No description provided for @profileTitle.
  ///
  /// In en, this message translates to:
  /// **'My Profile'**
  String get profileTitle;

  /// No description provided for @profileVerifiedArtist.
  ///
  /// In en, this message translates to:
  /// **'Verified Artist'**
  String get profileVerifiedArtist;

  /// No description provided for @profileTooltipSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get profileTooltipSettings;

  /// No description provided for @profileTooltipLogout.
  ///
  /// In en, this message translates to:
  /// **'Log out'**
  String get profileTooltipLogout;

  /// No description provided for @profileErrorLoading.
  ///
  /// In en, this message translates to:
  /// **'Could not load profile'**
  String get profileErrorLoading;

  /// No description provided for @profileNoIdeas.
  ///
  /// In en, this message translates to:
  /// **'You haven\'t published any ideas yet.'**
  String get profileNoIdeas;

  /// No description provided for @profileNoDoodles.
  ///
  /// In en, this message translates to:
  /// **'You haven\'t drawn any doodles yet.'**
  String get profileNoDoodles;

  /// No description provided for @profileNoArtworks.
  ///
  /// In en, this message translates to:
  /// **'You haven\'t published any final artworks yet.'**
  String get profileNoArtworks;

  /// No description provided for @creationHubTitle.
  ///
  /// In en, this message translates to:
  /// **'What are we creating today?'**
  String get creationHubTitle;

  /// No description provided for @creationHubNewIdea.
  ///
  /// In en, this message translates to:
  /// **'New Idea'**
  String get creationHubNewIdea;

  /// No description provided for @creationHubNewIdeaSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Write a prompt to challenge other artists.'**
  String get creationHubNewIdeaSubtitle;

  /// No description provided for @creationHubNewDoodle.
  ///
  /// In en, this message translates to:
  /// **'New Doodle'**
  String get creationHubNewDoodle;

  /// No description provided for @creationHubNewDoodleSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Open the canvas and draw on your own.'**
  String get creationHubNewDoodleSubtitle;

  /// No description provided for @creationHubBookmarks.
  ///
  /// In en, this message translates to:
  /// **'Bookmarks'**
  String get creationHubBookmarks;

  /// No description provided for @creationHubBookmarksSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Your favorite ideas and doodles ready to use.'**
  String get creationHubBookmarksSubtitle;

  /// No description provided for @feedFiltersTitle.
  ///
  /// In en, this message translates to:
  /// **'Filters & Sorting'**
  String get feedFiltersTitle;

  /// No description provided for @feedFilterLanguage.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get feedFilterLanguage;

  /// No description provided for @feedFilterSorting.
  ///
  /// In en, this message translates to:
  /// **'Sorting'**
  String get feedFilterSorting;

  /// No description provided for @feedFilterAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get feedFilterAll;

  /// No description provided for @feedSortRecent.
  ///
  /// In en, this message translates to:
  /// **'Recent'**
  String get feedSortRecent;

  /// No description provided for @feedSortRandom.
  ///
  /// In en, this message translates to:
  /// **'Random'**
  String get feedSortRandom;

  /// No description provided for @feedSortPopular.
  ///
  /// In en, this message translates to:
  /// **'Most popular'**
  String get feedSortPopular;

  /// No description provided for @feedApplyFilters.
  ///
  /// In en, this message translates to:
  /// **'Apply filters'**
  String get feedApplyFilters;

  /// No description provided for @feedClear.
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get feedClear;

  /// No description provided for @feedSearchPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Search...'**
  String get feedSearchPlaceholder;

  /// No description provided for @feedNoIdeas.
  ///
  /// In en, this message translates to:
  /// **'No matching ideas found.'**
  String get feedNoIdeas;

  /// No description provided for @feedNoDoodles.
  ///
  /// In en, this message translates to:
  /// **'No matching doodles found.'**
  String get feedNoDoodles;

  /// No description provided for @feedNoArtworks.
  ///
  /// In en, this message translates to:
  /// **'No matching artworks found.'**
  String get feedNoArtworks;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
