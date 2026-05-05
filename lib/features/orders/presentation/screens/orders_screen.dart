import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:home_food/core/routes/app_routes.dart';
import 'package:home_food/core/utils/app_formatters.dart';
import 'package:home_food/features/orders/controllers/order_controller.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final orders = Get.find<OrderController>();

    return Scaffold(
      appBar: AppBar(title: const Text('Your orders')),
      body: Obx(
        () => ListView(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 120),
          children: orders.orders.map((order) {
            return Card(
              child: ListTile(
                title: Text('Order #${order.id}'),
                subtitle: Text(
                  '${order.items.length} item(s) • ETA ${AppFormatters.dateTime(order.estimatedDeliveryTime)}',
                ),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(order.status.name),
                    TextButton(
                      onPressed: () => Get.toNamed(
                        AppRoutes.orderTracking,
                        arguments: order.id,
                      ),
                      child: const Text('Track'),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
