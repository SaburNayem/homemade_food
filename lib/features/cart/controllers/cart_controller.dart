import 'package:get/get.dart';

import 'package:home_food/core/models/cart_item.dart';
import 'package:home_food/core/models/food_item.dart';

class CartController extends GetxController {
  final items = <CartItem>[].obs;
  final couponCode = ''.obs;

  double get subtotal => items.fold(0, (sum, item) => sum + item.total);

  double get deliveryFee => items.isEmpty ? 0 : 3;

  double get discount => couponCode.value == 'BITE10' ? subtotal * 0.1 : 0;

  double get total => subtotal + deliveryFee - discount;

  void addToCart(FoodItem food, {int quantity = 1}) {
    final index = items.indexWhere((item) => item.food.id == food.id);
    if (index >= 0) {
      items[index] = items[index].copyWith(
        quantity: items[index].quantity + quantity,
      );
    } else {
      items.add(CartItem(food: food, quantity: quantity));
    }
    Get.snackbar('Added to cart', '${food.name} is ready for checkout.');
  }

  void updateQuantity(String foodId, int quantity) {
    final index = items.indexWhere((item) => item.food.id == foodId);
    if (index < 0) return;
    if (quantity <= 0) {
      items.removeAt(index);
    } else {
      items[index] = items[index].copyWith(quantity: quantity);
    }
  }

  void removeItem(String foodId) {
    items.removeWhere((item) => item.food.id == foodId);
  }

  void applyCoupon(String code) {
    couponCode.value = code.trim().toUpperCase();
  }

  void clearCart() {
    items.clear();
    couponCode.value = '';
  }
}
