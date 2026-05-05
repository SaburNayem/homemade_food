import 'package:get/get.dart';

import 'package:home_food/core/models/custom_food_request.dart';
import 'package:home_food/core/models/food_item.dart';
import 'package:home_food/core/models/order_model.dart';
import 'package:home_food/core/models/review_model.dart';
import 'package:home_food/core/services/dummy_data_service.dart';
import 'package:home_food/features/orders/controllers/order_controller.dart';

class SellerController extends GetxController {
  final DummyDataService _data = Get.find<DummyDataService>();
  final OrderController _orders = Get.find<OrderController>();

  final sellerFoods = <FoodItem>[].obs;

  @override
  void onInit() {
    sellerFoods.assignAll(
      _data.foods.where((food) => food.cookId == 'cook1').toList(),
    );
    super.onInit();
  }

  List<OrderModel> get sellerOrders => _orders.orders;

  List<CustomFoodRequest> get customRequests => _orders.customRequests;

  void addFoodItem({
    required String name,
    required double price,
    required String description,
    required String ingredients,
    required int availableQuantity,
  }) {
    sellerFoods.insert(
      0,
      FoodItem(
        id: 'seller-food-${sellerFoods.length + 1}',
        cookId: 'cook1',
        cookName: 'Sharmeen Kitchen',
        name: name,
        imageUrl:
            'https://images.unsplash.com/photo-1547592180-85f173990554?auto=format&fit=crop&w=900&q=80',
        description:
            '$description Available portions: $availableQuantity for today.',
        ingredients: ingredients
            .split(',')
            .map((value) => value.trim())
            .where((value) => value.isNotEmpty)
            .toList(),
        price: price,
        rating: 4.6,
        deliveryTime: '25-30 min',
        distanceKm: 1.8,
        category: 'Custom food',
        isVegetarian: false,
        spiceLevel: 'Medium',
        isPopular: false,
        reviews: const [
          ReviewModel(
            userName: 'Preview',
            rating: 4.6,
            comment: 'New menu item added by seller dashboard.',
          ),
        ],
      ),
    );

    Get.snackbar('Food item added', '$name is now visible on your dashboard.');
  }

  void updateCustomRequestStatus(String requestId, String status) {
    final index = _orders.customRequests.indexWhere(
      (item) => item.id == requestId,
    );
    if (index >= 0) {
      final request = _orders.customRequests[index];
      _orders.customRequests[index] = CustomFoodRequest(
        id: request.id,
        foodName: request.foodName,
        description: request.description,
        spiceLevel: request.spiceLevel,
        quantity: request.quantity,
        deliveryDateTime: request.deliveryDateTime,
        specialInstructions: request.specialInstructions,
        referenceImageUrl: request.referenceImageUrl,
        status: status,
      );
    }
  }

  void advanceOrderStatus(OrderModel order) {
    switch (order.status) {
      case OrderStatus.placed:
        _orders.updateOrderStatus(order.id, OrderStatus.accepted);
        break;
      case OrderStatus.accepted:
        _orders.updateOrderStatus(order.id, OrderStatus.cooking);
        break;
      case OrderStatus.cooking:
        _orders.updateOrderStatus(order.id, OrderStatus.pickedUp);
        break;
      case OrderStatus.pickedUp:
        _orders.updateOrderStatus(order.id, OrderStatus.delivered);
        break;
      case OrderStatus.delivered:
        break;
    }
  }
}
