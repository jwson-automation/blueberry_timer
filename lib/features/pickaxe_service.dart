import 'package:blueberry_timer/models/pickaxe_model.dart';
import 'package:blueberry_timer/models/pickaxe_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PickaxeService extends StateNotifier<PickaxeState> {
  PickaxeService()
      : super(PickaxeState(
          pickaxe: PickaxeModel(
            level: 1,
            baseReward: PickaxeModel.calculateBaseReward(1),
            upgradeCost: PickaxeModel.calculateUpgradeCost(1),
          ),
        ));

  // 현재 보상 금액 반환
  int get currentReward => state.pickaxe.baseReward;

  // 곡괭이 레벨 업그레이드
  void upgrade() {
    state = state.copyWith(pickaxe: state.pickaxe.nextLevel());
  }
}

final pickaxeServiceProvider =
    StateNotifierProvider<PickaxeService, PickaxeState>((ref) {
  return PickaxeService();
});
