import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ko.dart';

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
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

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
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ko')
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'Blueberry Timer'**
  String get appName;

  /// No description provided for @appSlogan.
  ///
  /// In en, this message translates to:
  /// **'Make your study time more efficient'**
  String get appSlogan;

  /// No description provided for @menuNotice.
  ///
  /// In en, this message translates to:
  /// **'Notice'**
  String get menuNotice;

  /// No description provided for @menuSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get menuSettings;

  /// No description provided for @menuHelp.
  ///
  /// In en, this message translates to:
  /// **'Help'**
  String get menuHelp;

  /// No description provided for @menuMine.
  ///
  /// In en, this message translates to:
  /// **'Mine'**
  String get menuMine;

  /// No description provided for @menuAbout.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get menuAbout;

  /// No description provided for @noticeTitle.
  ///
  /// In en, this message translates to:
  /// **'Notice'**
  String get noticeTitle;

  /// No description provided for @noticeClose.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get noticeClose;

  /// No description provided for @noticeAppUpdate.
  ///
  /// In en, this message translates to:
  /// **'App Update Notice'**
  String get noticeAppUpdate;

  /// No description provided for @noticeAppUpdateContent.
  ///
  /// In en, this message translates to:
  /// **'New features have been added.\n1. Timer function improvement\n2. UI improvement\n3. Bug fixes'**
  String get noticeAppUpdateContent;

  /// No description provided for @noticeServiceCheck.
  ///
  /// In en, this message translates to:
  /// **'Service Maintenance Notice'**
  String get noticeServiceCheck;

  /// No description provided for @noticeServiceCheckContent.
  ///
  /// In en, this message translates to:
  /// **'Service maintenance is scheduled from 2 AM to 4 AM on December 20, 2024.'**
  String get noticeServiceCheckContent;

  /// No description provided for @noticeWelcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome Notice'**
  String get noticeWelcome;

  /// No description provided for @noticeWelcomeContent.
  ///
  /// In en, this message translates to:
  /// **'Thank you for using Blueberry Timer. We will continue to provide better service.'**
  String get noticeWelcomeContent;

  /// No description provided for @helpTitle.
  ///
  /// In en, this message translates to:
  /// **'Help'**
  String get helpTitle;

  /// No description provided for @helpClose.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get helpClose;

  /// No description provided for @helpTimerTitle.
  ///
  /// In en, this message translates to:
  /// **'How to Use Timer'**
  String get helpTimerTitle;

  /// No description provided for @helpTimerContent.
  ///
  /// In en, this message translates to:
  /// **'1. Time Setting: Touch the time at the top to set study and break times.\n\n2. Start/Stop: Press the large center button to start or stop the timer.\n\n3. Reset: Press the reset button when the timer is stopped to reset the time.'**
  String get helpTimerContent;

  /// No description provided for @helpItemTitle.
  ///
  /// In en, this message translates to:
  /// **'Item Collection'**
  String get helpItemTitle;

  /// No description provided for @helpItemContent.
  ///
  /// In en, this message translates to:
  /// **'You can get random blueberry items every time you finish your study time.\n\nCheck your collected items on My Page.\n\nComplete your collection by gathering special items!'**
  String get helpItemContent;

  /// No description provided for @helpMusicTitle.
  ///
  /// In en, this message translates to:
  /// **'Background Music Settings'**
  String get helpMusicTitle;

  /// No description provided for @helpMusicContent.
  ///
  /// In en, this message translates to:
  /// **'1. Music Selection: Select your desired background music in the settings menu.\n\n2. Volume Control: Adjust the volume with the volume buttons while music is playing.\n\n3. Mute: Quickly mute by tapping the music icon.'**
  String get helpMusicContent;

  /// No description provided for @helpProfileTitle.
  ///
  /// In en, this message translates to:
  /// **'Profile Management'**
  String get helpProfileTitle;

  /// No description provided for @helpProfileContent.
  ///
  /// In en, this message translates to:
  /// **'1. Edit Profile: Change your profile image and nickname on My Page.\n\n2. Check Statistics: View daily/weekly/monthly study time statistics.\n\n3. Set Goals: Set daily study time goals and check achievement status.'**
  String get helpProfileContent;

  /// No description provided for @helpNotificationTitle.
  ///
  /// In en, this message translates to:
  /// **'Notification Settings'**
  String get helpNotificationTitle;

  /// No description provided for @helpNotificationContent.
  ///
  /// In en, this message translates to:
  /// **'1. Timer Notification: Receive notifications when study/break time ends.\n\n2. Goal Notification: Receive congratulatory notifications when daily goals are achieved.\n\n3. Notification Settings: Select desired notifications in the settings menu.'**
  String get helpNotificationContent;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @settingsClose.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get settingsClose;

  /// No description provided for @settingsTimerSection.
  ///
  /// In en, this message translates to:
  /// **'Timer'**
  String get settingsTimerSection;

  /// No description provided for @settingsAutoStart.
  ///
  /// In en, this message translates to:
  /// **'Auto Start'**
  String get settingsAutoStart;

  /// No description provided for @settingsAutoStartDesc.
  ///
  /// In en, this message translates to:
  /// **'Automatically start study time after break'**
  String get settingsAutoStartDesc;

  /// No description provided for @settingsNotificationSection.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get settingsNotificationSection;

  /// No description provided for @settingsTimerNotification.
  ///
  /// In en, this message translates to:
  /// **'Timer Notification'**
  String get settingsTimerNotification;

  /// No description provided for @settingsTimerNotificationDesc.
  ///
  /// In en, this message translates to:
  /// **'Notification when timer ends'**
  String get settingsTimerNotificationDesc;

  /// No description provided for @settingsVibration.
  ///
  /// In en, this message translates to:
  /// **'Vibration'**
  String get settingsVibration;

  /// No description provided for @settingsVibrationDesc.
  ///
  /// In en, this message translates to:
  /// **'Use vibration for notifications'**
  String get settingsVibrationDesc;

  /// No description provided for @settingsSoundSection.
  ///
  /// In en, this message translates to:
  /// **'Sound'**
  String get settingsSoundSection;

  /// No description provided for @settingsSoundEffect.
  ///
  /// In en, this message translates to:
  /// **'Sound Effects'**
  String get settingsSoundEffect;

  /// No description provided for @settingsSoundEffectDesc.
  ///
  /// In en, this message translates to:
  /// **'Sound effects when clicking buttons'**
  String get settingsSoundEffectDesc;

  /// No description provided for @settingsBgmVolume.
  ///
  /// In en, this message translates to:
  /// **'BGM Volume'**
  String get settingsBgmVolume;

  /// No description provided for @settingsBgmVolumeDesc.
  ///
  /// In en, this message translates to:
  /// **'Adjust background music volume'**
  String get settingsBgmVolumeDesc;

  /// No description provided for @aboutTitle.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get aboutTitle;

  /// No description provided for @aboutVersion.
  ///
  /// In en, this message translates to:
  /// **'1.0.0'**
  String get aboutVersion;

  /// No description provided for @aboutCopyright.
  ///
  /// In en, this message translates to:
  /// **'© 2024 Blueberry Timer'**
  String get aboutCopyright;

  /// No description provided for @aboutDescription.
  ///
  /// In en, this message translates to:
  /// **'An app for efficient study time management.'**
  String get aboutDescription;

  /// No description provided for @aboutTeam.
  ///
  /// In en, this message translates to:
  /// **'2024 Blueberry Timer Team'**
  String get aboutTeam;

  /// No description provided for @timerStudyPhase.
  ///
  /// In en, this message translates to:
  /// **'Study Time'**
  String get timerStudyPhase;

  /// No description provided for @timerRestPhase.
  ///
  /// In en, this message translates to:
  /// **'Rest Time'**
  String get timerRestPhase;

  /// No description provided for @timerCollectedItems.
  ///
  /// In en, this message translates to:
  /// **'Collected Items'**
  String get timerCollectedItems;

  /// No description provided for @timerNoItems.
  ///
  /// In en, this message translates to:
  /// **'No items collected yet'**
  String get timerNoItems;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'ko'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'ko': return AppLocalizationsKo();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
