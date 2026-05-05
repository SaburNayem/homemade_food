import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:home_food/core/bindings/initial_binding.dart';
import 'package:home_food/core/routes/app_pages.dart';
import 'package:home_food/core/routes/app_routes.dart';
import 'package:home_food/core/theme/app_theme.dart';

class HomeMadeBitesApp extends StatelessWidget {
  const HomeMadeBitesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'HomeMade Bites',
      debugShowCheckedModeBanner: false,
      initialBinding: InitialBinding(),
      initialRoute: AppRoutes.welcome,
      getPages: AppPages.routes,
      theme: AppTheme.lightTheme,
    );
  }
}
