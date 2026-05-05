import 'package:get/get.dart';

import 'package:home_food/core/models/address_model.dart';
import 'package:home_food/core/models/custom_food_request.dart';
import 'package:home_food/core/models/order_model.dart';
import 'package:home_food/core/services/dummy_data_service.dart';
import 'package:home_food/features/cart/controllers/cart_controller.dart';

class OrderController extends GetxController {
  final DummyDataService _data = Get.find<DummyDataService>();
  final CartController _cart = Get.find<CartController>();

  final orders = <OrderModel>[].obs;
  final customRequests = <CustomFoodRequest>[].obs;
  final selectedPaymentMethod = PaymentMethod.cashOnDelivery.obs;

  @override
  void onInit() {
    orders.assignAll(_data.initialOrders);
    customRequests.assignAll(_data.initialCustomRequests);
    super.onInit();
  }

  void setPaymentMethod(PaymentMethod method) {
    selectedPaymentMethod.value = method;
  }

  void placeOrder(AddressModel address) {
    if (_cart.items.isEmpty) {
      Get.snackbar('Cart is empty', 'Add homemade food before checkout.');
      return;
    }

    final order = OrderModel(
      id: 'order${orders.length + 1}',
      items: List.of(_cart.items),
      address: address,
      paymentMethod: selectedPaymentMethod.value,
      status: OrderStatus.placed,
      deliveryFee: _cart.deliveryFee,
      estimatedDeliveryTime: DateTime.now().add(const Duration(minutes: 35)),
      createdAt: DateTime.now(),
    );

    orders.insert(0, order);
    _cart.clearCart();
    Get.back();
    Get.toNamed('/order-tracking', arguments: order.id);
  }

  OrderModel? getOrderById(String id) {
    for (final order in orders) {
      if (order.id == id) return order;
    }
    return null;
  }

  void updateOrderStatus(String orderId, OrderStatus newStatus) {
    final index = orders.indexWhere((order) => order.id == orderId);
    if (index >= 0) {
      orders[index] = orders[index].copyWith(status: newStatus);
    }
  }

  void submitCustomRequest(CustomFoodRequest request) {
    customRequests.insert(0, request);
    Get.snackbar(
      'Request sent',
      'Nearby home cooks can now review your custom meal request.',
    );
  }
}
