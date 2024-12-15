import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../features/user_service.dart';
import '../features/ranking_service.dart';

class CurrentRankWidget extends ConsumerWidget {
  const CurrentRankWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.purple.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Consumer(
        builder: (context, ref, _) {
          final userStudyTime = ref.watch(userServiceProvider).profile.totalStudyTime;
          final (rank, total) = ref.watch(rankingServiceProvider).getCurrentUserRanking(userStudyTime);
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.emoji_events,
                color: Colors.purple,
                size: 20,
              ),
              const SizedBox(width: 4),
              Text(
                '$total명 중 ${rank}위',
                style: const TextStyle(
                  color: Colors.purple,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
