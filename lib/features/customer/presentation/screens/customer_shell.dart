import 'package:flutter/material.dart';
import 'package:fluid_bottom_nav_bar/fluid_bottom_nav_bar.dart';
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
    return GetBuilder<AppController>(
      builder: (app) => LayoutBuilder(
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
            extendBody: true,
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
            bottomNavigationBar: SafeArea(
              top: false,
              child: FluidNavBar(
                defaultIndex: app.selectedBottomTab.value,
                onChange: app.selectTab,
                style: const FluidNavBarStyle(
                  barBackgroundColor: Colors.white,
                  iconBackgroundColor: Color(0xFFE67E22),
                  iconSelectedForegroundColor: Colors.white,
                  iconUnselectedForegroundColor: Color(0xFF9A9A9A),
                ),
                icons: [
                  FluidNavBarIcon(
                    icon: Icons.home_outlined,
                    backgroundColor: Color(0xFFE67E22),
                    extras: {'label': 'Home'},
                  ),
                  FluidNavBarIcon(
                    icon: Icons.search,
                    backgroundColor: Color(0xFFE67E22),
                    extras: {'label': 'Browse'},
                  ),
                  FluidNavBarIcon(
                    icon: Icons.receipt_long_outlined,
                    backgroundColor: Color(0xFFE67E22),
                    extras: {'label': 'Custom'},
                  ),
                  FluidNavBarIcon(
                    icon: Icons.delivery_dining_outlined,
                    backgroundColor: Color(0xFFE67E22),
                    extras: {'label': 'Orders'},
                  ),
                  FluidNavBarIcon(
                    icon: Icons.person_outline,
                    backgroundColor: Color(0xFFE67E22),
                    extras: {'label': 'Profile'},
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
