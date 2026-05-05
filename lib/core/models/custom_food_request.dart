class CustomFoodRequest {
  final String id;
  final String foodName;
  final String description;
  final String spiceLevel;
  final int quantity;
  final DateTime deliveryDateTime;
  final String specialInstructions;
  final String? referenceImageUrl;
  final String status;

  const CustomFoodRequest({
    required this.id,
    required this.foodName,
    required this.description,
    required this.spiceLevel,
    required this.quantity,
    required this.deliveryDateTime,
    required this.specialInstructions,
    this.referenceImageUrl,
    required this.status,
  });
}
