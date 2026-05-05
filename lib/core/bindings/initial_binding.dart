import 'package:get/get.dart';

import 'package:home_food/core/controllers/app_controller.dart';
import 'package:home_food/core/services/dummy_data_service.dart';
import 'package:home_food/features/auth/controllers/auth_controller.dart';
import 'package:home_food/features/cart/controllers/cart_controller.dart';
import 'package:home_food/features/food/controllers/food_controller.dart';
import 'package:home_food/features/orders/controllers/order_controller.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(DummyDataService());
    Get.put(AuthController());
    Get.put(AppController());
    Get.put(FoodController());
    Get.put(CartController());
    Get.put(OrderController());
  }
}
