import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:home_food/core/routes/app_routes.dart';
import 'package:home_food/core/utils/app_formatters.dart';
import 'package:home_food/core/widgets/app_primary_button.dart';
import 'package:home_food/features/cart/controllers/cart_controller.dart';
import 'package:home_food/features/food/controllers/food_controller.dart';

class FoodDetailsScreen extends StatefulWidget {
  const FoodDetailsScreen({super.key});

  @override
  State<FoodDetailsScreen> createState() => _FoodDetailsScreenState();
}

class _FoodDetailsScreenState extends State<FoodDetailsScreen> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    final foodId = Get.arguments as String?;
    final food = Get.find<FoodController>().getFoodById(foodId ?? 'food1');
    final cart = Get.find<CartController>();

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFFFFE0B2), Color(0xFFE67E22)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: const Center(
                  child: Icon(
                    Icons.ramen_dining_outlined,
                    size: 96,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    food.name,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${food.cookName} | ${food.rating} star | ${food.deliveryTime}',
                  ),
                  const SizedBox(height: 18),
                  Text(food.description),
                  const SizedBox(height: 20),
                  Text(
                    'Ingredients',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: food.ingredients
                        .map((item) => Chip(label: Text(item)))
                        .toList(),
                  ),
                  const SizedBox(height: 20),
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
                          'Home cook details',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 8),
                        Text('Cook: ${food.cookName}'),
                        Text('Delivery time: ${food.deliveryTime}'),
                        Text('Distance: ${food.distanceKm} km'),
                        Text('Spice level: ${food.spiceLevel}'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Rating & reviews',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 12),
                  ...food.reviews.map(
                    (review) => Card(
                      child: ListTile(
                        title: Text(review.userName),
                        subtitle: Text(review.comment),
                        trailing: Text('${review.rating} star'),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Text(
                        'Quantity',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: quantity > 1
                                  ? () => setState(() => quantity--)
                                  : null,
                              icon: const Icon(Icons.remove_circle_outline),
                            ),
                            Text(
                              '$quantity',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            IconButton(
                              onPressed: () => setState(() => quantity++),
                              icon: const Icon(Icons.add_circle_outline),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Total: ${AppFormatters.price(food.price * quantity)}',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 24),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final addToCartButton = OutlinedButton(
                        onPressed: () =>
                            cart.addToCart(food, quantity: quantity),
                        child: const Text('Add to cart'),
                      );
                      final buyNowButton = AppPrimaryButton(
                        label: 'Buy now',
                        onPressed: () {
                          cart.addToCart(food, quantity: quantity);
                          Get.toNamed(AppRoutes.checkout);
                        },
                      );

                      if (constraints.maxWidth > 420) {
                        return Row(
                          children: [
                            Expanded(child: addToCartButton),
                            const SizedBox(width: 12),
                            Expanded(child: buyNowButton),
                          ],
                        );
                      }

                      return Column(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: addToCartButton,
                          ),
                          const SizedBox(height: 12),
                          SizedBox(width: double.infinity, child: buyNowButton),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
