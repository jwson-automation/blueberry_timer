import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:blueberry_timer/features/mine_service.dart';

class MineLottieState {
  final AnimationController? controller;
  final bool isAnimating;

  MineLottieState({
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

class MineLottieService extends StateNotifier<MineLottieState> {
  final Ref ref;
  Timer? _autoMiningTimer;

  MineLottieService(this.ref) : super(MineLottieState());

  void initController(TickerProvider vsync) {
    if (state.controller == null) {
      final controller = AnimationController(
        vsync: vsync,
        duration: const Duration(seconds: 2),
      )..repeat(reverse: true);

      state = state.copyWith(
        controller: controller,
        isAnimating: true,
      );

      // 자동 채굴 타이머 시작
      _startAutoMiningTimer();
    }
  }

  void _startAutoMiningTimer() {
    _autoMiningTimer = Timer.periodic(const Duration(seconds: 30), (_) {
      final mineService = ref.read(mineServiceProvider.notifier);
      final mineState = ref.read(mineServiceProvider);

      if (mineState.currentEnergy >= 10) {
        mineService.mine();
      }
    });
  }

  void toggleAnimation(bool isPlaying) {
    if (state.controller != null) {
      if (isPlaying) {
        state.controller!.repeat(reverse: true);
      } else {
        state.controller!.stop();
      }
      state = state.copyWith(isAnimating: isPlaying);
    }
  }

  @override
  void dispose() {
    state.controller?.dispose();
    _autoMiningTimer?.cancel();
    super.dispose();
  }
}

final mineLottieServiceProvider = StateNotifierProvider<MineLottieService, MineLottieState>(
  (ref) => MineLottieService(ref),
);
