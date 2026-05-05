import 'package:get/get.dart';

import 'package:home_food/core/models/app_user.dart';
import 'package:home_food/core/routes/app_routes.dart';
import 'package:home_food/core/services/dummy_data_service.dart';

class AuthController extends GetxController {
  final DummyDataService _data = Get.find<DummyDataService>();

  final Rxn<AppUser> currentUser = Rxn<AppUser>();

  void enterApp() {
    currentUser.value = _data.demoCustomer;
    _routeAfterAuth();
  }

  void login({
    required String email,
    required String password,
  }) {
    enterApp();
  }

  void signup({
    required String name,
    required String email,
    required String phone,
  }) {
    currentUser.value = AppUser(
      id: 'new-user',
      name: name,
      email: email,
      phone: phone,
      role: UserRole.customer,
      favoriteFoodIds: const [],
      savedAddresses: _data.addresses,
    );
    _routeAfterAuth();
  }

  void logout() {
    currentUser.value = null;
    Get.offAllNamed(AppRoutes.welcome);
  }

  void _routeAfterAuth() {
    Get.offAllNamed(AppRoutes.customerShell);
  }
}
