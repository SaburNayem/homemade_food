import 'review_model.dart';

class FoodItem {
  final String id;
  final String cookId;
  final String cookName;
  final String name;
  final String imageUrl;
  final String description;
  final List<String> ingredients;
  final double price;
  final double rating;
  final String deliveryTime;
  final double distanceKm;
  final String category;
  final bool isVegetarian;
  final String spiceLevel;
  final bool isPopular;
  final List<ReviewModel> reviews;

  const FoodItem({
    required this.id,
    required this.cookId,
    required this.cookName,
    required this.name,
    required this.imageUrl,
    required this.description,
    required this.ingredients,
    required this.price,
    required this.rating,
    required this.deliveryTime,
    required this.distanceKm,
    required this.category,
    required this.isVegetarian,
    required this.spiceLevel,
    required this.isPopular,
    required this.reviews,
  });
}
