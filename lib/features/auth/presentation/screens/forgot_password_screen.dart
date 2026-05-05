import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:home_food/core/widgets/app_primary_button.dart';
import 'package:home_food/core/widgets/app_text_field.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Reset password',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 12),
            Text('Enter your email and we will send a reset link.'),
            const SizedBox(height: 24),
            AppTextField(
              controller: emailController,
              hintText: 'Email address',
              prefixIcon: Icons.email_outlined,
            ),
            const SizedBox(height: 24),
            AppPrimaryButton(
              label: 'Send reset link',
              onPressed: () {
                Get.snackbar(
                  'Reset link sent',
                  'Check your inbox for the next steps.',
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
