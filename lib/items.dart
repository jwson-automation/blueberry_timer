import 'package:flutter/material.dart';

// Item model
class Item {
  final String id;
  final String name;
  final String imagePath;
  final Color backgroundColor;

  const Item({
    required this.id,
    required this.name,
    required this.imagePath,
    required this.backgroundColor,
  });
}

final List<Item> itemList = [
  Item(
    id: '1',
    name: 'Golden Book',
    imagePath: 'assets/items/broom.svg',
    backgroundColor: Colors.amber.shade100,
  ),
  Item(
    id: '2',
    name: 'Magic Pencil',
    imagePath: 'assets/items/card.svg',
    backgroundColor: Colors.blue.shade100,
  ),
  Item(
    id: '3',
    name: 'Study Lamp',
    imagePath: 'assets/items/crystal.svg',
    backgroundColor: Colors.green.shade100,
  ),
  Item(
    id: '4',
    name: 'Brain Booster',
    imagePath: 'assets/items/eye.svg',
    backgroundColor: Colors.purple.shade100,
  ),
  Item(
    id: '5',
    name: 'Motivational Poster',
    imagePath: 'assets/items/flask.svg',
    backgroundColor: Colors.orange.shade100,
  ),
  Item(
    id: '6',
    name: 'Noise Canceller',
    imagePath: 'assets/items/hand.svg',
    backgroundColor: Colors.teal.shade100,
  ),
  Item(
    id: '7',
    name: 'Meditation Cushion',
    imagePath: 'assets/items/hat.svg',
    backgroundColor: Colors.pink.shade100,
  ),
  Item(
    id: '8',
    name: 'Focus Crystal',
    imagePath: 'assets/items/illusion.svg',
    backgroundColor: Colors.indigo.shade100,
  ),
  Item(
    id: '9',
    name: 'Productivity Planner',
    imagePath: 'assets/items/potion.svg',
    backgroundColor: Colors.brown.shade100,
  ),
  Item(
    id: '10',
    name: 'Energy Drink',
    imagePath: 'assets/items/sparkles.svg',
    backgroundColor: Colors.lime.shade100,
  ),
];
