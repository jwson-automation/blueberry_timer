import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:blueberry_timer/models/timer_model.dart';
import 'dart:async';

/**
 * 타이머 기능을 관리하는 서비스입니다.
 * 
 * 이 서비스는 다음 기능들을 제공합니다:
 * - 공부/휴식 시간 타이머 관리
 * - 타이머 시작, 일시정지, 리셋
 * - 타이머 상태 및 남은 시간 관리
 * - 공부/휴식 모드 전환
 * 
 * 타이머는 25분 공부, 5분 휴식의 기본 설정을 가지며,
 * 사용자의 설정에 따라 시간을 조절할 수 있습니다.
 */

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
