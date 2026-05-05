import 'package:get/get.dart';

import 'package:home_food/core/controllers/app_controller.dart';
import 'package:home_food/core/models/food_item.dart';
import 'package:home_food/core/models/home_cook.dart';
import 'package:home_food/core/services/dummy_data_service.dart';
import 'package:home_food/features/auth/controllers/auth_controller.dart';

class FoodController extends GetxController {
  final DummyDataService _data = Get.find<DummyDataService>();
  final AppController _app = Get.find<AppController>();
  final AuthController _auth = Get.find<AuthController>();

  List<HomeCook> get cooks => _data.homeCooks;

  List<FoodItem> get foods => _data.foods;

  List<FoodItem> get popularFoods =>
      foods.where((food) => food.isPopular).toList();

  List<HomeCook> get nearbyCooks =>
      cooks.where((cook) => cook.distanceKm <= 2.5).toList();

  List<FoodItem> get recommendedFoods {
    final favorites = _auth.currentUser.value?.favoriteFoodIds ?? [];
    return foods.where((food) => favorites.contains(food.id)).toList();
  }

  List<FoodItem> get filteredFoods {
    return foods.where((food) {
      final category = _app.selectedCategory.value;
      final query = _app.searchQuery.value.toLowerCase();
      final spice = _app.selectedSpice.value;

      final matchesCategory = category == 'All' || food.category == category;
      final matchesQuery =
          query.isEmpty ||
          food.name.toLowerCase().contains(query) ||
          food.cookName.toLowerCase().contains(query);
      final matchesSpice = spice == 'All' || food.spiceLevel == spice;
      final matchesNearby = !_app.onlyNearby.value || food.distanceKm <= 2.5;
      final matchesRating = food.rating >= _app.minRating.value;
      final matchesVeg = !_app.vegetarianOnly.value || food.isVegetarian;
      final matchesPrice = food.price <= _app.maxPrice.value;

      return matchesCategory &&
          matchesQuery &&
          matchesSpice &&
          matchesNearby &&
          matchesRating &&
          matchesVeg &&
          matchesPrice;
    }).toList();
  }

  FoodItem getFoodById(String id) =>
      foods.firstWhere((food) => food.id == id, orElse: () => foods.first);
}
