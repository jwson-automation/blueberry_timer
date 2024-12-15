import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/**
 * 로티 애니메이션을 관리하는 서비스입니다.
 * 
 * 이 서비스는 다음 기능들을 제공합니다:
 * - 공부/휴식 상태에 따른 캐릭터 애니메이션 전환
 * - 애니메이션 재생 상태 관리
 * - 캐릭터 표정과 동작 변경
 * 
 * 타이머의 상태에 따라 캐릭터의 모습이 자동으로 변화하며,
 * 사용자의 학습 진행 상황을 시각적으로 표현합니다.
 */

// Lottie State: manages the state of the Lottie animation
class LottieState {
  final bool isAnimating;
  final AnimationStatus? animationStatus;
  final bool isStudyPhase;

  LottieState({
    required this.isAnimating,
    this.animationStatus,
    required this.isStudyPhase,
  });

  LottieState copyWith({
    bool? isAnimating,
    AnimationStatus? animationStatus,
    bool? isStudyPhase,
  }) {
    return LottieState(
      isAnimating: isAnimating ?? this.isAnimating,
      animationStatus: animationStatus ?? this.animationStatus,
      isStudyPhase: isStudyPhase ?? this.isStudyPhase,
    );
  }

  String get currentAnimation {
    return isStudyPhase ? 'assets/lottie/study.json' : 'assets/lottie/rest.json';
  }
}

// Lottie Service Provider: provides Lottie animation control
final lottieServiceProvider =
    StateNotifierProvider.autoDispose<LottieService, LottieState>((ref) {
  return LottieService();
});

class LottieService extends StateNotifier<LottieState> {
  AnimationController? _controller;

  LottieService() : super(LottieState(isAnimating: false, isStudyPhase: true));

  void initController(TickerProvider vsync) {
    _controller = AnimationController(
      vsync: vsync,
      duration: const Duration(seconds: 2),
    )..addStatusListener((status) {
        state = state.copyWith(animationStatus: status);
      });
  }

  void startAnimation() {
    if (_controller != null && !state.isAnimating) {
      _controller!.repeat();
      state = state.copyWith(isAnimating: true);
    }
  }

  void stopAnimation() {
    if (_controller != null && state.isAnimating) {
      _controller!.stop();
      state = state.copyWith(isAnimating: false);
    }
  }

  void resetAnimation() {
    if (_controller != null) {
      _controller!.reset();
      state = state.copyWith(isAnimating: false);
    }
  }

  void setPhase(bool isStudyPhase) {
    state = state.copyWith(isStudyPhase: isStudyPhase);
  }

  AnimationController? get controller => _controller;

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}
