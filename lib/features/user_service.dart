import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:blueberry_timer/models/user_model.dart';
import 'package:blueberry_timer/states/user_state.dart';
import 'package:blueberry_timer/repositories/user_repository.dart';

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

class UserNotifier extends StateNotifier<UserState> {
  final UserRepository _userRepository;

  UserNotifier(this._userRepository) : super(UserState());

  void updateUsername(String newUsername) {
    state = state.copyWith(
      profile: state.profile.copyWith(username: newUsername),
    );
  }

  void addExperience(int exp) {
    final newExperience = state.profile.experience + exp;
    
    // 레벨업 로직 추가
    int newLevel = state.profile.level;
    int requiredExp = newLevel * 60; // 레벨당 60분 필요

    if (newExperience >= requiredExp) {
      newLevel++;
    }

    final newProfile = state.profile.copyWith(
      experience: newExperience,
      level: newLevel
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

  // Firebase에 사용자 데이터 저장
  Future<void> saveUserToFirebase() async {
    try {
      await _userRepository.saveUser(state.profile);
    } catch (e) {
      print('사용자 데이터 저장 중 오류 발생: $e');
    }
  }

  // Firebase에서 사용자 데이터 불러오기
  Future<void> loadUserFromFirebase() async {
    try {
      final loadedProfile = await _userRepository.fetchUser();
      
      if (loadedProfile != null) {
        state = state.copyWith(
          profile: loadedProfile,
          unlockedAchievements: loadedProfile.achievements,
        );
      }
    } catch (e) {
      print('사용자 데이터 불러오기 중 오류 발생: $e');
    }
  }

  // JSON 문자열로 상태 직렬화
  String serializeState() {
    return json.encode(state.profile.toJson());
  }

  // JSON 문자열에서 상태 역직렬화
  void deserializeState(String jsonString) {
    try {
      final Map<String, dynamic> jsonMap = json.decode(jsonString);
      final loadedProfile = UserModel.fromJson(jsonMap);
      
      state = state.copyWith(
        profile: loadedProfile,
        unlockedAchievements: loadedProfile.achievements,
      );
    } catch (e) {
      print('상태 역직렬화 중 오류 발생: $e');
    }
  }
}

// Riverpod Provider 업데이트
final userRepositoryProvider = Provider<UserRepository>((ref) {
  return UserRepository();
});

final userServiceProvider = StateNotifierProvider<UserNotifier, UserState>((ref) {
  final userRepository = ref.read(userRepositoryProvider);
  return UserNotifier(userRepository);
});
