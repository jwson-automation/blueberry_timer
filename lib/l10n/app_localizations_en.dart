import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Blueberry Timer';

  @override
  String get appSlogan => 'Make your study time more efficient';

  @override
  String get menuNotice => 'Notice';

  @override
  String get menuSettings => 'Settings';

  @override
  String get menuHelp => 'Help';

  @override
  String get menuMine => 'Mine';

  @override
  String get menuAbout => 'About';

  @override
  String get noticeTitle => 'Notice';

  @override
  String get noticeClose => 'Close';

  @override
  String get noticeAppUpdate => 'App Update Notice';

  @override
  String get noticeAppUpdateContent => 'New features have been added.\n1. Timer function improvement\n2. UI improvement\n3. Bug fixes';

  @override
  String get noticeServiceCheck => 'Service Maintenance Notice';

  @override
  String get noticeServiceCheckContent => 'Service maintenance is scheduled from 2 AM to 4 AM on December 20, 2024.';

  @override
  String get noticeWelcome => 'Welcome Notice';

  @override
  String get noticeWelcomeContent => 'Thank you for using Blueberry Timer. We will continue to provide better service.';

  @override
  String get helpTitle => 'Help';

  @override
  String get helpClose => 'Close';

  @override
  String get helpTimerTitle => 'How to Use Timer';

  @override
  String get helpTimerContent => '1. Time Setting: Touch the time at the top to set study and break times.\n\n2. Start/Stop: Press the large center button to start or stop the timer.\n\n3. Reset: Press the reset button when the timer is stopped to reset the time.';

  @override
  String get helpItemTitle => 'Item Collection';

  @override
  String get helpItemContent => 'You can get random blueberry items every time you finish your study time.\n\nCheck your collected items on My Page.\n\nComplete your collection by gathering special items!';

  @override
  String get helpMusicTitle => 'Background Music Settings';

  @override
  String get helpMusicContent => '1. Music Selection: Select your desired background music in the settings menu.\n\n2. Volume Control: Adjust the volume with the volume buttons while music is playing.\n\n3. Mute: Quickly mute by tapping the music icon.';

  @override
  String get helpProfileTitle => 'Profile Management';

  @override
  String get helpProfileContent => '1. Edit Profile: Change your profile image and nickname on My Page.\n\n2. Check Statistics: View daily/weekly/monthly study time statistics.\n\n3. Set Goals: Set daily study time goals and check achievement status.';

  @override
  String get helpNotificationTitle => 'Notification Settings';

  @override
  String get helpNotificationContent => '1. Timer Notification: Receive notifications when study/break time ends.\n\n2. Goal Notification: Receive congratulatory notifications when daily goals are achieved.\n\n3. Notification Settings: Select desired notifications in the settings menu.';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get settingsClose => 'Close';

  @override
  String get settingsTimerSection => 'Timer';

  @override
  String get settingsAutoStart => 'Auto Start';

  @override
  String get settingsAutoStartDesc => 'Automatically start study time after break';

  @override
  String get settingsNotificationSection => 'Notifications';

  @override
  String get settingsTimerNotification => 'Timer Notification';

  @override
  String get settingsTimerNotificationDesc => 'Notification when timer ends';

  @override
  String get settingsVibration => 'Vibration';

  @override
  String get settingsVibrationDesc => 'Use vibration for notifications';

  @override
  String get settingsSoundSection => 'Sound';

  @override
  String get settingsSoundEffect => 'Sound Effects';

  @override
  String get settingsSoundEffectDesc => 'Sound effects when clicking buttons';

  @override
  String get settingsBgmVolume => 'BGM Volume';

  @override
  String get settingsBgmVolumeDesc => 'Adjust background music volume';

  @override
  String get aboutTitle => 'About';

  @override
  String get aboutVersion => '1.0.0';

  @override
  String get aboutCopyright => '© 2024 Blueberry Timer';

  @override
  String get aboutDescription => 'An app for efficient study time management.';

  @override
  String get aboutTeam => '2024 Blueberry Timer Team';

  @override
  String get timerStudyPhase => 'Study Time';

  @override
  String get timerRestPhase => 'Rest Time';

  @override
  String get timerCollectedItems => 'Collected Items';

  @override
  String get timerNoItems => 'No items collected yet';
}
