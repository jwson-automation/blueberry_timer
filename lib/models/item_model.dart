import 'package:flutter/material.dart';

// Item model
class ItemModel {
  final String id;
  final String name;
  final String imagePath;
  final Color backgroundColor;
  final int quantity;
  final String description;

  const ItemModel({
    required this.id,
    required this.name,
    required this.imagePath,
    required this.backgroundColor,
    this.quantity = 1,
    required this.description,
  });

  ItemModel copyWith({
    String? id,
    String? name,
    String? imagePath,
    Color? backgroundColor,
    int? quantity,
    String? description,
  }) {
    return ItemModel(
      id: id ?? this.id,
      name: name ?? this.name,
      imagePath: imagePath ?? this.imagePath,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      quantity: quantity ?? this.quantity,
      description: description ?? this.description,
    );
  }
}

final List<ItemModel> itemList = [
  ItemModel(
    id: '1',
    name: '좋은 빗자루',
    imagePath: 'assets/items/broom.svg',
    backgroundColor: Colors.amber.shade100,
    description: '아이템 획득 확률을 높여줍니다.',
  ),
  ItemModel(
    id: '2',
    name: '좋은 연필',
    imagePath: 'assets/items/card.svg',
    backgroundColor: Colors.blue.shade100,
    description: '광산의 채굴 속도가 빨라집니다.',
  ),
  ItemModel(
    id: '3',
    name: '공부 전등',
    imagePath: 'assets/items/crystal.svg',
    backgroundColor: Colors.green.shade100,
    description: '희귀한 아이템을 획득할 확률을 높여줍니다.',
  ),
  ItemModel(
    id: '4',
    name: '인공지능',
    imagePath: 'assets/items/eye.svg',
    backgroundColor: Colors.purple.shade100,
    description: '아이템의 강화 성공 확률을 높여줍니다.',
  ),
];
