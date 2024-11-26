import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'timer_service.dart';
import 'music_service.dart';

class TimerScreen extends ConsumerStatefulWidget {
  @override
  _TimerScreenState createState() => _TimerScreenState();
}

class _TimerScreenState extends ConsumerState<TimerScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _lottieController;

  @override
  void initState() {
    super.initState();
    _lottieController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
  }

  @override
  Widget build(BuildContext context) {
    final timerState = ref.watch(timerServiceProvider);
    final musicState = ref.watch(musicServiceProvider);

    // Lottie Animation Control
    if (timerState.isRunning) {
      _lottieController.repeat();
    } else {
      _lottieController.stop();
    }

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Lottie Animation
            Container(
              width: 200,
              height: 200,
              child: Lottie.asset(
                'assets/lottie/pig.json',
                controller: _lottieController,
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
                    color:
                        timerState.isStudyPhase ? Colors.cyan : Colors.orange,
                    offset: Offset(0, 0),
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

            SizedBox(height: 30),

            // Control Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Timer Control Buttons
                _buildNeonButton(
                  icon: timerState.isRunning ? Icons.pause : Icons.play_arrow,
                  color: Colors.green,
                  onPressed: timerState.isRunning
                      ? ref.read(timerServiceProvider.notifier).stopTimer
                      : ref.read(timerServiceProvider.notifier).startTimer,
                ),
                SizedBox(width: 20),
                _buildNeonButton(
                  icon: Icons.restart_alt,
                  color: Colors.red,
                  onPressed: ref.read(timerServiceProvider.notifier).resetTimer,
                ),
                SizedBox(width: 20),
                // Music Control Button
                _buildNeonButton(
                  icon:
                      musicState.isPlaying ? Icons.music_off : Icons.music_note,
                  color: Colors.purple,
                  onPressed: musicState.isPlaying
                      ? ref.read(musicServiceProvider.notifier).pauseMusic
                      : ref.read(musicServiceProvider.notifier).playMusic,
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
          shape: CircleBorder(),
          padding: EdgeInsets.all(15),
        ),
        onPressed: onPressed,
        child: Icon(icon, size: 30, color: Colors.white),
      ),
    );
  }

  @override
  void dispose() {
    _lottieController.dispose();
    super.dispose();
  }
}
