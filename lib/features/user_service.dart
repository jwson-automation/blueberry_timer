import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:blueberry_timer/models/user_model.dart';

/**
 * 사용자 정보를 관리하는 서비스입니다.
 * 
 * 이 서비스는 다음 기능들을 제공합니다:
 * - 사용자 경험치 관리
 * - 레벨 시스템
 * - 학습 통계 기록
 * - 사용자 설정 관리
 * 
 * 공부 시간에 따라 경험치가 쌓이며, 일정 경험치가 모이면
 * 레벨업이 되는 게임과 같은 시스템을 제공합니다.
 */

class UserState {
  final UserModel profile;
  final List<Achievement> unlockedAchievements;

  const UserState({
    this.profile = const UserModel(),
    this.unlockedAchievements = const [],
  });

  UserState copyWith({
    UserModel? profile,
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
      level: state.profile.level
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

  void addMoney(int amount) {
    state = state.copyWith(
      profile: state.profile.copyWith(
        money: state.profile.money + amount,
      ),
    );
  }

  bool useMoney(int amount) {
    if (state.profile.money < amount) {
      return false;  // 잔액 부족
    }
    state = state.copyWith(
      profile: state.profile.copyWith(
        money: state.profile.money - amount,
      ),
    );
    return true;  // 구매 성공
  }
}

final userServiceProvider = StateNotifierProvider<UserService, UserState>((ref) {
  return UserService();
});
