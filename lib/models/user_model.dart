class UserModel {
  final String username;
  final int level;
  final int experience;
  final int totalStudyTime;
  final List<Achievement> achievements;
  final int money;

  const UserModel({
    this.username = '블루베리',
    this.level = 1,
    this.experience = 0,
    this.totalStudyTime = 0,
    this.achievements = const [],
    this.money = 0,
  });

  UserModel copyWith({
    String? username,
    int? level,
    int? experience,
    int? totalStudyTime,
    List<Achievement>? achievements,
    String? avatarPath,
    int? money,
  }) {
    return UserModel(
      username: username ?? this.username,
      level: level ?? this.level,
      experience: experience ?? this.experience,
      totalStudyTime: totalStudyTime ?? this.totalStudyTime,
      achievements: achievements ?? this.achievements,
      money: money ?? this.money,
    );
  }

  /// 다음 레벨까지 필요한 경험치 계산 (분 단위)
  int get experienceToNextLevel {
    // 레벨당 60분(1시간)씩 증가
    return 60 * level;  // 레벨 1: 60분, 레벨 2: 120분, 레벨 3: 180분...
  }

  double get levelProgress {
    return experience / experienceToNextLevel;
  }

  bool get canLevelUp {
    return experience >= experienceToNextLevel;
  }
}

class Achievement {
  final String name;
  final String description;
  final String iconPath;
  final DateTime dateEarned;
  final AchievementType type;

  const Achievement({
    required this.name,
    required this.description,
    required this.iconPath,
    required this.dateEarned,
    required this.type,
  });
}

enum AchievementType {
  studyTime,
  itemCollection,
  consecutiveDays,
  specialEvent,
}

// 미리 정의된 업적들
final List<Achievement> predefinedAchievements = [
  Achievement(
    name: '첫 시작',
    description: '첫 타이머 시작',
    iconPath: 'assets/icon/achievements/first_start.svg',
    dateEarned: DateTime.now(),
    type: AchievementType.studyTime,
  ),
  Achievement(
    name: '1시간 공부',
    description: '총 1시간 공부 완료',
    iconPath: 'assets/icon/achievements/one_hour.svg',
    dateEarned: DateTime.now(),
    type: AchievementType.studyTime,
  ),
  Achievement(
    name: '컬렉터',
    description: '10개의 아이템 획득',
    iconPath: 'assets/icon/achievements/collector.svg',
    dateEarned: DateTime.now(),
    type: AchievementType.itemCollection,
  ),
];
