import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:home_food/core/controllers/app_controller.dart';
import 'package:home_food/core/models/order_model.dart';
import 'package:home_food/core/utils/app_formatters.dart';
import 'package:home_food/core/utils/responsive.dart';
import 'package:home_food/core/widgets/app_primary_button.dart';
import 'package:home_food/features/cart/controllers/cart_controller.dart';
import 'package:home_food/features/orders/controllers/order_controller.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final app = Get.find<AppController>();
    final cart = Get.find<CartController>();
    final orders = Get.find<OrderController>();
    final pagePadding = Responsive.pagePadding(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Checkout')),
      body: Obx(
        () => ListView(
          padding: EdgeInsets.all(pagePadding),
          children: [
            Text(
              'Select delivery address',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 12),
            ...app.savedAddresses.map(
              (address) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: _CheckoutChoiceCard(
                  title: address.label,
                  subtitle: address.fullAddress,
                  selected: app.selectedAddress.value?.id == address.id,
                  onTap: () => app.selectAddress(address),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Payment method',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 12),
            ...PaymentMethod.values.map(
              (method) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: _CheckoutChoiceCard(
                  title: _paymentLabel(method),
                  selected: orders.selectedPaymentMethod.value == method,
                  onTap: () => orders.setPaymentMethod(method),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Order summary',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 12),
                  ...cart.items.map(
                    (item) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          if (constraints.maxWidth < 280) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('${item.food.name} x${item.quantity}'),
                                const SizedBox(height: 4),
                                Text(AppFormatters.price(item.total)),
                              ],
                            );
                          }

                          return Row(
                            children: [
                              Expanded(
                                child: Text(
                                  '${item.food.name} x${item.quantity}',
                                ),
                              ),
                              Text(AppFormatters.price(item.total)),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                  const Divider(height: 28),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final totalText = Text(
                        AppFormatters.price(cart.total),
                        style: Theme.of(context).textTheme.titleMedium,
                      );

                      if (constraints.maxWidth < 280) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Total'),
                            const SizedBox(height: 4),
                            totalText,
                          ],
                        );
                      }

                      return Row(
                        children: [
                          const Text('Total'),
                          const Spacer(),
                          totalText,
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            AppPrimaryButton(
              label: 'Place order',
              onPressed: () => orders.placeOrder(
                app.selectedAddress.value ?? app.savedAddresses.first,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _paymentLabel(PaymentMethod method) {
    switch (method) {
      case PaymentMethod.cashOnDelivery:
        return 'Cash on delivery';
      case PaymentMethod.card:
        return 'Card';
      case PaymentMethod.mobileBanking:
        return 'Mobile banking';
    }
  }
}

class _CheckoutChoiceCard extends StatelessWidget {
  final String title;
  final String? subtitle;
  final bool selected;
  final VoidCallback onTap;

  const _CheckoutChoiceCard({
    required this.title,
    this.subtitle,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: selected ? const Color(0xFFE67E22) : Colors.transparent,
            width: 1.5,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 2),
              child: Icon(
                selected
                    ? Icons.radio_button_checked
                    : Icons.radio_button_off_outlined,
                color: selected ? const Color(0xFFE67E22) : Colors.grey,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: Theme.of(context).textTheme.titleMedium),
                  if (subtitle != null) ...[
                    const SizedBox(height: 4),
                    Text(subtitle!),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
