import 'dart:math';
import 'package:blueberry_timer/items.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Item State
class ItemState {
  final List<Item> collectedItems;
  final List<Item> availableItems;

  const ItemState({
    this.collectedItems = const [],
    required this.availableItems,
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
  ItemService()
      : super(ItemState(
          collectedItems: [],
          availableItems: itemList, // items.dart에서 가져온 itemList 사용
        )) {
    print('🎮 ItemService initialized with ${itemList.length} available items');
  }

  void collectRandomItem() {
    if (state.availableItems.isNotEmpty) {
      final random = Random();
      final randomIndex = random.nextInt(state.availableItems.length);
      final collectedItem = state.availableItems[randomIndex];

      print('🎁 Collecting new item: ${collectedItem.name}');
      print(
          '📊 Available items before collection: ${state.availableItems.length}');
      print('🏆 Previously collected items: ${state.collectedItems.length}');

      state = ItemState(
        collectedItems: [...state.collectedItems, collectedItem],
        availableItems: List.from(state.availableItems)..removeAt(randomIndex),
      );

      print('✨ Item collected successfully!');
      print('📊 Remaining available items: ${state.availableItems.length}');
      print('🏆 Total collected items: ${state.collectedItems.length}');
    } else {
      print('⚠️ No more items available to collect');
    }
  }

  void resetItems() {
    print('🔄 Resetting all items...');
    state = ItemState(
      collectedItems: [],
      availableItems: itemList, // items.dart에서 가져온 itemList 사용
    );
    print(
        '✅ Items reset complete. All ${itemList.length} items are now available');
  }
}
