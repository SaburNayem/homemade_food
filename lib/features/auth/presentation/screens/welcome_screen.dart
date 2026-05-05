import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:home_food/core/routes/app_routes.dart';
import 'package:home_food/core/widgets/app_primary_button.dart';
import 'package:home_food/features/auth/controllers/auth_controller.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Get.find<AuthController>();

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            const SizedBox(height: 12),
            Container(
              height: 280,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFFFE0B2), Color(0xFFF3B55D)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(32),
              ),
              child: const Center(
                child: Icon(
                  Icons.restaurant_menu_rounded,
                  size: 92,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 28),
            Text(
              'HomeMade Bites',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 12),
            Text(
              'Warm homemade meals from trusted local cooks, delivered to your door.',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 32),
            AppPrimaryButton(
              label: 'Login',
              onPressed: () => Get.toNamed(AppRoutes.login),
            ),
            const SizedBox(height: 12),
            OutlinedButton(
              onPressed: () => Get.toNamed(AppRoutes.signup),
              child: const Text('Create account'),
            ),
            const SizedBox(height: 12),
            TextButton(
              onPressed: auth.enterApp,
              child: const Text('Continue as guest'),
            ),
          ],
        ),
      ),
    );
  }
}
