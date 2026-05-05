import 'food_item.dart';

class CartItem {
  final FoodItem food;
  final int quantity;

  const CartItem({required this.food, required this.quantity});

  CartItem copyWith({FoodItem? food, int? quantity}) {
    return CartItem(
      food: food ?? this.food,
      quantity: quantity ?? this.quantity,
    );
  }

  double get total => food.price * quantity;
}
