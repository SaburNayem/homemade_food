import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:home_food/core/widgets/section_header.dart';
import 'package:home_food/features/auth/controllers/auth_controller.dart';
import 'package:home_food/features/food/controllers/food_controller.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Get.find<AuthController>();
    final user = auth.currentUser.value;
    final foods = Get.find<FoodController>();

    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 120),
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(28),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 34,
                  backgroundColor: const Color(0xFFF6C89F),
                  child: Text(
                    user?.name.substring(0, 1) ?? 'U',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  user?.name ?? 'Guest user',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 4),
                Text(user?.phone ?? ''),
                Text(user?.email ?? ''),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const SectionHeader(title: 'Saved addresses'),
          const SizedBox(height: 8),
          ...?user?.savedAddresses.map(
            (address) => Card(
              child: ListTile(
                leading: const Icon(Icons.place_outlined),
                title: Text(address.label),
                subtitle: Text(address.fullAddress),
              ),
            ),
          ),
          const SizedBox(height: 20),
          const SectionHeader(title: 'Favorite foods'),
          const SizedBox(height: 8),
          ...foods.recommendedFoods.map(
            (food) => Card(
              child: ListTile(
                title: Text(food.name),
                subtitle: Text(food.cookName),
                trailing: Text('${food.rating} ★'),
              ),
            ),
          ),
          const SizedBox(height: 20),
          const SectionHeader(title: 'Settings'),
          const SizedBox(height: 8),
          const Card(
            child: Column(
              children: [
                ListTile(
                  leading: Icon(Icons.history),
                  title: Text('Order history'),
                ),
                Divider(height: 1),
                ListTile(
                  leading: Icon(Icons.notifications_outlined),
                  title: Text('Notification preferences'),
                ),
                Divider(height: 1),
                ListTile(
                  leading: Icon(Icons.settings_outlined),
                  title: Text('App settings'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          OutlinedButton(onPressed: auth.logout, child: const Text('Logout')),
        ],
      ),
    );
  }
}
