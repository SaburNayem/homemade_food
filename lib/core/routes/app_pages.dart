import 'package:get/get.dart';

import 'package:home_food/core/routes/app_routes.dart';
import 'package:home_food/features/auth/presentation/screens/forgot_password_screen.dart';
import 'package:home_food/features/auth/presentation/screens/login_screen.dart';
import 'package:home_food/features/auth/presentation/screens/signup_screen.dart';
import 'package:home_food/features/auth/presentation/screens/welcome_screen.dart';
import 'package:home_food/features/checkout/presentation/screens/checkout_screen.dart';
import 'package:home_food/features/customer/presentation/screens/customer_shell.dart';
import 'package:home_food/features/food/presentation/screens/food_details_screen.dart';
import 'package:home_food/features/location/presentation/screens/location_screen.dart';
import 'package:home_food/features/orders/presentation/screens/order_tracking_screen.dart';

class AppPages {
  static final routes = <GetPage<dynamic>>[
    GetPage(name: AppRoutes.welcome, page: () => const WelcomeScreen()),
    GetPage(name: AppRoutes.login, page: () => const LoginScreen()),
    GetPage(name: AppRoutes.signup, page: () => const SignupScreen()),
    GetPage(
      name: AppRoutes.forgotPassword,
      page: () => const ForgotPasswordScreen(),
    ),
    GetPage(name: AppRoutes.customerShell, page: () => const CustomerShell()),
    GetPage(name: AppRoutes.location, page: () => const LocationScreen()),
    GetPage(name: AppRoutes.foodDetails, page: () => const FoodDetailsScreen()),
    GetPage(name: AppRoutes.checkout, page: () => const CheckoutScreen()),
    GetPage(
      name: AppRoutes.orderTracking,
      page: () => const OrderTrackingScreen(),
    ),
  ];
}
