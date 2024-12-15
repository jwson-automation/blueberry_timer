import 'dart:math';
import 'package:blueberry_timer/items.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:blueberry_timer/features/message_service.dart';

// Item State
class ItemState {
  final List<Item> collectedItems;
  final List<Item> availableItems;

  const ItemState({
    this.collectedItems = const [],
    this.availableItems = const [],
  });

  ItemState copyWith({
    List<Item>? collectedItems,
    List<Item>? availableItems,
  }) {
    return ItemState(
      collectedItems: collectedItems ?? this.collectedItems,
      availableItems: availableItems ?? this.availableItems,
    );
  }
}

// Item Service Provider
final navigatorKey = GlobalKey<NavigatorState>();
final itemServiceProvider =
    StateNotifierProvider<ItemService, ItemState>((ref) {
  return ItemService();
});

class ItemService extends StateNotifier<ItemState> {
  ItemService() : super(ItemState(availableItems: itemList));

  String? collectRandomItem() {
    if (state.availableItems.isNotEmpty) {
      final random = Random();
      final randomIndex = random.nextInt(state.availableItems.length);
      final collectedItem = state.availableItems[randomIndex];

      // 이미 수집된 아이템인지 확인하고 수량을 증가시킵니다
      final updatedCollectedItems = List<Item>.from(state.collectedItems);
      final existingItemIndex = updatedCollectedItems.indexWhere((item) => item.id == collectedItem.id);
      
      if (existingItemIndex != -1) {
        // 이미 있는 아이템이면 수량을 증가시킨 새 아이템으로 교체
        final existingItem = updatedCollectedItems[existingItemIndex];
        updatedCollectedItems[existingItemIndex] = existingItem.copyWith(
          quantity: existingItem.quantity + 1
        );

        state = ItemState(
          collectedItems: updatedCollectedItems,
          availableItems: state.availableItems,
        );

        return '✨ 아이템 수량이 증가했습니다!';
      } else {
        // 새로운 아이템이면 추가
        updatedCollectedItems.add(collectedItem);
        
        state = ItemState(
          collectedItems: updatedCollectedItems,
          availableItems: state.availableItems,
        );

        return '🎁 새로운 아이템을 획득했습니다: ${collectedItem.name}';
      }
    } else {
      return '⚠️ 더 이상 수집할 수 있는 아이템이 없습니다';
    }
  }

  String resetItems() {
    state = ItemState(
      collectedItems: [],
      availableItems: itemList,
    );
    return '✅ 아이템이 초기화되었습니다. 총 ${itemList.length}개의 아이템을 수집할 수 있습니다.';
  }
}
