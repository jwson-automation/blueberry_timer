import 'package:flutter/material.dart';

class MineLottieState {
  final AnimationController? controller;
  final bool isAnimating;

  const MineLottieState({
    this.controller,
    this.isAnimating = false,
  });

  MineLottieState copyWith({
    AnimationController? controller,
    bool? isAnimating,
  }) {
    return MineLottieState(
      controller: controller ?? this.controller,
      isAnimating: isAnimating ?? this.isAnimating,
    );
  }
}
