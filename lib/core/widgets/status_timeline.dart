import 'package:flutter/material.dart';

import 'package:home_food/core/models/order_model.dart';

class StatusTimeline extends StatelessWidget {
  final OrderStatus status;

  const StatusTimeline({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    const steps = [
      OrderStatus.placed,
      OrderStatus.accepted,
      OrderStatus.cooking,
      OrderStatus.pickedUp,
      OrderStatus.delivered,
    ];

    return Column(
      children: steps.map((step) {
        final isDone = step.index <= status.index;
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                CircleAvatar(
                  radius: 12,
                  backgroundColor: isDone
                      ? const Color(0xFFE67E22)
                      : Colors.white,
                  child: Icon(
                    isDone ? Icons.check : Icons.circle_outlined,
                    size: 14,
                    color: isDone ? Colors.white : Colors.grey,
                  ),
                ),
                if (step != steps.last)
                  Container(
                    width: 2,
                    height: 36,
                    color: isDone
                        ? const Color(0xFFE67E22)
                        : Colors.grey.shade300,
                  ),
              ],
            ),
            const SizedBox(width: 12),
            Padding(
              padding: const EdgeInsets.only(top: 2),
              child: Text(
                _label(step),
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ],
        );
      }).toList(),
    );
  }

  String _label(OrderStatus status) {
    switch (status) {
      case OrderStatus.placed:
        return 'Order placed';
      case OrderStatus.accepted:
        return 'Home cook accepted';
      case OrderStatus.cooking:
        return 'Cooking';
      case OrderStatus.pickedUp:
        return 'Picked up';
      case OrderStatus.delivered:
        return 'Delivered';
    }
  }
}
