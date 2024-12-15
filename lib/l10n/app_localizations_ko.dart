import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get appName => '블루베리 타이머';

  @override
  String get appSlogan => '공부의 시간을 더욱 효율적으로';

  @override
  String get menuNotice => '공지사항';

  @override
  String get menuSettings => '설정';

  @override
  String get menuHelp => '도움말';

  @override
  String get menuMine => '광산';

  @override
  String get menuAbout => '앱 정보';

  @override
  String get noticeTitle => '공지사항';

  @override
  String get noticeClose => '닫기';

  @override
  String get noticeAppUpdate => '앱 업데이트 안내';

  @override
  String get noticeAppUpdateContent => '새로운 기능이 추가되었습니다.\n1. 타이머 기능 개선\n2. UI 개선\n3. 버그 수정';

  @override
  String get noticeServiceCheck => '서비스 점검 안내';

  @override
  String get noticeServiceCheckContent => '2024년 12월 20일 새벽 2시부터 4시까지 서비스 점검이 있을 예정입니다.';

  @override
  String get noticeWelcome => '이용 안내';

  @override
  String get noticeWelcomeContent => '블루베리 타이머를 이용해 주셔서 감사합니다. 더 나은 서비스를 제공하도록 하겠습니다.';

  @override
  String get helpTitle => '도움말';

  @override
  String get helpClose => '닫기';

  @override
  String get helpTimerTitle => '타이머 사용법';

  @override
  String get helpTimerContent => '1. 시간 설정: 상단의 시간을 터치하여 공부 시간과 휴식 시간을 설정할 수 있습니다.\n\n2. 시작/정지: 중앙의 큰 버튼을 눌러 타이머를 시작하거나 정지할 수 있습니다.\n\n3. 초기화: 타이머가 정지된 상태에서 초기화 버튼을 눌러 시간을 리셋할 수 있습니다.';

  @override
  String get helpItemTitle => '아이템 수집';

  @override
  String get helpItemContent => '공부 시간이 끝날 때마다 랜덤으로 블루베리 아이템을 획득할 수 있습니다.\n\n획득한 아이템은 마이페이지에서 확인할 수 있습니다.\n\n특별한 아이템을 모아 컬렉션을 완성해보세요!';

  @override
  String get helpMusicTitle => '배경음악 설정';

  @override
  String get helpMusicContent => '1. 음악 선택: 설정 메뉴에서 원하는 배경음악을 선택할 수 있습니다.\n\n2. 볼륨 조절: 음악이 재생 중일 때 볼륨 버튼으로 소리 크기를 조절할 수 있습니다.\n\n3. 음소거: 음악 아이콘을 탭하여 빠르게 음소거할 수 있습니다.';

  @override
  String get helpProfileTitle => '프로필 관리';

  @override
  String get helpProfileContent => '1. 프로필 수정: 마이페이지에서 프로필 이미지와 닉네임을 변경할 수 있습니다.\n\n2. 통계 확인: 일간/주간/월간 공부 시간 통계를 확인할 수 있습니다.\n\n3. 목표 설정: 일일 목표 공부 시간을 설정하고 달성 현황을 확인할 수 있습니다.';

  @override
  String get helpNotificationTitle => '알림 설정';

  @override
  String get helpNotificationContent => '1. 타이머 알림: 공부/휴식 시간이 끝날 때 알림을 받을 수 있습니다.\n\n2. 목표 알림: 일일 목표 달성 시 축하 알림을 받을 수 있습니다.\n\n3. 알림 설정: 설정 메뉴에서 원하는 알림만 선택하여 받을 수 있습니다.';

  @override
  String get settingsTitle => '설정';

  @override
  String get settingsClose => '닫기';

  @override
  String get settingsTimerSection => '타이머';

  @override
  String get settingsAutoStart => '자동 시작';

  @override
  String get settingsAutoStartDesc => '휴식 시간 후 자동으로 공부 시간 시작';

  @override
  String get settingsNotificationSection => '알림';

  @override
  String get settingsTimerNotification => '타이머 알림';

  @override
  String get settingsTimerNotificationDesc => '타이머 종료 시 알림';

  @override
  String get settingsVibration => '진동';

  @override
  String get settingsVibrationDesc => '알림 시 진동 사용';

  @override
  String get settingsSoundSection => '소리';

  @override
  String get settingsSoundEffect => '효과음';

  @override
  String get settingsSoundEffectDesc => '버튼 클릭 시 효과음';

  @override
  String get settingsBgmVolume => '배경음악 볼륨';

  @override
  String get settingsBgmVolumeDesc => '배경음악의 볼륨을 조절합니다';

  @override
  String get aboutTitle => '앱 정보';

  @override
  String get aboutVersion => '1.0.0';

  @override
  String get aboutCopyright => '© 2024 Blueberry Timer';

  @override
  String get aboutDescription => '효율적인 공부 시간 관리를 위한 앱입니다.';

  @override
  String get aboutTeam => '2024 Blueberry Timer Team';

  @override
  String get timerStudyPhase => '공부 시간';

  @override
  String get timerRestPhase => '휴식 시간';

  @override
  String get timerCollectedItems => '수집한 아이템';

  @override
  String get timerNoItems => '아직 수집한 아이템이 없습니다';
}
