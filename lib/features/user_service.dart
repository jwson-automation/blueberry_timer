import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:blueberry_timer/user_info.dart';

class UserState {
  final UserProfile profile;
  final List<Achievement> unlockedAchievements;

  const UserState({
    this.profile = const UserProfile(),
    this.unlockedAchievements = const [],
  });

  UserState copyWith({
    UserProfile? profile,
    List<Achievement>? unlockedAchievements,
  }) {
    return UserState(
      profile: profile ?? this.profile,
      unlockedAchievements: unlockedAchievements ?? this.unlockedAchievements,
    );
  }
}

class UserService extends StateNotifier<UserState> {
  UserService() : super(UserState());

  void updateUsername(String newUsername) {
    state = state.copyWith(
      profile: state.profile.copyWith(username: newUsername),
    );
  }

  void addExperience(int exp) {
    final newExperience = state.profile.experience + exp;
    final newProfile = state.profile.copyWith(
      experience: newExperience,
      level: newExperience ~/ 100, // 매 100 경험치마다 레벨업
    );

    state = state.copyWith(profile: newProfile);
  }

  void addTotalStudyTime(int minutes) {
    final newTotalStudyTime = state.profile.totalStudyTime + minutes;
    final newProfile = state.profile.copyWith(
      totalStudyTime: newTotalStudyTime,
    );

    state = state.copyWith(profile: newProfile);
  }

  void unlockAchievement(Achievement achievement) {
    if (!state.unlockedAchievements.contains(achievement)) {
      state = state.copyWith(
        unlockedAchievements: [...state.unlockedAchievements, achievement],
      );
    }
  }

  void updateAvatar(String avatarPath) {
    state = state.copyWith(
      profile: state.profile.copyWith(avatarPath: avatarPath),
    );
  }

  void updateProfileColors(Color primary, Color secondary) {
    state = state.copyWith(
      profile: state.profile.copyWith(
        primaryColor: primary,
        secondaryColor: secondary,
      ),
    );
  }
}

final userServiceProvider = StateNotifierProvider<UserService, UserState>((ref) {
  return UserService();
});
