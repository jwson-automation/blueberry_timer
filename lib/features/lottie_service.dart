import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
