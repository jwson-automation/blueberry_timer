import 'dart:math';
import 'package:blueberry_timer/models/item_model.dart';
import 'package:blueberry_timer/states/item_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/**
 * 아이템 관리 서비스입니다.
 *
 * 이 서비스는 다음 기능들을 제공합니다:
 * - 랜덤 아이템 수집
 * - 아이템 인벤토리 관리
 * - 아이템 사용 및 효과 적용
 *
 * 아이템은 공부 시간이 끝날 때마다 랜덤으로 획득할 수 있으며,
 * 각 아이템은 고유한 효과를 가지고 있습니다.
 */

/// 앱 전체에서 사용되는 네비게이터 키
final navigatorKey = GlobalKey<NavigatorState>();

/// ItemService의 전역 Provider
final itemServiceProvider =
    StateNotifierProvider<ItemService, ItemState>((ref) {
  return ItemService();
});

/// 아이템 관리를 담당하는 서비스
class ItemService extends StateNotifier<ItemState> {
  ItemService() : super(ItemState());

  /// 랜덤 아이템 수집
  ///
  /// 성공 시 아이템 이름을 반환하고, 실패 시 null 반환
  String? collectRandomItem() {
    final random = Random();
    final randomIndex = random.nextInt(itemList.length);
    final collectedItem = itemList[randomIndex];

    // 이미 수집된 아이템인지 확인하고 수량을 증가시킵니다
    final updatedInventory = List<ItemModel>.from(state.inventory);
    final existingItemIndex =
        updatedInventory.indexWhere((item) => item.id == collectedItem.id);

    if (existingItemIndex != -1) {
      // 이미 있는 아이템이면 수량을 증가시킨 새 아이템으로 교체
      final existingItem = updatedInventory[existingItemIndex];
      updatedInventory[existingItemIndex] =
          existingItem.copyWith(quantity: existingItem.quantity + 1);

      state = ItemState(
        inventory: updatedInventory,
        equippedItems: state.equippedItems,
      );

      return '✨ 아이템 수량이 증가했습니다!';
    } else {
      // 새로운 아이템이면 추가
      updatedInventory.add(collectedItem);

      state = ItemState(
        inventory: updatedInventory,
        equippedItems: state.equippedItems,
      );

      return '🎁 새로운 아이템을 획득했습니다: ${collectedItem.name}';
    }
  }

  /// 아이템 장착
  void equipItem(ItemModel item, int slotIndex) {
    if (slotIndex < 0 || slotIndex >= 3) return;

    final newEquippedItems = List<ItemModel?>.from(state.equippedItems);
    newEquippedItems[slotIndex] = item;

    state = state.copyWith(
      equippedItems: newEquippedItems,
    );
  }

  /// 아이템 장착 해제
  void unequipItem(int slotIndex) {
    if (slotIndex < 0 || slotIndex >= 3) return;

    final newEquippedItems = List<ItemModel?>.from(state.equippedItems);
    newEquippedItems[slotIndex] = null;

    state = state.copyWith(
      equippedItems: newEquippedItems,
    );
  }

  /// 모든 아이템 초기화
  String resetItems() {
    state = ItemState(
      inventory: [],
      equippedItems: [null, null, null],
    );
    return '✅ 아이템이 초기화되었습니다. 총 ${itemList.length}개의 아이템을 수집할 수 있습니다.';
  }
}
