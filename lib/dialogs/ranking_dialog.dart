import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../features/ranking_service.dart';
import '../models/ranking_model.dart';

class RankingDialog extends ConsumerWidget {
  const RankingDialog({super.key});

  static void show(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const RankingDialog(),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rankings = ref.watch(rankingServiceProvider).getRankings();

    return Dialog(
      backgroundColor: Colors.grey[900],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  '랭킹',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const Divider(color: Colors.white24),
            const SizedBox(height: 8),
            ConstrainedBox(
              constraints: const BoxConstraints(
                maxHeight: 400,
              ),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: rankings.length,
                itemBuilder: (context, index) {
                  final entry = rankings[index];
                  return _buildRankingCard(entry);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRankingCard(RankingEntry entry) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      color: Colors.grey[850],
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _getRankColor(entry.rank),
          child: Text(
            '${entry.rank}',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        title: Text(
          entry.username,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          'Level ${entry.level}',
          style: TextStyle(
            color: Colors.grey[400],
          ),
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              entry.formattedStudyTime,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            Text(
              '총 공부시간',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[400],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getRankColor(int rank) {
    switch (rank) {
      case 1:
        return Colors.amber; // 금메달
      case 2:
        return Colors.grey[400]!; // 은메달
      case 3:
        return Colors.brown[300]!; // 동메달
      default:
        return Colors.blue[300]!;
    }
  }
}
