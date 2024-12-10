import 'package:flutter/material.dart';

class UserProfile {
  final String username;
  final int level;
  final int experience;
  final int totalStudyTime;
  final List<Achievement> achievements;
  final String avatarPath;
  final Color primaryColor;
  final Color secondaryColor;

  const UserProfile({
    this.username = '블루베리',
    this.level = 1,
    this.experience = 0,
    this.totalStudyTime = 0,
    this.achievements = const [],
    this.avatarPath = 'assets/icon/default_avatar.svg',
    this.primaryColor = Colors.blueAccent,
    this.secondaryColor = Colors.lightBlueAccent,
  });

  UserProfile copyWith({
    String? username,
    int? level,
    int? experience,
    int? totalStudyTime,
    List<Achievement>? achievements,
    String? avatarPath,
    Color? primaryColor,
    Color? secondaryColor,
  }) {
    return UserProfile(
      username: username ?? this.username,
      level: level ?? this.level,
      experience: experience ?? this.experience,
      totalStudyTime: totalStudyTime ?? this.totalStudyTime,
      achievements: achievements ?? this.achievements,
      avatarPath: avatarPath ?? this.avatarPath,
      primaryColor: primaryColor ?? this.primaryColor,
      secondaryColor: secondaryColor ?? this.secondaryColor,
    );
  }

  int get experienceToNextLevel {
    return level * 100; // 레벨업에 필요한 경험치
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
