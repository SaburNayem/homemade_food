import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:home_food/core/controllers/app_controller.dart';
import 'package:home_food/features/cart/presentation/screens/cart_screen.dart';
import 'package:home_food/features/custom_food/presentation/screens/custom_food_request_screen.dart';
import 'package:home_food/features/food/presentation/screens/food_listing_screen.dart';
import 'package:home_food/features/home/presentation/screens/home_screen.dart';
import 'package:home_food/features/orders/presentation/screens/orders_screen.dart';
import 'package:home_food/features/profile/presentation/screens/profile_screen.dart';

class CustomerShell extends StatelessWidget {
  const CustomerShell({super.key});

  @override
  Widget build(BuildContext context) {
    final app = Get.find<AppController>();

    return Obx(
      () => LayoutBuilder(
        builder: (context, constraints) {
          final isCompact = constraints.maxWidth < 380;
          final pages = [
            const HomeScreen(),
            const FoodListingScreen(),
            const CustomFoodRequestScreen(),
            const OrdersScreen(),
            const ProfileScreen(),
          ];

          return Scaffold(
            body: pages[app.selectedBottomTab.value],
            floatingActionButton: isCompact
                ? FloatingActionButton(
                    onPressed: () => Get.to(() => const CartScreen()),
                    backgroundColor: const Color(0xFFE67E22),
                    foregroundColor: Colors.white,
                    child: const Icon(Icons.shopping_bag_outlined),
                  )
                : FloatingActionButton.extended(
                    onPressed: () => Get.to(() => const CartScreen()),
                    backgroundColor: const Color(0xFFE67E22),
                    foregroundColor: Colors.white,
                    label: const Text('Cart'),
                    icon: const Icon(Icons.shopping_bag_outlined),
                  ),
            bottomNavigationBar: NavigationBar(
              height: isCompact ? 68 : 76,
              labelBehavior: isCompact
                  ? NavigationDestinationLabelBehavior.onlyShowSelected
                  : NavigationDestinationLabelBehavior.alwaysShow,
              selectedIndex: app.selectedBottomTab.value,
              onDestinationSelected: app.selectTab,
              destinations: const [
                NavigationDestination(
                  icon: Icon(Icons.home_outlined),
                  label: 'Home',
                ),
                NavigationDestination(
                  icon: Icon(Icons.search),
                  label: 'Browse',
                ),
                NavigationDestination(
                  icon: Icon(Icons.receipt_long_outlined),
                  label: 'Custom',
                ),
                NavigationDestination(
                  icon: Icon(Icons.delivery_dining_outlined),
                  label: 'Orders',
                ),
                NavigationDestination(
                  icon: Icon(Icons.person_outline),
                  label: 'Profile',
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
