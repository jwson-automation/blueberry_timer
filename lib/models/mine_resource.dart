import 'package:flutter/material.dart';

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
