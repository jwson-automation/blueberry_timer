import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../features/item_service.dart';
import 'item_info_dialog.dart';

class InventoryDialog extends ConsumerWidget {
  final int slotIndex;

  const InventoryDialog({
    super.key,
    required this.slotIndex,
  });

  static void show(BuildContext context, int slotIndex) {
    showDialog(
      context: context,
      builder: (context) => InventoryDialog(slotIndex: slotIndex),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final inventory = ref.watch(itemServiceProvider).inventory;

    return Dialog(
      backgroundColor: Colors.grey[900],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  '인벤토리',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const Divider(color: Colors.white24),
            const SizedBox(height: 8),
            ConstrainedBox(
              constraints: const BoxConstraints(
                maxHeight: 300,
              ),
              child: GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 1, // 정사각형 그리드
                ),
                itemCount: inventory.length,
                itemBuilder: (context, index) {
                  final item = inventory[index];
                  return InkWell(
                    onTap: () {
                      ref.read(itemServiceProvider.notifier).equipItem(item, slotIndex);
                      Navigator.pop(context);
                    },
                    child: Stack(
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: Colors.grey[850],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                item.imagePath,
                                width: 32,
                                height: 32,
                                color: Colors.white,
                              ),
                              const SizedBox(height: 4),
                              SizedBox(
                                width: 60,
                                child: Text(
                                  item.name,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 8,
                                  ),
                                  textAlign: TextAlign.center,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Text(
                                'x${item.quantity}',
                                style: TextStyle(
                                  color: Colors.grey[400],
                                  fontSize: 8,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          top: 4,
                          right: 4,
                          child: InkWell(
                            onTap: () => ItemInfoDialog.show(context, item),
                            child: Container(
                              width: 16,
                              height: 16,
                              decoration: const BoxDecoration(
                                color: Colors.white24,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.info_outline,
                                size: 12,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
