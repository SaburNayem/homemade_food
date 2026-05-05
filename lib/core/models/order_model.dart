import 'address_model.dart';
import 'cart_item.dart';

enum OrderStatus { placed, accepted, cooking, pickedUp, delivered }

enum PaymentMethod { cashOnDelivery, card, mobileBanking }

class OrderModel {
  final String id;
  final List<CartItem> items;
  final AddressModel address;
  final PaymentMethod paymentMethod;
  final OrderStatus status;
  final double deliveryFee;
  final DateTime estimatedDeliveryTime;
  final DateTime createdAt;

  const OrderModel({
    required this.id,
    required this.items,
    required this.address,
    required this.paymentMethod,
    required this.status,
    required this.deliveryFee,
    required this.estimatedDeliveryTime,
    required this.createdAt,
  });

  double get subtotal => items.fold(0, (sum, item) => sum + item.total);

  double get total => subtotal + deliveryFee;

  OrderModel copyWith({OrderStatus? status}) {
    return OrderModel(
      id: id,
      items: items,
      address: address,
      paymentMethod: paymentMethod,
      status: status ?? this.status,
      deliveryFee: deliveryFee,
      estimatedDeliveryTime: estimatedDeliveryTime,
      createdAt: createdAt,
    );
  }
}
