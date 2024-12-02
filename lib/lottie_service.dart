import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Lottie State: manages the state of the Lottie animation
class LottieState {
  final bool isAnimating;
  final AnimationStatus? animationStatus;

  LottieState({required this.isAnimating, this.animationStatus});

  LottieState copyWith({bool? isAnimating, AnimationStatus? animationStatus}) {
    return LottieState(
      isAnimating: isAnimating ?? this.isAnimating,
      animationStatus: animationStatus ?? this.animationStatus,
    );
  }
}

// Lottie Service Provider: provides Lottie animation control
final lottieServiceProvider =
    StateNotifierProvider.autoDispose<LottieService, LottieState>((ref) {
  return LottieService();
});

class LottieService extends StateNotifier<LottieState> {
  AnimationController? _controller;

  LottieService() : super(LottieState(isAnimating: false));

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

  AnimationController? get controller => _controller;

  void dispose() {
    _controller?.dispose();
  }
}
