import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:async';

// 타이머 상태
class TimerState {
  final int currentTime;
  final bool isRunning;
  final bool isStudyPhase;

  TimerState({
    required this.currentTime,
    required this.isRunning,
    required this.isStudyPhase,
  });

  TimerState copyWith({
    int? currentTime,
    bool? isRunning,
    bool? isStudyPhase,
  }) {
    return TimerState(
      currentTime: currentTime ?? this.currentTime,
      isRunning: isRunning ?? this.isRunning,
      isStudyPhase: isStudyPhase ?? this.isStudyPhase,
    );
  }
}

// 타이머 서비스 프로바이더 : 타이머 서비스를 제공
final timerServiceProvider =
    StateNotifierProvider.autoDispose<TimerService, TimerState>((ref) {
  return TimerService();
});

// 타이머 서비스 : 타이머를 제어
class TimerService extends StateNotifier<TimerState> {
  Timer? _timer;
  final int startTime = 10; // 25분 공부 시간
  final int breakTime = 10; // 5분 휴식 시간
  // final int startTime = 25 * 60;  // 25분 공부 시간
  // final int breakTime = 5 * 60;   // 5분 휴식 시간

  TimerService()
      : super(TimerState(currentTime: 0, isRunning: false, isStudyPhase: true));

  void startTimer() {
    if (!state.isRunning) {
      state = state.copyWith(isRunning: true);

      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (state.currentTime > 0) {
          state = state.copyWith(currentTime: state.currentTime - 1);
        } else {
          _switchPhase();
        }
      });
    }
  }

  void _switchPhase() {
    if (state.isStudyPhase) {
      // 공부 시간 종료 → 휴식 시작
      state = state.copyWith(isStudyPhase: false, currentTime: breakTime);
    } else {
      // 휴식 시간 종료 → 다시 공부 시작
      state = state.copyWith(isStudyPhase: true, currentTime: startTime);
    }
  }

  void stopTimer() {
    if (state.isRunning) {
      _timer?.cancel();
      state = state.copyWith(isRunning: false);
    }
  }

  void resetTimer() {
    _timer?.cancel();
    state = TimerState(
        currentTime: startTime, isRunning: false, isStudyPhase: true);
  }

  String formatTime() {
    int minutes = state.currentTime ~/ 60;
    int remainingSeconds = state.currentTime % 60;

    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
