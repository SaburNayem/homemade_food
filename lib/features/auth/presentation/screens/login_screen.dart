import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:home_food/core/routes/app_routes.dart';
import 'package:home_food/core/widgets/app_primary_button.dart';
import 'package:home_food/core/widgets/app_text_field.dart';
import 'package:home_food/features/auth/controllers/auth_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController(text: 'nadia@example.com');
  final passwordController = TextEditingController(text: '123456');

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final auth = Get.find<AuthController>();

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            Text(
              'Welcome back',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            Text('Login to order homemade food around you.'),
            const SizedBox(height: 24),
            AppTextField(
              controller: emailController,
              hintText: 'Email address',
              prefixIcon: Icons.email_outlined,
            ),
            const SizedBox(height: 16),
            AppTextField(
              controller: passwordController,
              hintText: 'Password',
              prefixIcon: Icons.lock_outline,
              obscureText: true,
            ),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () => Get.toNamed(AppRoutes.forgotPassword),
                child: const Text('Forgot password?'),
              ),
            ),
            const SizedBox(height: 16),
            AppPrimaryButton(
              label: 'Login now',
              onPressed: () {
                auth.login(
                  email: emailController.text,
                  password: passwordController.text,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
