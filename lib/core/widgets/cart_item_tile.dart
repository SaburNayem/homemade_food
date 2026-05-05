import 'package:flutter/material.dart';

import 'package:home_food/core/models/cart_item.dart';
import 'package:home_food/core/utils/app_formatters.dart';

class CartItemTile extends StatelessWidget {
  final CartItem item;
  final VoidCallback onIncrease;
  final VoidCallback onDecrease;
  final VoidCallback onRemove;

  const CartItemTile({
    super.key,
    required this.item,
    required this.onIncrease,
    required this.onDecrease,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isCompact = constraints.maxWidth < 380;

        return Card(
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: isCompact
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const _CartThumbnail(),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.food.name,
                                  style: Theme.of(context).textTheme.titleMedium,
                                ),
                                const SizedBox(height: 4),
                                Text(item.food.cookName),
                                const SizedBox(height: 4),
                                Text(AppFormatters.price(item.total)),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: onDecrease,
                                visualDensity: VisualDensity.compact,
                                icon: const Icon(Icons.remove_circle_outline),
                              ),
                              Text(
                                '${item.quantity}',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              IconButton(
                                onPressed: onIncrease,
                                visualDensity: VisualDensity.compact,
                                icon: const Icon(Icons.add_circle_outline),
                              ),
                            ],
                          ),
                          TextButton(
                            onPressed: onRemove,
                            child: const Text('Remove'),
                          ),
                        ],
                      ),
                    ],
                  )
                : Row(
                    children: [
                      const _CartThumbnail(),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.food.name,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            const SizedBox(height: 4),
                            Text(item.food.cookName),
                            const SizedBox(height: 4),
                            Text(AppFormatters.price(item.total)),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: onDecrease,
                                icon: const Icon(Icons.remove_circle_outline),
                              ),
                              Text(
                                '${item.quantity}',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              IconButton(
                                onPressed: onIncrease,
                                icon: const Icon(Icons.add_circle_outline),
                              ),
                            ],
                          ),
                          TextButton(
                            onPressed: onRemove,
                            child: const Text('Remove'),
                          ),
                        ],
                      ),
                    ],
                  ),
          ),
        );
      },
    );
  }
}

class _CartThumbnail extends StatelessWidget {
  const _CartThumbnail();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72,
      width: 72,
      decoration: BoxDecoration(
        color: const Color(0xFFFFF2DF),
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Icon(
        Icons.lunch_dining_outlined,
        color: Color(0xFFE67E22),
      ),
    );
  }
}
