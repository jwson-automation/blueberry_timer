import 'package:blueberry_timer/widgets/achievement_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:blueberry_timer/widgets/user_profile_widget.dart';

class UserProfileDialog extends ConsumerWidget {
  const UserProfileDialog({super.key});

  static void show(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const Dialog(
        insetPadding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                UserProfileWidget(),
                SizedBox(height: 16),
                AchievementListWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 이 메서드는 직접적으로 사용되지 않지만, ConsumerWidget을 상속받기 위해 필요합니다.
    return const SizedBox.shrink();
  }
}

void showUserProfileDialog(BuildContext context) {
  UserProfileDialog.show(context);
}
