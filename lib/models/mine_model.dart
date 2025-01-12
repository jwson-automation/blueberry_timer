import 'package:flutter/material.dart';

class MineModel {
  final String name;
  final String imagePath;
  final int baseValue;
  final Color color;
  final double rarity;

  const MineModel({
    required this.name,
    required this.imagePath,
    required this.baseValue,
    required this.color,
    required this.rarity,
  });
}
