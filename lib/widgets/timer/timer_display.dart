import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:blueberry_timer/l10n/app_localizations.dart';
import '../../features/timer_service.dart';
import '../../features/lottie_service.dart';

/// 타이머 디스플레이 위젯
class TimerDisplay extends ConsumerWidget {
  const TimerDisplay({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final timerState = ref.watch(timerServiceProvider);
    final lottieState = ref.watch(lottieServiceProvider);
    final lottieNotifier = ref.read(lottieServiceProvider.notifier);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Lottie Animation
        SizedBox(
          width: 200,
          height: 200,
          child: Lottie.asset(
            lottieState.currentAnimation,
            controller: lottieNotifier.controller,
            fit: BoxFit.cover,
          ),
        ),

        // Timer Display
        Text(
          ref.read(timerServiceProvider.notifier).formatTime(),
          style: TextStyle(
            fontSize: 48,
            fontWeight: FontWeight.bold,
            color: timerState.isStudyPhase ? Colors.cyan : Colors.orange,
            shadows: [
              Shadow(
                blurRadius: 10.0,
                color: timerState.isStudyPhase ? Colors.cyan : Colors.orange,
                offset: const Offset(0, 0),
              )
            ],
          ),
        ),

        // Phase Indicator
        Text(
          timerState.isStudyPhase ? l10n.timerStudyPhase : l10n.timerRestPhase,
          style: TextStyle(
            fontSize: 20,
            color: timerState.isStudyPhase ? Colors.cyan : Colors.orange,
          ),
        ),
      ],
    );
  }
}
