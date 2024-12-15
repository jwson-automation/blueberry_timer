import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../features/item_service.dart';
import '../../dialogs/inventory_dialog.dart';

class EquippedItems extends ConsumerWidget {
  const EquippedItems({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SizedBox(
        height: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(3, (index) {
            final equippedItems = ref.watch(itemServiceProvider).equippedItems;
            final item = equippedItems[index];

            return InkWell(
              onTap: () => InventoryDialog.show(context, index),
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.grey[850],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: item != null
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            item.imagePath,
                            width: 32,
                            height: 32,
                            color: Colors.white,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            item.name,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      )
                    : const Icon(
                        Icons.add,
                        color: Colors.white54,
                      ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
