import 'package:blueberry_timer/models/user_model.dart';

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
