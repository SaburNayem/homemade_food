import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:home_food/core/widgets/app_primary_button.dart';
import 'package:home_food/core/widgets/app_text_field.dart';
import 'package:home_food/features/auth/controllers/auth_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

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
              'Login',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'This screen is static for now. You can continue without backend authentication.',
            ),
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
            const SizedBox(height: 20),
            AppPrimaryButton(
              label: 'Continue',
              onPressed: auth.enterApp,
            ),
          ],
        ),
      ),
    );
  }
}
