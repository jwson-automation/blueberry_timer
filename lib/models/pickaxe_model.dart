class PickaxeModel {
  final int level;
  final int baseReward;
  final int upgradeCost;

  const PickaxeModel({
    required this.level,
    required this.baseReward,
    required this.upgradeCost,
  });

  // 다음 레벨 업그레이드 비용 계산
  static int calculateUpgradeCost(int level) {
    return 500 * level;  // 레벨당 500원씩 증가
  }

  // 현재 레벨의 기본 보상 계산
  static int calculateBaseReward(int level) {
    return 100 + (50 * (level - 1));  // 레벨 1: 100원, 레벨 2: 150원, 레벨 3: 200원...
  }

  // 다음 레벨의 곡괭이 정보
  PickaxeModel nextLevel() {
    final nextLevel = level + 1;
    return PickaxeModel(
      level: nextLevel,
      baseReward: calculateBaseReward(nextLevel),
      upgradeCost: calculateUpgradeCost(nextLevel),
    );
  }

  // 현재 곡괭이의 보상 설명
  String get rewardDescription => '공부 완료시 ${baseReward}원';

  // 다음 레벨 업그레이드 설명
  String get upgradeDescription => '${upgradeCost}원으로 업그레이드';
}
