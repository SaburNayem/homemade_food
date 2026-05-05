import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:home_food/core/controllers/app_controller.dart';
import 'package:home_food/core/routes/app_routes.dart';
import 'package:home_food/core/widgets/category_chip.dart';
import 'package:home_food/core/widgets/cook_card.dart';
import 'package:home_food/core/widgets/food_card.dart';
import 'package:home_food/core/widgets/section_header.dart';
import 'package:home_food/features/cart/controllers/cart_controller.dart';
import 'package:home_food/features/cart/presentation/screens/cart_screen.dart';
import 'package:home_food/features/food/controllers/food_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final app = Get.find<AppController>();
    final foods = Get.find<FoodController>();
    final cart = Get.find<CartController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeMade Bites'),
        actions: [
          IconButton(
            onPressed: () => Get.toNamed(AppRoutes.location),
            icon: const Icon(Icons.location_on_outlined),
          ),
          IconButton(
            onPressed: () => Get.to(() => const CartScreen()),
            icon: const Icon(Icons.shopping_cart_outlined),
          ),
        ],
      ),
      body: Obx(
        () => SafeArea(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 120),
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFE67E22), Color(0xFFF3B55D)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(28),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Fresh from nearby kitchens',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Order today’s homemade meals or send a custom request for something special.',
                      style: TextStyle(color: Colors.white),
                    ),
                    const SizedBox(height: 14),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: [
                        ElevatedButton(
                          onPressed: () => app.selectTab(1),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: const Color(0xFFE67E22),
                          ),
                          child: const Text('Browse foods'),
                        ),
                        OutlinedButton(
                          onPressed: () => app.selectTab(2),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.white,
                            side: const BorderSide(color: Colors.white70),
                          ),
                          child: const Text('Request custom meal'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(28),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.place_outlined, color: Color(0xFFE67E22)),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Delivering to'),
                          Text(
                            app.selectedAddress.value?.fullAddress ??
                                'Set your location',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              TextField(
                onChanged: app.updateSearch,
                decoration: const InputDecoration(
                  hintText: 'Search homemade food',
                  prefixIcon: Icon(Icons.search),
                ),
              ),
              const SizedBox(height: 24),
              const SectionHeader(title: 'Food categories'),
              const SizedBox(height: 12),
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
              const SizedBox(height: 24),
              SectionHeader(
                title: 'Popular homemade foods',
                actionLabel: 'See all',
                onTap: () => app.selectTab(1),
              ),
              const SizedBox(height: 12),
              ...foods.popularFoods
                  .take(3)
                  .map(
                    (food) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: FoodCard(
                        food: food,
                        onTap: () => Get.toNamed(
                          AppRoutes.foodDetails,
                          arguments: food.id,
                        ),
                        onAdd: () => cart.addToCart(food),
                      ),
                    ),
                  ),
              const SizedBox(height: 16),
              const SectionHeader(title: 'Nearby home cooks'),
              const SizedBox(height: 12),
              SizedBox(
                height: 230,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: foods.nearbyCooks
                      .map((cook) => CookCard(cook: cook))
                      .toList(),
                ),
              ),
              const SizedBox(height: 16),
              const SectionHeader(title: 'Recommended for you'),
              const SizedBox(height: 12),
              ...foods.recommendedFoods.map(
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
      ),
    );
  }
}
