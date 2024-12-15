import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../features/timer_service.dart';
import '../../features/lottie_service.dart';
import '../../features/music_service.dart';

/// 컨트롤 버튼 위젯
class ControlButtons extends ConsumerWidget {
  const ControlButtons({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timerState = ref.watch(timerServiceProvider);
    final musicState = ref.watch(musicServiceProvider);
    final timerNotifier = ref.read(timerServiceProvider.notifier);
    final musicNotifier = ref.read(musicServiceProvider.notifier);
    final lottieNotifier = ref.read(lottieServiceProvider.notifier);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Timer Control Buttons
        _buildNeonButton(
          icon: timerState.isRunning ? Icons.pause : Icons.play_arrow,
          color: Colors.green,
          onPressed: timerState.isRunning
              ? timerNotifier.stopTimer
              : timerNotifier.startTimer,
        ),
        const SizedBox(width: 20),
        _buildNeonButton(
          icon: Icons.restart_alt,
          color: Colors.red,
          onPressed: () {
            timerNotifier.resetTimer();
            lottieNotifier.resetAnimation();
          },
        ),
        const SizedBox(width: 20),
        // Music Control Button
        _buildNeonButton(
          icon: musicState.isPlaying ? Icons.music_note : Icons.music_off,
          color: Colors.purple,
          onPressed:
              musicState.isPlaying ? musicNotifier.pauseMusic : musicNotifier.playMusic,
        ),
      ],
    );
  }

  Widget _buildNeonButton({
    required IconData icon,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.6),
            blurRadius: 12,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          customBorder: const CircleBorder(),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color.withOpacity(0.2),
            ),
            child: Icon(
              icon,
              color: color,
              size: 32,
            ),
          ),
        ),
      ),
    );
  }
}
