import 'package:flutter/material.dart';

// Item model
class Item {
  final String id;
  final String name;
  final String imagePath;
  final Color backgroundColor;
  final int quantity;
  final String description;

  const Item({
    required this.id,
    required this.name,
    required this.imagePath,
    required this.backgroundColor,
    this.quantity = 1,
    required this.description,
  });

  Item copyWith({
    String? id,
    String? name,
    String? imagePath,
    Color? backgroundColor,
    int? quantity,
    String? description,
  }) {
    return Item(
      id: id ?? this.id,
      name: name ?? this.name,
      imagePath: imagePath ?? this.imagePath,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      quantity: quantity ?? this.quantity,
      description: description ?? this.description,
    );
  }
}

final List<Item> itemList = [
  Item(
    id: '1',
    name: 'Golden Book',
    imagePath: 'assets/items/broom.svg',
    backgroundColor: Colors.amber.shade100,
    description: '아이템 획득 확률을 높여줍니다.',
  ),
  Item(
    id: '2',
    name: 'Magic Pencil',
    imagePath: 'assets/items/card.svg',
    backgroundColor: Colors.blue.shade100,
    description: '광산의 채굴 속도가 빨라집니다.',
  ),
  Item(
    id: '3',
    name: 'Study Lamp',
    imagePath: 'assets/items/crystal.svg',
    backgroundColor: Colors.green.shade100,
    description: '희귀한 아이템을 획득할 확률을 높여줍니다.',
  ),
  Item(
    id: '4',
    name: 'Brain Booster',
    imagePath: 'assets/items/eye.svg',
    backgroundColor: Colors.purple.shade100,
    description: '아이템의 강화 성공 확률을 높여줍니다.',
  ),
  Item(
    id: '5',
    name: 'Motivational Poster',
    imagePath: 'assets/items/flask.svg',
    backgroundColor: Colors.orange.shade100,
    description: '아이템 판매 시의 가격을 높여줍니다.',
  ),
  Item(
    id: '6',
    name: 'Noise Canceller',
    imagePath: 'assets/items/hand.svg',
    backgroundColor: Colors.teal.shade100,
    description: '정말 아무 쓸모도 없는 아이템입니다.',
  ),
  Item(
    id: '7',
    name: 'Meditation Cushion',
    imagePath: 'assets/items/hat.svg',
    backgroundColor: Colors.pink.shade100,
    description: '이름을 바꿀 수 있습니다.',
  ),
  Item(
    id: '8',
    name: 'Focus Crystal',
    imagePath: 'assets/items/illusion.svg',
    backgroundColor: Colors.indigo.shade100,
    description: '언젠가 사용될 이벤트 추첨권 입니다.',
  ),
  Item(
    id: '9',
    name: 'Productivity Planner',
    imagePath: 'assets/items/potion.svg',
    backgroundColor: Colors.brown.shade100,
    description: '초기 유저만 가지고 있는 아이템입니다.',
  ),
  Item(
    id: '10',
    name: 'Energy Drink',
    imagePath: 'assets/items/sparkles.svg',
    backgroundColor: Colors.lime.shade100,
    description: '공부 시간을 충전해줍니다.',
  ),
];
