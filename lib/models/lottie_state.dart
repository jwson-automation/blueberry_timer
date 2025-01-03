import 'package:flutter/material.dart';

class LottieState {
  final bool isAnimating;
  final AnimationStatus? animationStatus;
  final bool isStudyPhase;

  const LottieState({
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
    return isStudyPhase ? 'assets/lottie/critical.json' : 'assets/lottie/stop.json';
  }
}
