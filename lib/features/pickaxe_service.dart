import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:blueberry_timer/models/pickaxe_model.dart';

class PickaxeService extends StateNotifier<PickaxeModel> {
  PickaxeService()
      : super(PickaxeModel(
          level: 1,
          baseReward: PickaxeModel.calculateBaseReward(1),
          upgradeCost: PickaxeModel.calculateUpgradeCost(1),
        ));

  // 현재 보상 금액 반환
  int get currentReward => state.baseReward;

  // 곡괭이 레벨 업그레이드
  void upgrade() {
    state = state.nextLevel();
  }
}

final pickaxeServiceProvider =
    StateNotifierProvider<PickaxeService, PickaxeModel>((ref) {
  return PickaxeService();
});
