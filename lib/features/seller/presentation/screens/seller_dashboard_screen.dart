import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:home_food/core/models/order_model.dart';
import 'package:home_food/core/utils/app_formatters.dart';
import 'package:home_food/core/widgets/app_primary_button.dart';
import 'package:home_food/core/widgets/app_text_field.dart';
import 'package:home_food/features/auth/controllers/auth_controller.dart';
import 'package:home_food/features/seller/controllers/seller_controller.dart';

class SellerDashboardScreen extends StatefulWidget {
  const SellerDashboardScreen({super.key});

  @override
  State<SellerDashboardScreen> createState() => _SellerDashboardScreenState();
}

class _SellerDashboardScreenState extends State<SellerDashboardScreen> {
  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final descriptionController = TextEditingController();
  final ingredientsController = TextEditingController();
  final quantityController = TextEditingController(text: '10');

  @override
  void dispose() {
    nameController.dispose();
    priceController.dispose();
    descriptionController.dispose();
    ingredientsController.dispose();
    quantityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final seller = Get.find<SellerController>();
    final auth = Get.find<AuthController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Seller dashboard'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: TextButton(
              onPressed: auth.logout,
              child: const Text('Logout'),
            ),
          ),
        ],
      ),
      body: Obx(
        () => ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(28),
              ),
              child: Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  _DashboardStat(
                    label: 'Menu items',
                    value: '${seller.sellerFoods.length}',
                  ),
                  _DashboardStat(
                    label: 'Orders',
                    value: '${seller.sellerOrders.length}',
                  ),
                  _DashboardStat(
                    label: 'Custom requests',
                    value: '${seller.customRequests.length}',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF6EA),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Kitchen control',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Track menu, custom requests, and active orders from one place.',
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: const [
                      Chip(label: Text('Live menu')),
                      Chip(label: Text('Requests inbox')),
                      Chip(label: Text('Order updates')),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Add food item',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 12),
            AppTextField(controller: nameController, hintText: 'Food name'),
            const SizedBox(height: 12),
            AppTextField(
              controller: priceController,
              hintText: 'Price',
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 12),
            AppTextField(
              controller: descriptionController,
              hintText: 'Description',
              maxLines: 3,
            ),
            const SizedBox(height: 12),
            AppTextField(
              controller: ingredientsController,
              hintText: 'Ingredients separated by comma',
              maxLines: 2,
            ),
            const SizedBox(height: 12),
            AppTextField(
              controller: quantityController,
              hintText: 'Available quantity',
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              onPressed: () {
                Get.snackbar(
                  'Image upload',
                  'Hook this button to Firebase Storage later.',
                );
              },
              icon: const Icon(Icons.cloud_upload_outlined),
              label: const Text('Upload food image'),
            ),
            const SizedBox(height: 12),
            AppPrimaryButton(
              label: 'Add item',
              onPressed: () {
                seller.addFoodItem(
                  name: nameController.text.isEmpty
                      ? 'New homemade special'
                      : nameController.text,
                  price: double.tryParse(priceController.text) ?? 11,
                  description: descriptionController.text.isEmpty
                      ? 'Freshly prepared homemade dish.'
                      : descriptionController.text,
                  ingredients: ingredientsController.text.isEmpty
                      ? 'Rice, spice, care'
                      : ingredientsController.text,
                  availableQuantity:
                      int.tryParse(quantityController.text) ?? 10,
                );
              },
            ),
            const SizedBox(height: 20),
            Text('Manage menu', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 12),
            ...seller.sellerFoods.map(
              (food) => Card(
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(food.imageUrl),
                  ),
                  title: Text(food.name),
                  subtitle: Text(
                    '${AppFormatters.price(food.price)} | ${food.description}',
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Custom food requests',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 12),
            ...seller.customRequests.map(
              (request) => Card(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        request.foodName,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 4),
                      Text(request.description),
                      const SizedBox(height: 4),
                      Text(
                        '${request.quantity} servings | ${request.spiceLevel} | ${AppFormatters.dateTime(request.deliveryDateTime)}',
                      ),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: [
                          OutlinedButton(
                            onPressed: () => seller.updateCustomRequestStatus(
                              request.id,
                              'Rejected',
                            ),
                            child: const Text('Reject'),
                          ),
                          SizedBox(
                            width: 160,
                            child: AppPrimaryButton(
                              label: 'Accept',
                              onPressed: () => seller.updateCustomRequestStatus(
                                request.id,
                                'Accepted',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Manage orders',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 12),
            ...seller.sellerOrders.map(
              (order) => Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Order #${order.id}',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        '${order.items.length} items | ${order.status.name} | ETA ${AppFormatters.dateTime(order.estimatedDeliveryTime)}',
                      ),
                      const SizedBox(height: 12),
                      Align(
                        alignment: Alignment.centerRight,
                        child: OutlinedButton(
                          onPressed: order.status == OrderStatus.delivered
                              ? null
                              : () => seller.advanceOrderStatus(order),
                          child: Text(
                            order.status == OrderStatus.delivered
                                ? 'Completed'
                                : 'Advance',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DashboardStat extends StatelessWidget {
  final String label;
  final String value;

  const _DashboardStat({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF7EF),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Text(value, style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 4),
          Text(label, textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
