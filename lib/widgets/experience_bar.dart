import 'package:flutter/material.dart';
import 'package:blueberry_timer/user_info.dart';

class ExperienceBar extends StatelessWidget {
  final UserProfile profile;

  const ExperienceBar({
    super.key,
    required this.profile,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Lv.${profile.level}',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            Text(
              '${profile.experience}/${profile.experienceToNextLevel}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
        const SizedBox(height: 4),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: LinearProgressIndicator(
            value: profile.levelProgress,
            backgroundColor: Colors.grey[200],
            valueColor: AlwaysStoppedAnimation<Color>(
              profile.primaryColor.withOpacity(0.8),
            ),
            minHeight: 10,
          ),
        ),
      ],
    );
  }
}
