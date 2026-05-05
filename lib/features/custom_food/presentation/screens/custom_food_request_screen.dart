import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:home_food/core/models/custom_food_request.dart';
import 'package:home_food/core/utils/app_formatters.dart';
import 'package:home_food/core/widgets/app_primary_button.dart';
import 'package:home_food/core/widgets/app_text_field.dart';
import 'package:home_food/features/orders/controllers/order_controller.dart';

class CustomFoodRequestScreen extends StatefulWidget {
  const CustomFoodRequestScreen({super.key});

  @override
  State<CustomFoodRequestScreen> createState() =>
      _CustomFoodRequestScreenState();
}

class _CustomFoodRequestScreenState extends State<CustomFoodRequestScreen> {
  final foodNameController = TextEditingController();
  final descriptionController = TextEditingController();
  final instructionController = TextEditingController();
  String spiceLevel = 'Medium';
  int quantity = 2;
  DateTime deliveryDateTime = DateTime.now().add(const Duration(days: 1));

  @override
  void dispose() {
    foodNameController.dispose();
    descriptionController.dispose();
    instructionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final orders = Get.find<OrderController>();

    return Scaffold(
      appBar: AppBar(title: const Text('Request Custom Food')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 120),
        children: [
          Text(
            'Tell nearby cooks exactly what you want.',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 20),
          AppTextField(
            controller: foodNameController,
            hintText: 'Food name',
            prefixIcon: Icons.fastfood_outlined,
          ),
          const SizedBox(height: 16),
          AppTextField(
            controller: descriptionController,
            hintText: 'How should it be cooked?',
            prefixIcon: Icons.menu_book_outlined,
            maxLines: 4,
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            initialValue: spiceLevel,
            items: const ['Mild', 'Medium', 'Spicy']
                .map(
                  (value) => DropdownMenuItem(value: value, child: Text(value)),
                )
                .toList(),
            onChanged: (value) =>
                setState(() => spiceLevel = value ?? 'Medium'),
            decoration: const InputDecoration(labelText: 'Spice level'),
          ),
          const SizedBox(height: 16),
          LayoutBuilder(
            builder: (context, constraints) {
              final quantityField = DropdownButtonFormField<int>(
                initialValue: quantity,
                items: List.generate(
                  10,
                  (index) => DropdownMenuItem(
                    value: index + 1,
                    child: Text('${index + 1} serving(s)'),
                  ),
                ),
                onChanged: (value) => setState(() => quantity = value ?? 1),
                decoration: const InputDecoration(labelText: 'Quantity'),
              );

              final scheduleButton = OutlinedButton.icon(
                onPressed: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: deliveryDateTime,
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 60)),
                  );
                  if (date == null || !context.mounted) return;
                  final time = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.fromDateTime(deliveryDateTime),
                  );
                  if (time == null || !context.mounted) return;
                  setState(() {
                    deliveryDateTime = DateTime(
                      date.year,
                      date.month,
                      date.day,
                      time.hour,
                      time.minute,
                    );
                  });
                },
                icon: const Icon(Icons.schedule_outlined),
                label: Text(AppFormatters.dateTime(deliveryDateTime)),
              );

              if (constraints.maxWidth > 560) {
                return Row(
                  children: [
                    Expanded(child: quantityField),
                    const SizedBox(width: 12),
                    Expanded(child: scheduleButton),
                  ],
                );
              }

              return Column(
                children: [
                  quantityField,
                  const SizedBox(height: 12),
                  SizedBox(width: double.infinity, child: scheduleButton),
                ],
              );
            },
          ),
          const SizedBox(height: 16),
          AppTextField(
            controller: instructionController,
            hintText: 'Special instructions',
            prefixIcon: Icons.note_alt_outlined,
            maxLines: 3,
          ),
          const SizedBox(height: 16),
          OutlinedButton.icon(
            onPressed: () {
              Get.snackbar(
                'Reference image',
                'This demo keeps the upload action ready for Firebase Storage later.',
              );
            },
            icon: const Icon(Icons.image_outlined),
            label: const Text('Upload reference image'),
          ),
          const SizedBox(height: 24),
          AppPrimaryButton(
            label: 'Submit request',
            onPressed: () {
              final request = CustomFoodRequest(
                id: 'req${orders.customRequests.length + 1}',
                foodName: foodNameController.text.isEmpty
                    ? 'Custom homemade meal'
                    : foodNameController.text,
                description: descriptionController.text.isEmpty
                    ? 'Prepared to customer preference.'
                    : descriptionController.text,
                spiceLevel: spiceLevel,
                quantity: quantity,
                deliveryDateTime: deliveryDateTime,
                specialInstructions: instructionController.text,
                referenceImageUrl: null,
                status: 'Pending',
              );
              orders.submitCustomRequest(request);
            },
          ),
          const SizedBox(height: 24),
          Text(
            'Recent requests',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 12),
          Obx(
            () => Column(
              children: orders.customRequests.map((request) {
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          request.foodName,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 6),
                        Text(
                          '${request.spiceLevel} spice | ${request.quantity} servings | ${AppFormatters.dateTime(request.deliveryDateTime)}',
                        ),
                        const SizedBox(height: 8),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            request.status,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
