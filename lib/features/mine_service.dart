import 'dart:math';
import 'package:blueberry_timer/models/mine_resource.dart';
import 'package:blueberry_timer/states/mine_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/**
 * 광산 시스템을 관리하는 서비스입니다.
 *
 * 이 서비스는 다음 기능들을 제공합니다:
 * - 광산 상태 관리
 * - 채굴 시스템
 * - 보상 시스템
 * - 광산 레벨 관리
 *
 * 사용자는 공부 시간을 통해 광산에서 아이템을 채굴할 수 있으며,
 * 채굴한 아이템은 다양한 보상으로 교환할 수 있습니다.
 */

class MineService extends StateNotifier<MineState> {
  MineService() : super(MineState());

  MineResource? mine() {
    if (state.currentEnergy < 10) {
      return null; // 에너지 부족
    }

    final random = Random();
    final miningResult = random.nextDouble();

    // 레어도에 따른 자원 획득 확률
    MineResource? minedResource;
    for (var resource in state.availableResources) {
      if (miningResult <= resource.rarity) {
        minedResource = resource;
        break;
      }
    }

    if (minedResource != null) {
      // 자원 수집 및 에너지 감소
      final updatedCollectedResources = [
        ...state.collectedResources,
        minedResource
      ];

      return state.copyWith(
        collectedResources: updatedCollectedResources,
        currentEnergy: state.currentEnergy - 10,
        lastMineTime: DateTime.now(),
      ) as MineResource;
    }

    return null;
  }

  void restoreEnergy() {
    final maxEnergy = state.energyLevel * 100;
    state = state.copyWith(
      currentEnergy: maxEnergy,
      lastMineTime: DateTime.now(),
    );
  }
}

final mineServiceProvider =
    StateNotifierProvider<MineService, MineState>((ref) {
  return MineService();
});
