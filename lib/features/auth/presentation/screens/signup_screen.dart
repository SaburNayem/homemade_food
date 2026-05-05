import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:home_food/core/widgets/app_primary_button.dart';
import 'package:home_food/core/widgets/app_text_field.dart';
import 'package:home_food/features/auth/controllers/auth_controller.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
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
              'Create your account',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 24),
            AppTextField(
              controller: nameController,
              hintText: 'Full name',
              prefixIcon: Icons.person_outline,
            ),
            const SizedBox(height: 16),
            AppTextField(
              controller: emailController,
              hintText: 'Email address',
              prefixIcon: Icons.email_outlined,
            ),
            const SizedBox(height: 16),
            AppTextField(
              controller: phoneController,
              hintText: 'Phone number',
              prefixIcon: Icons.phone_outlined,
            ),
            const SizedBox(height: 16),
            AppTextField(
              controller: passwordController,
              hintText: 'Password',
              prefixIcon: Icons.lock_outline,
              obscureText: true,
            ),
            const SizedBox(height: 24),
            AppPrimaryButton(
              label: 'Sign up',
              onPressed: () {
                auth.signup(
                  name: nameController.text.isEmpty
                      ? 'New User'
                      : nameController.text,
                  email: emailController.text.isEmpty
                      ? 'new@example.com'
                      : emailController.text,
                  phone: phoneController.text.isEmpty
                      ? '+8801900000000'
                      : phoneController.text,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
