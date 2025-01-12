import 'package:blueberry_timer/models/mine_model.dart';
import 'package:flutter/material.dart';

class MineState {
  final List<MineModel> availableResources;
  final List<MineModel> collectedResources;
  final int energyLevel;
  final int currentEnergy;
  final DateTime lastMineTime;

  static const List<MineModel> _defaultResources = [
    MineModel(
      name: '구리',
      imagePath: 'assets/mine/copper.png',
      baseValue: 10,
      color: Color(0xFF795548),
      // Colors.brown
      rarity: 0.5,
    ),
    const MineModel(
      name: '은',
      imagePath: 'assets/mine/silver.png',
      baseValue: 50,
      color: Color(0xFF9E9E9E),
      // Colors.grey
      rarity: 0.3,
    ),
    const MineModel(
      name: '금',
      imagePath: 'assets/mine/gold.png',
      baseValue: 100,
      color: Color(0xFFFFC107),
      // Colors.amber
      rarity: 0.15,
    ),
    const MineModel(
      name: '다이아몬드',
      imagePath: 'assets/mine/diamond.png',
      baseValue: 500,
      color: Color(0xFF2196F3),
      // Colors.blue
      rarity: 0.05,
    ),
  ];

  MineState({
    this.availableResources = _defaultResources,
    this.collectedResources = const [],
    this.energyLevel = 1,
    this.currentEnergy = 100,
    DateTime? lastMineTime,
  }) : lastMineTime = lastMineTime ?? DateTime.now();

  MineState copyWith({
    List<MineModel>? availableResources,
    List<MineModel>? collectedResources,
    int? energyLevel,
    int? currentEnergy,
    DateTime? lastMineTime,
  }) {
    return MineState(
      availableResources: availableResources ?? this.availableResources,
      collectedResources: collectedResources ?? this.collectedResources,
      energyLevel: energyLevel ?? this.energyLevel,
      currentEnergy: currentEnergy ?? this.currentEnergy,
      lastMineTime: lastMineTime ?? this.lastMineTime,
    );
  }
}
