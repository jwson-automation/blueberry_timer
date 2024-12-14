import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:blueberry_timer/features/user_service.dart';
import 'package:blueberry_timer/widgets/experience_bar.dart';

class UserProfileWidget extends ConsumerWidget {
  const UserProfileWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userProfile = ref.watch(userServiceProvider).profile;
    
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const CircleAvatar(
          radius: 50,
          child: Icon(Icons.person, size: 50),
        ),
        const SizedBox(height: 16),
        Text(
          userProfile.username,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 8),
        ExperienceBar(profile: userProfile),
        const SizedBox(height: 16),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                _buildStatRow(
                  context,
                  '총 공부 시간',
                  '${(userProfile.totalStudyTime / 60).toStringAsFixed(1)}시간',
                ),
                const SizedBox(height: 8),
                _buildStatRow(
                  context,
                  '현재 레벨',
                  'Lv.${userProfile.level}',
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatRow(BuildContext context, String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        Text(
          value,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
      ],
    );
  }
}
