import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:blueberry_timer/features/mine_service.dart';

/**
 * 광산 캐릭터의 로티 애니메이션을 관리하는 서비스입니다.
 * 
 * 이 서비스는 다음 기능들을 제공합니다:
 * - 광산 캐릭터 애니메이션 관리
 * - 채굴 상태에 따른 애니메이션 전환
 * - 캐릭터 상호작용 효과
 * 
 * 채굴 진행 상황에 따라 캐릭터의 모습이 변화하며,
 * 사용자의 채굴 활동을 시각적으로 표현합니다.
 */

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
