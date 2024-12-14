import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AchievementListWidget extends ConsumerWidget {
  const AchievementListWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: Replace with actual achievements data
    final achievements = [
      {'title': '첫 타이머 시작', 'description': '첫 번째 타이머를 시작했습니다!', 'unlocked': true},
      {'title': '1시간 달성', 'description': '총 공부시간 1시간을 달성했습니다!', 'unlocked': false},
      {'title': '3일 연속', 'description': '3일 연속으로 공부했습니다!', 'unlocked': false},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            '업적',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: achievements.length,
          itemBuilder: (context, index) {
            final achievement = achievements[index];
            return Card(
              child: ListTile(
                leading: Icon(
                  achievement['unlocked'] as bool
                      ? Icons.emoji_events
                      : Icons.lock_outline,
                  color: achievement['unlocked'] as bool
                      ? Colors.amber
                      : Colors.grey,
                ),
                title: Text(
                  achievement['title'] as String,
                  style: TextStyle(
                    color: achievement['unlocked'] as bool
                        ? null
                        : Colors.grey,
                  ),
                ),
                subtitle: Text(
                  achievement['description'] as String,
                  style: TextStyle(
                    color: achievement['unlocked'] as bool
                        ? null
                        : Colors.grey,
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
