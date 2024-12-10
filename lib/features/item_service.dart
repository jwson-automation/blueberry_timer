import 'dart:math';
import 'package:blueberry_timer/items.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
final itemServiceProvider =
    StateNotifierProvider<ItemService, ItemState>((ref) {
  return ItemService();
});

class ItemService extends StateNotifier<ItemState> {
  ItemService() : super(ItemState(availableItems: itemList));

  void collectRandomItem() {
    if (state.availableItems.isNotEmpty) {
      final random = Random();
      final randomIndex = random.nextInt(state.availableItems.length);
      final collectedItem = state.availableItems[randomIndex];

      print('🎁 Collecting new item: ${collectedItem.name}');

      // 이미 수집된 아이템인지 확인하고 수량을 증가시킵니다
      final updatedCollectedItems = List<Item>.from(state.collectedItems);
      final existingItemIndex = updatedCollectedItems.indexWhere((item) => item.id == collectedItem.id);
      
      if (existingItemIndex != -1) {
        // 이미 있는 아이템이면 수량을 증가시킨 새 아이템으로 교체
        final existingItem = updatedCollectedItems[existingItemIndex];
        updatedCollectedItems[existingItemIndex] = existingItem.copyWith(
          quantity: existingItem.quantity + 1
        );
      } else {
        // 새로운 아이템이면 추가
        updatedCollectedItems.add(collectedItem);
      }

      state = ItemState(
        collectedItems: updatedCollectedItems,
        availableItems: state.availableItems,
      );

      print('✨ Item collected successfully!');
      print('🏆 Total collected items: ${state.collectedItems.length}');
    } else {
      print('⚠️ No more items available to collect');
    }
  }

  void resetItems() {
    state = ItemState(
      collectedItems: [],
      availableItems: itemList, // items.dart에서 가져온 itemList 사용
    );
    print(
        '✅ Items reset complete. All ${itemList.length} items are now available');
  }
}
