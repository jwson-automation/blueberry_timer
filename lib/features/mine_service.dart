import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MineResource {
  final String name;
  final String imagePath;
  final int baseValue;
  final Color color;
  final double rarity;

  const MineResource({
    required this.name,
    required this.imagePath,
    required this.baseValue,
    required this.color,
    required this.rarity,
  });
}

class MineState {
  final List<MineResource> availableResources;
  final List<MineResource> collectedResources;
  final int pickaxeLevel;
  final int energyLevel;
  final int currentEnergy;
  final DateTime lastMineTime;

  MineState({
    this.availableResources = _defaultResources,
    this.collectedResources = const [],
    this.pickaxeLevel = 1,
    this.energyLevel = 1,
    this.currentEnergy = 100,
    DateTime? lastMineTime,
  }) : lastMineTime = lastMineTime ?? DateTime.now();

  MineState copyWith({
    List<MineResource>? availableResources,
    List<MineResource>? collectedResources,
    int? pickaxeLevel,
    int? energyLevel,
    int? currentEnergy,
    DateTime? lastMineTime,
  }) {
    return MineState(
      availableResources: availableResources ?? this.availableResources,
      collectedResources: collectedResources ?? this.collectedResources,
      pickaxeLevel: pickaxeLevel ?? this.pickaxeLevel,
      energyLevel: energyLevel ?? this.energyLevel,
      currentEnergy: currentEnergy ?? this.currentEnergy,
      lastMineTime: lastMineTime ?? this.lastMineTime,
    );
  }

  static const List<MineResource> _defaultResources = [
    MineResource(
      name: '구리',
      imagePath: 'assets/mine/copper.png',
      baseValue: 10,
      color: Colors.brown,
      rarity: 0.5,
    ),
    MineResource(
      name: '은',
      imagePath: 'assets/mine/silver.png',
      baseValue: 50,
      color: Colors.grey,
      rarity: 0.3,
    ),
    MineResource(
      name: '금',
      imagePath: 'assets/mine/gold.png',
      baseValue: 100,
      color: Colors.amber,
      rarity: 0.15,
    ),
    MineResource(
      name: '다이아몬드',
      imagePath: 'assets/mine/diamond.png',
      baseValue: 500,
      color: Colors.blue,
      rarity: 0.05,
    ),
  ];
}

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
      final updatedCollectedResources = [...state.collectedResources, minedResource];
      
      return state.copyWith(
        collectedResources: updatedCollectedResources,
        currentEnergy: state.currentEnergy - 10,
        lastMineTime: DateTime.now(),
      ) as MineResource;
    }

    return null;
  }

  void upgradePickaxe() {
    if (state.pickaxeLevel < 5) {
      state = state.copyWith(pickaxeLevel: state.pickaxeLevel + 1);
    }
  }

  void upgradeEnergy() {
    if (state.energyLevel < 5) {
      state = state.copyWith(energyLevel: state.energyLevel + 1);
    }
  }

  void restoreEnergy() {
    final maxEnergy = state.energyLevel * 100;
    state = state.copyWith(
      currentEnergy: maxEnergy,
      lastMineTime: DateTime.now(),
    );
  }
}

final mineServiceProvider = StateNotifierProvider<MineService, MineState>((ref) {
  return MineService();
});
