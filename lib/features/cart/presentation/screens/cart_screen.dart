import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:home_food/core/routes/app_routes.dart';
import 'package:home_food/core/utils/app_formatters.dart';
import 'package:home_food/core/utils/responsive.dart';
import 'package:home_food/core/widgets/app_primary_button.dart';
import 'package:home_food/core/widgets/cart_item_tile.dart';
import 'package:home_food/features/cart/controllers/cart_controller.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final couponController = TextEditingController();

  @override
  void dispose() {
    couponController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cart = Get.find<CartController>();
    final pagePadding = Responsive.pagePadding(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Your cart')),
      body: Obx(
        () => cart.items.isEmpty
            ? const Center(
                child: Text(
                  'Your cart is empty. Add a homemade dish to continue.',
                ),
              )
            : ListView(
                padding: EdgeInsets.fromLTRB(pagePadding, 0, pagePadding, 30),
                children: [
                  ...cart.items.map(
                    (item) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: CartItemTile(
                        item: item,
                        onIncrease: () => cart.updateQuantity(
                          item.food.id,
                          item.quantity + 1,
                        ),
                        onDecrease: () => cart.updateQuantity(
                          item.food.id,
                          item.quantity - 1,
                        ),
                        onRemove: () => cart.removeItem(item.food.id),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final couponField = TextField(
                        controller: couponController,
                        decoration: const InputDecoration(
                          hintText: 'Apply coupon',
                        ),
                      );
                      final applyButton = OutlinedButton(
                        onPressed: () =>
                            cart.applyCoupon(couponController.text),
                        child: const Text('Apply'),
                      );

                      if (constraints.maxWidth < 360) {
                        return Column(
                          children: [
                            couponField,
                            const SizedBox(height: 10),
                            SizedBox(
                              width: double.infinity,
                              child: applyButton,
                            ),
                          ],
                        );
                      }

                      return Row(
                        children: [
                          Expanded(child: couponField),
                          const SizedBox(width: 10),
                          applyButton,
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Column(
                      children: [
                        _PriceRow(
                          label: 'Subtotal',
                          value: AppFormatters.price(cart.subtotal),
                        ),
                        _PriceRow(
                          label: 'Delivery fee',
                          value: AppFormatters.price(cart.deliveryFee),
                        ),
                        _PriceRow(
                          label: 'Discount',
                          value: '-${AppFormatters.price(cart.discount)}',
                        ),
                        const Divider(height: 28),
                        _PriceRow(
                          label: 'Total',
                          value: AppFormatters.price(cart.total),
                          isEmphasis: true,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  AppPrimaryButton(
                    label: 'Checkout',
                    onPressed: () => Get.toNamed(AppRoutes.checkout),
                  ),
                ],
              ),
      ),
    );
  }
}

class _PriceRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isEmphasis;

  const _PriceRow({
    required this.label,
    required this.value,
    this.isEmphasis = false,
  });

  @override
  Widget build(BuildContext context) {
    final style = isEmphasis
        ? Theme.of(context).textTheme.titleMedium
        : Theme.of(context).textTheme.bodyLarge;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 280) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: style),
                const SizedBox(height: 4),
                Text(value, style: style),
              ],
            );
          }

          return Row(
            children: [
              Text(label, style: style),
              const Spacer(),
              Text(value, style: style),
            ],
          );
        },
      ),
    );
  }
}
