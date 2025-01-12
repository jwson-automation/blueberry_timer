import 'package:blueberry_timer/models/mine_resource.dart';
import 'package:flutter/material.dart';

class MineState {
  final List<MineResource> availableResources;
  final List<MineResource> collectedResources;
  final int energyLevel;
  final int currentEnergy;
  final DateTime lastMineTime;

  static const List<MineResource> _defaultResources = [
    MineResource(
      name: '구리',
      imagePath: 'assets/mine/copper.png',
      baseValue: 10,
      color: Color(0xFF795548),
      // Colors.brown
      rarity: 0.5,
    ),
    const MineResource(
      name: '은',
      imagePath: 'assets/mine/silver.png',
      baseValue: 50,
      color: Color(0xFF9E9E9E),
      // Colors.grey
      rarity: 0.3,
    ),
    const MineResource(
      name: '금',
      imagePath: 'assets/mine/gold.png',
      baseValue: 100,
      color: Color(0xFFFFC107),
      // Colors.amber
      rarity: 0.15,
    ),
    const MineResource(
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
    List<MineResource>? availableResources,
    List<MineResource>? collectedResources,
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
