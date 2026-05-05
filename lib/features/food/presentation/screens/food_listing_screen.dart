import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:home_food/core/controllers/app_controller.dart';
import 'package:home_food/core/routes/app_routes.dart';
import 'package:home_food/core/widgets/category_chip.dart';
import 'package:home_food/core/widgets/food_card.dart';
import 'package:home_food/features/cart/controllers/cart_controller.dart';
import 'package:home_food/features/food/controllers/food_controller.dart';

class FoodListingScreen extends StatelessWidget {
  const FoodListingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final app = Get.find<AppController>();
    final foodController = Get.find<FoodController>();
    final cart = Get.find<CartController>();

    return Scaffold(
      appBar: AppBar(title: const Text('Browse homemade food')),
      body: Obx(
        () => ListView(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 120),
          children: [
            TextField(
              onChanged: app.updateSearch,
              decoration: const InputDecoration(
                hintText: 'Search homemade food',
                prefixIcon: Icon(Icons.search),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 46,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (_, index) {
                  final category = app.categories[index];
                  return CategoryChip(
                    label: category,
                    selected: app.selectedCategory.value == category,
                    onTap: () => app.selectCategory(category),
                  );
                },
                separatorBuilder: (_, index) => const SizedBox(width: 10),
                itemCount: app.categories.length,
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Filters',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      FilterChip(
                        label: const Text('Nearby'),
                        selected: app.onlyNearby.value,
                        onSelected: (value) => app.onlyNearby.value = value,
                      ),
                      FilterChip(
                        label: const Text('Vegetarian'),
                        selected: app.vegetarianOnly.value,
                        onSelected: (value) => app.vegetarianOnly.value = value,
                      ),
                      ChoiceChip(
                        label: const Text('Mild'),
                        selected: app.selectedSpice.value == 'Mild',
                        onSelected: (_) => app.selectedSpice.value = 'Mild',
                      ),
                      ChoiceChip(
                        label: const Text('Medium'),
                        selected: app.selectedSpice.value == 'Medium',
                        onSelected: (_) => app.selectedSpice.value = 'Medium',
                      ),
                      ChoiceChip(
                        label: const Text('Spicy'),
                        selected: app.selectedSpice.value == 'Spicy',
                        onSelected: (_) => app.selectedSpice.value = 'Spicy',
                      ),
                      OutlinedButton(
                        onPressed: app.resetFilters,
                        child: const Text('Reset'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Minimum rating: ${app.minRating.value.toStringAsFixed(1)}',
                  ),
                  Slider(
                    value: app.minRating.value,
                    min: 0,
                    max: 5,
                    divisions: 10,
                    label: app.minRating.value.toStringAsFixed(1),
                    onChanged: (value) => app.minRating.value = value,
                  ),
                  Text('Max price: \$${app.maxPrice.value.toStringAsFixed(0)}'),
                  Slider(
                    value: app.maxPrice.value,
                    min: 5,
                    max: 20,
                    divisions: 15,
                    label: app.maxPrice.value.toStringAsFixed(0),
                    onChanged: (value) => app.maxPrice.value = value,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            Text(
              '${foodController.filteredFoods.length} foods available near your location',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            ...foodController.filteredFoods.map(
              (food) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: FoodCard(
                  food: food,
                  onTap: () =>
                      Get.toNamed(AppRoutes.foodDetails, arguments: food.id),
                  onAdd: () => cart.addToCart(food),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
