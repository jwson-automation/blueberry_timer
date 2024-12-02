import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'timer_service.dart';
import 'music_service.dart';
import 'lottie_service.dart';

class TimerScreen extends ConsumerStatefulWidget {
  const TimerScreen({super.key});

  @override
  TimerScreenState createState() => TimerScreenState();
}

class TimerScreenState extends ConsumerState<TimerScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    ref.read(lottieServiceProvider.notifier).initController(this);
  }

  @override
  Widget build(BuildContext context) {
    // watch : 존재를 지켜보다. 지속적으로 가져오는 상황
    final timerState = ref.watch(timerServiceProvider);
    final musicState = ref.watch(musicServiceProvider);
    final lottieState = ref.watch(lottieServiceProvider);

    // read : 책, 정보를 읽다. 순간적으로 가져오는 상황
    final timerNotifier = ref.read(timerServiceProvider.notifier);
    final musicNotifier = ref.read(musicServiceProvider.notifier);
    final lottieNotifier = ref.read(lottieServiceProvider.notifier);

    // Use a post-frame callback to handle animation state
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (timerState.isRunning && !lottieState.isAnimating) {
        lottieNotifier.startAnimation();
      } else if (!timerState.isRunning && lottieState.isAnimating) {
        lottieNotifier.stopAnimation();
      }
    });

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Lottie Animation
            SizedBox(
              width: 200,
              height: 200,
              child: Lottie.asset(
                'assets/lottie/pig.json',
                controller: lottieNotifier.controller,
                fit: BoxFit.cover,
              ),
            ),

            // Timer Display
            Text(
              timerNotifier.formatTime(),
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: timerState.isStudyPhase ? Colors.cyan : Colors.orange,
                shadows: [
                  Shadow(
                    blurRadius: 10.0,
                    color:
                        timerState.isStudyPhase ? Colors.cyan : Colors.orange,
                    offset: const Offset(0, 0),
                  )
                ],
              ),
            ),

            // Phase Indicator
            Text(
              timerState.isStudyPhase ? 'Study Time' : 'Rest Time',
              style: TextStyle(
                fontSize: 20,
                color: timerState.isStudyPhase ? Colors.cyan : Colors.orange,
              ),
            ),

            const SizedBox(height: 30),

            // Control Buttons
            Row(
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
                  icon:
                      musicState.isPlaying ? Icons.music_note : Icons.music_off,
                  color: Colors.purple,
                  onPressed: musicState.isPlaying
                      ? musicNotifier.pauseMusic
                      : musicNotifier.playMusic,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNeonButton(
      {required IconData icon,
      required Color color,
      required VoidCallback onPressed}) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.5),
            blurRadius: 15,
            spreadRadius: 2,
          )
        ],
        borderRadius: BorderRadius.circular(50),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: const CircleBorder(),
          padding: const EdgeInsets.all(15),
        ),
        onPressed: onPressed,
        child: Icon(icon, size: 30, color: Colors.white),
      ),
    );
  }
}
