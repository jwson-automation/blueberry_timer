import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:blueberry_timer/models/user_model.dart';
import 'package:blueberry_timer/repositories/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

final userProvider = StateNotifierProvider<UserNotifier, UserModel>((ref) {
  return UserNotifier();
});

class UserNotifier extends StateNotifier<UserModel> {
  UserNotifier() : super(UserModel()) {
    _initializeUser();
  }

  final UserRepository _userRepository = UserRepository();

  Future<void> _initializeUser() async {
    try {
      // Check if this is the first app launch
      final prefs = await SharedPreferences.getInstance();
      final isFirstLaunch = prefs.getBool('first_launch') ?? true;

      if (isFirstLaunch) {
        // Create a temporary user
        final tempUser = await _userRepository.addTemporaryUser(
          name: '임시 사용자',
          email: '${DateTime.now().millisecondsSinceEpoch}@temp.blueberry.com',
          initialExperience: 0,
          initialMoney: 0,
        );

        // Update state with the new temporary user
        state = tempUser;

        // Mark that the first launch is complete
        await prefs.setBool('first_launch', false);
      } else {
        // Check if a user is already signed in
        final currentUser = FirebaseAuth.instance.currentUser;
        if (currentUser != null) {
          // Fetch the user's data from Firestore
          final userModel = await _userRepository.fetchUser();
          if (userModel != null) {
            state = userModel;
          }
        }
      }
    } catch (e) {
      print('사용자 초기화 중 오류 발생: $e');
    }
  }

  // 사용자 정보 실시간 업데이트 메서드
  Future<void> updateUserInfo({
    String? username,
    int? level,
    int? experience,
    int? totalStudyTime,
    int? money,
  }) async {
    try {
      // 현재 상태를 기반으로 새 UserModel 생성
      final updatedUser = state.copyWith(
        username: username,
        level: level,
        experience: experience,
        totalStudyTime: totalStudyTime,
        money: money,
      );

      // Firestore에 업데이트
      await _userRepository.saveUser(updatedUser);

      // 상태 업데이트
      state = updatedUser;
    } catch (e) {
      print('사용자 정보 업데이트 중 오류 발생: $e');
    }
  }

  // 사용자 경험치 추가 메서드
  Future<void> addExperience(int amount) async {
    final newExperience = state.experience + amount;
    final newLevel = _calculateLevel(newExperience);

    await updateUserInfo(
      experience: newExperience,
      level: newLevel,
    );
  }

  // 레벨 계산 로직 (예시)
  int _calculateLevel(int experience) {
    // 간단한 레벨 계산 로직 (필요에 따라 조정)
    return (experience ~/ 100) + 1;
  }
}
