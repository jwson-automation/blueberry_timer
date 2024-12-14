import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:async';

// 타이머 상태
class TimerState {
  final int currentTime;
  final bool isRunning;
  final bool isStudyPhase;
  final int studyTime;  // 설정된 공부 시간

  TimerState({
    required this.currentTime,
    required this.isRunning,
    required this.isStudyPhase,
    required this.studyTime,
  });

  TimerState copyWith({
    int? currentTime,
    bool? isRunning,
    bool? isStudyPhase,
    int? studyTime,
  }) {
    return TimerState(
      currentTime: currentTime ?? this.currentTime,
      isRunning: isRunning ?? this.isRunning,
      isStudyPhase: isStudyPhase ?? this.isStudyPhase,
      studyTime: studyTime ?? this.studyTime,
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
  final int startTime = 3; // 25분 공부 시간
  final int breakTime = 3; // 5분 휴식 시간

  TimerService()
      : super(TimerState(
          currentTime: 3,
          isRunning: false,
          isStudyPhase: true,
          studyTime: 3,
        ));

  void startTimer() {
    if (!state.isRunning) {
      state = state.copyWith(
        isRunning: true,
        currentTime: state.isStudyPhase ? startTime : breakTime,
        studyTime: state.isStudyPhase ? startTime : state.studyTime,
      );

      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (state.currentTime > 0) {
          state = state.copyWith(currentTime: state.currentTime - 1);
        } else {
          if (state.isStudyPhase) {
            // 스터디 페이즈가 끝났을 때
            print(' Study phase completed!');
            state = state.copyWith(
              currentTime: breakTime,
              isStudyPhase: false,
            );
          } else {
            // 휴식 페이즈가 끝났을 때
            print(' Break phase completed!');
            state = state.copyWith(
              currentTime: startTime,
              isStudyPhase: true,
            );
          }
        }
      });
    }
  }

  void stopTimer() {
    if (state.isRunning) {
      _timer?.cancel();
      state = state.copyWith(isRunning: false);
      print(' Timer stopped');
    }
  }

  void resetTimer() {
    print(' Resetting timer...');
    _timer?.cancel();
    state = TimerState(
        currentTime: startTime, isRunning: false, isStudyPhase: true, studyTime: 3);
  }

  String formatTime() {
    int minutes = state.currentTime ~/ 60;
    int remainingSeconds = state.currentTime % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }
}
