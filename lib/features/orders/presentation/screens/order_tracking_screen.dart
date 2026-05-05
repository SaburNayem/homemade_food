import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:home_food/core/utils/app_formatters.dart';
import 'package:home_food/core/widgets/status_timeline.dart';
import 'package:home_food/features/orders/controllers/order_controller.dart';

class OrderTrackingScreen extends StatelessWidget {
  const OrderTrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final orderId = Get.arguments as String?;
    final controller = Get.find<OrderController>();
    final order = controller.getOrderById(orderId ?? 'order1');

    return Scaffold(
      appBar: AppBar(title: const Text('Track order')),
      body: order == null
          ? const Center(child: Text('Order not found'))
          : Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Order #${order.id}',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Estimated delivery: ${AppFormatters.dateTime(order.estimatedDeliveryTime)}',
                  ),
                  const SizedBox(height: 8),
                  Text('Delivering to: ${order.address.fullAddress}'),
                  const SizedBox(height: 24),
                  Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: StatusTimeline(status: order.status),
                  ),
                ],
              ),
            ),
    );
  }
}
