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
  /// **'Create'**
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

  /// No description provided for @suggestedBy.
  ///
  /// In en, this message translates to:
  /// **'suggested by @{username}'**
  String suggestedBy(String username);

  /// No description provided for @doodledBy.
  ///
  /// In en, this message translates to:
  /// **'doodled by @{username}'**
  String doodledBy(String username);

  /// No description provided for @sharedBy.
  ///
  /// In en, this message translates to:
  /// **'shared by @{username}'**
  String sharedBy(String username);

  /// No description provided for @ideaDetailTitle.
  ///
  /// In en, this message translates to:
  /// **'Idea Detail'**
  String get ideaDetailTitle;

  /// No description provided for @derivedCreationsTitle.
  ///
  /// In en, this message translates to:
  /// **'Derived Creations'**
  String get derivedCreationsTitle;

  /// No description provided for @emptyIdeaCreationsTitle.
  ///
  /// In en, this message translates to:
  /// **'No doodles or artworks for this idea yet!'**
  String get emptyIdeaCreationsTitle;

  /// No description provided for @emptyIdeaCreationsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Be the first to bring this idea to life by drawing a doodle.'**
  String get emptyIdeaCreationsSubtitle;

  /// No description provided for @doodleDetailTitle.
  ///
  /// In en, this message translates to:
  /// **'Doodle Detail'**
  String get doodleDetailTitle;

  /// No description provided for @exploreRelationsLabel.
  ///
  /// In en, this message translates to:
  /// **'Explore Relationships'**
  String get exploreRelationsLabel;

  /// No description provided for @viewOriginalIdeaOption.
  ///
  /// In en, this message translates to:
  /// **'See original idea'**
  String get viewOriginalIdeaOption;

  /// No description provided for @viewSharedArtworksOption.
  ///
  /// In en, this message translates to:
  /// **'See shared artworks'**
  String get viewSharedArtworksOption;

  /// No description provided for @originalIdeaHeader.
  ///
  /// In en, this message translates to:
  /// **'Original Idea:'**
  String get originalIdeaHeader;

  /// No description provided for @sharedArtworksHeader.
  ///
  /// In en, this message translates to:
  /// **'Shared Artworks:'**
  String get sharedArtworksHeader;

  /// No description provided for @emptyDoodleArtworksTitle.
  ///
  /// In en, this message translates to:
  /// **'No artworks for this doodle yet!'**
  String get emptyDoodleArtworksTitle;

  /// No description provided for @emptyDoodleArtworksSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Be the first to create an artwork based on this doodle.'**
  String get emptyDoodleArtworksSubtitle;

  /// No description provided for @btnShareArtwork.
  ///
  /// In en, this message translates to:
  /// **'Share Artwork'**
  String get btnShareArtwork;

  /// No description provided for @btnCreateAnother.
  ///
  /// In en, this message translates to:
  /// **'Create another'**
  String get btnCreateAnother;

  /// No description provided for @artworkDetailTitle.
  ///
  /// In en, this message translates to:
  /// **'Artwork Detail'**
  String get artworkDetailTitle;

  /// No description provided for @previewError.
  ///
  /// In en, this message translates to:
  /// **'Error loading preview'**
  String get previewError;

  /// No description provided for @externalPlatformTitle.
  ///
  /// In en, this message translates to:
  /// **'Artwork on external platform'**
  String get externalPlatformTitle;

  /// No description provided for @viewOnPlatform.
  ///
  /// In en, this message translates to:
  /// **'View on {platform}'**
  String viewOnPlatform(String platform);

  /// No description provided for @inspirationGenealogyTitle.
  ///
  /// In en, this message translates to:
  /// **'Inspiration & Genealogy:'**
  String get inspirationGenealogyTitle;

  /// No description provided for @independentArtworkText.
  ///
  /// In en, this message translates to:
  /// **'This artwork was uploaded independently, without any linked doodle or seed idea.'**
  String get independentArtworkText;

  /// No description provided for @seedIdeaTraceTitle.
  ///
  /// In en, this message translates to:
  /// **'1. Original Seed Idea:'**
  String get seedIdeaTraceTitle;

  /// No description provided for @doodleTraceTitle.
  ///
  /// In en, this message translates to:
  /// **'2. Inspirational Sketch (Doodle):'**
  String get doodleTraceTitle;

  /// No description provided for @singleDoodleTraceTitle.
  ///
  /// In en, this message translates to:
  /// **'Inspirational Sketch (Doodle):'**
  String get singleDoodleTraceTitle;

  /// No description provided for @viewOriginalArtwork.
  ///
  /// In en, this message translates to:
  /// **'See original artwork'**
  String get viewOriginalArtwork;

  /// No description provided for @profileBioLabel.
  ///
  /// In en, this message translates to:
  /// **'Short Bio'**
  String get profileBioLabel;

  /// No description provided for @profileBioHint.
  ///
  /// In en, this message translates to:
  /// **'Write a short status message...'**
  String get profileBioHint;

  /// No description provided for @profileBioUpdateSuccess.
  ///
  /// In en, this message translates to:
  /// **'Short message updated successfully!'**
  String get profileBioUpdateSuccess;

  /// No description provided for @profileBioSave.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get profileBioSave;

  /// No description provided for @profileBioCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get profileBioCancel;

  /// No description provided for @profileOf.
  ///
  /// In en, this message translates to:
  /// **'{username}\'s Space'**
  String profileOf(String username);

  /// No description provided for @otherProfileNoIdeas.
  ///
  /// In en, this message translates to:
  /// **'No ideas published yet.'**
  String get otherProfileNoIdeas;

  /// No description provided for @otherProfileNoDoodles.
  ///
  /// In en, this message translates to:
  /// **'No doodles drawn yet.'**
  String get otherProfileNoDoodles;

  /// No description provided for @otherProfileNoArtworks.
  ///
  /// In en, this message translates to:
  /// **'No artworks shared yet.'**
  String get otherProfileNoArtworks;

  /// No description provided for @profileSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search creator...'**
  String get profileSearchHint;

  /// No description provided for @profileSearchUserNotFound.
  ///
  /// In en, this message translates to:
  /// **'User \'@{username}\' not found'**
  String profileSearchUserNotFound(String username);

  /// No description provided for @settingsUsernameTitle.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get settingsUsernameTitle;

  /// No description provided for @settingsUsernameSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Change your unique username'**
  String get settingsUsernameSubtitle;

  /// No description provided for @settingsUsernameCooldownError.
  ///
  /// In en, this message translates to:
  /// **'You must wait 24 hours to change your username again. {hours}h {minutes}m remaining.'**
  String settingsUsernameCooldownError(String hours, String minutes);

  /// No description provided for @settingsUsernameConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Change Username?'**
  String get settingsUsernameConfirmTitle;

  /// No description provided for @settingsUsernameConfirmMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to change your username to \'@{username}\'? You won\'t be able to change it again for the next 24 hours.'**
  String settingsUsernameConfirmMessage(String username);

  /// No description provided for @settingsUsernameAlreadyTaken.
  ///
  /// In en, this message translates to:
  /// **'The username \'@{username}\' is already in use.'**
  String settingsUsernameAlreadyTaken(String username);

  /// No description provided for @settingsUsernameSuccess.
  ///
  /// In en, this message translates to:
  /// **'Username updated successfully!'**
  String get settingsUsernameSuccess;

  /// No description provided for @settingsUsernameInvalid.
  ///
  /// In en, this message translates to:
  /// **'Username can only contain letters, numbers, and underscores (3-20 characters).'**
  String get settingsUsernameInvalid;

  /// No description provided for @btnConfirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get btnConfirm;

  /// No description provided for @btnSave.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get btnSave;

  /// No description provided for @settingsTutorialReplay.
  ///
  /// In en, this message translates to:
  /// **'Replay General Tutorial'**
  String get settingsTutorialReplay;

  /// No description provided for @settingsTutorialSection.
  ///
  /// In en, this message translates to:
  /// **'Help & Support'**
  String get settingsTutorialSection;

  /// No description provided for @tutorialWelcome.
  ///
  /// In en, this message translates to:
  /// **'Hello! I\'m your creative companion in \"whatdoidraw\" Whether it\'s to give ideas or to inspire you, I hope you have a great time!'**
  String get tutorialWelcome;

  /// No description provided for @tutorialConcept.
  ///
  /// In en, this message translates to:
  /// **'Our application is based on a very simple idea: to inspire and be inspired. There are three main ways to interact with the community.'**
  String get tutorialConcept;

  /// No description provided for @tutorialIdeas.
  ///
  /// In en, this message translates to:
  /// **'1. Ideas: Don\'t know what to draw? Explore ideas suggested by others, or write your own creative prompt to challenge others.'**
  String get tutorialIdeas;

  /// No description provided for @tutorialDoodles.
  ///
  /// In en, this message translates to:
  /// **'2. Doodles: Sketch quick doodles based on those ideas... or whatever you want.'**
  String get tutorialDoodles;

  /// No description provided for @tutorialArtworks.
  ///
  /// In en, this message translates to:
  /// **'3. Artworks: Take doodles to the next level. If you like an idea or a doodle and create an artwork, publish it on your social media and share the link here. The creator of the idea or doodle will know what you created and can stop by to see it.'**
  String get tutorialArtworks;

  /// No description provided for @tutorialReady.
  ///
  /// In en, this message translates to:
  /// **'That\'s all! You can review this tutorial or the help for each screen at any time. Happy drawing!'**
  String get tutorialReady;

  /// No description provided for @infoFeedIdeas.
  ///
  /// In en, this message translates to:
  /// **'Here you can explore creative ideas from other users. Use them as inspiration. If you like an idea, you can tap on it to create a doodle or share your final artwork.'**
  String get infoFeedIdeas;

  /// No description provided for @infoFeedDoodles.
  ///
  /// In en, this message translates to:
  /// **'Here you\'ll see the Doodles drawn by the community. If you see one you like and create your own artwork, share the link!'**
  String get infoFeedDoodles;

  /// No description provided for @infoFeedArtworks.
  ///
  /// In en, this message translates to:
  /// **'Here you\'ll find the finished Artworks uploaded by users. These works always stem from a doodle or an idea. Tap on them to explore the idea or doodle that inspired them.'**
  String get infoFeedArtworks;

  /// No description provided for @infoCreationHub.
  ///
  /// In en, this message translates to:
  /// **'This is your creation center. From here you can propose a new Idea for someone to draw, start painting a Doodle freely on our canvas, or access your Saved items to continue later.'**
  String get infoCreationHub;

  /// No description provided for @infoCreateIdea.
  ///
  /// In en, this message translates to:
  /// **'Here you can propose a text-based creative idea. Add tags so others can find it, along with the language it\'s written in. Your ideas will appear in the Ideas tab of the Feed, and other users can use them to draw doodles inspired by them... or even to create a more elaborate artwork.'**
  String get infoCreateIdea;

  /// No description provided for @infoDoodleCanvas.
  ///
  /// In en, this message translates to:
  /// **'Welcome to our Canvas! Here you can draw your sketches in a simple way. Remember, we don\'t look for perfection—just to convey an idea—so follow your heart. Don\'t forget to add tags to make it easier to find. When you save your doodle, it will be published so other users can see it and, if they wish, use it to create a final Artwork.'**
  String get infoDoodleCanvas;

  /// No description provided for @themeDark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get themeDark;

  /// No description provided for @themeLight.
  ///
  /// In en, this message translates to:
  /// **'Light Green'**
  String get themeLight;

  /// No description provided for @themeDarkGreen.
  ///
  /// In en, this message translates to:
  /// **'Dark Green'**
  String get themeDarkGreen;

  /// No description provided for @themeDarkPlus.
  ///
  /// In en, this message translates to:
  /// **'Dark Plus'**
  String get themeDarkPlus;

  /// No description provided for @canvasToolLine.
  ///
  /// In en, this message translates to:
  /// **'Line'**
  String get canvasToolLine;

  /// No description provided for @canvasToolBrush.
  ///
  /// In en, this message translates to:
  /// **'Brush'**
  String get canvasToolBrush;

  /// No description provided for @canvasToolEraserLine.
  ///
  /// In en, this message translates to:
  /// **'Erase Line'**
  String get canvasToolEraserLine;

  /// No description provided for @canvasToolEraserColor.
  ///
  /// In en, this message translates to:
  /// **'Erase Color'**
  String get canvasToolEraserColor;

  /// No description provided for @canvasToolBackground.
  ///
  /// In en, this message translates to:
  /// **'Background'**
  String get canvasToolBackground;

  /// No description provided for @canvasEraserLineHelper.
  ///
  /// In en, this message translates to:
  /// **'Line Eraser active. Drag your finger over a line to erase it.'**
  String get canvasEraserLineHelper;

  /// No description provided for @canvasEraserColorHelper.
  ///
  /// In en, this message translates to:
  /// **'Color Eraser active. Drag your finger over a color stroke to erase it.'**
  String get canvasEraserColorHelper;

  /// No description provided for @canvasBackgroundColorDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Background Color'**
  String get canvasBackgroundColorDialogTitle;

  /// No description provided for @canvasDialogClose.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get canvasDialogClose;

  /// No description provided for @btnCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get btnCancel;

  /// No description provided for @btnDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get btnDelete;

  /// No description provided for @deleteIdeaDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete Idea?'**
  String get deleteIdeaDialogTitle;

  /// No description provided for @deleteIdeaDialogContent.
  ///
  /// In en, this message translates to:
  /// **'This action cannot be undone. Creations (doodles or artworks) inspired by this idea will remain active for their creators, but the original idea will disappear.'**
  String get deleteIdeaDialogContent;

  /// No description provided for @deleteIdeaSuccess.
  ///
  /// In en, this message translates to:
  /// **'Idea deleted successfully'**
  String get deleteIdeaSuccess;

  /// No description provided for @deleteIdeaTooltip.
  ///
  /// In en, this message translates to:
  /// **'Delete idea'**
  String get deleteIdeaTooltip;

  /// No description provided for @deleteDoodleDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete Doodle?'**
  String get deleteDoodleDialogTitle;

  /// No description provided for @deleteDoodleDialogContent.
  ///
  /// In en, this message translates to:
  /// **'This action cannot be undone.'**
  String get deleteDoodleDialogContent;

  /// No description provided for @deleteDoodleSuccess.
  ///
  /// In en, this message translates to:
  /// **'Doodle deleted successfully'**
  String get deleteDoodleSuccess;

  /// No description provided for @deleteDoodleTooltip.
  ///
  /// In en, this message translates to:
  /// **'Delete drawing'**
  String get deleteDoodleTooltip;

  /// No description provided for @deleteArtworkDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete Artwork?'**
  String get deleteArtworkDialogTitle;

  /// No description provided for @deleteArtworkDialogContent.
  ///
  /// In en, this message translates to:
  /// **'This action cannot be undone.'**
  String get deleteArtworkDialogContent;

  /// No description provided for @deleteArtworkSuccess.
  ///
  /// In en, this message translates to:
  /// **'Artwork deleted successfully'**
  String get deleteArtworkSuccess;

  /// No description provided for @deleteArtworkTooltip.
  ///
  /// In en, this message translates to:
  /// **'Delete artwork'**
  String get deleteArtworkTooltip;

  /// No description provided for @deletedIdeaPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'The original idea has been deleted by its creator.'**
  String get deletedIdeaPlaceholder;

  /// No description provided for @deletedDoodlePlaceholder.
  ///
  /// In en, this message translates to:
  /// **'The original doodle that inspired this artwork has been deleted by its creator.'**
  String get deletedDoodlePlaceholder;

  /// No description provided for @settingsLogoutConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Log out?'**
  String get settingsLogoutConfirmTitle;

  /// No description provided for @settingsLogoutConfirmMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to log out of your account?'**
  String get settingsLogoutConfirmMessage;

  /// No description provided for @canvasClearConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Clear canvas?'**
  String get canvasClearConfirmTitle;

  /// No description provided for @canvasClearConfirmMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to clear all your drawing? This action cannot be undone.'**
  String get canvasClearConfirmMessage;
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
