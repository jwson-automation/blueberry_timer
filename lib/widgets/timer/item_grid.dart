import 'package:blueberry_timer/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../features/item_service.dart';
import '../../widgets/item_dialog.dart';

/// 아이템 그리드 위젯
class ItemGrid extends ConsumerWidget {
  const ItemGrid({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final itemState = ref.watch(itemServiceProvider);

    return Column(
      children: [
        Text(
          l10n.timerCollectedItems,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 5,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: 1,
          ),
          itemCount: 10, // Always show 10 slots
          itemBuilder: (context, index) {
            final item = index < itemState.collectedItems.length
                ? itemState.collectedItems[index]
                : null;

            return GestureDetector(
              onTap: item != null
                  ? () {
                      showDialog(
                        context: context,
                        builder: (context) => ItemDialog(item: item),
                      );
                    }
                  : null,
              child: Container(
                decoration: BoxDecoration(
                  color: item?.backgroundColor ?? Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: item != null
                        ? Colors.green.shade300
                        : Colors.grey.shade400,
                    width: 2,
                  ),
                ),
                child: item != null
                    ? Stack(
                        children: [
                          Center(
                            child: SvgPicture.asset(
                              item.imagePath,
                              width: 50,
                              height: 50,
                            ),
                          ),
                          if (item.quantity > 1)
                            Positioned(
                              right: 4,
                              bottom: 4,
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: Colors.black54,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  '${item.quantity}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      )
                    : const Center(
                        child: Icon(
                          Icons.add_circle_outline,
                          color: Colors.grey,
                        ),
                      ),
              ),
            );
          },
        ),
        if (itemState.collectedItems.isEmpty)
          Center(
            child: Text(
              l10n.timerNoItems,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 16,
              ),
            ),
          ),
      ],
    );
  }
}
