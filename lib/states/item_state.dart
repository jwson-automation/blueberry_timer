import 'package:blueberry_timer/models/item_model.dart';

/// ItemService의 상태를 관리하는 클래스
class ItemState {
  /// 수집된 아이템 목록
  final List<ItemModel> inventory;

  /// 장착된 아이템 (3개 슬롯)
  final List<ItemModel?> equippedItems;

  const ItemState({
    this.inventory = const [],
    this.equippedItems = const [null, null, null],
  });

  /// 상태 복사본 생성
  ItemState copyWith({
    List<ItemModel>? inventory,
    List<ItemModel?>? equippedItems,
  }) {
    return ItemState(
      inventory: inventory ?? this.inventory,
      equippedItems: equippedItems ?? this.equippedItems,
    );
  }
}
