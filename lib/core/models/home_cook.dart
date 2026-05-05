class HomeCook {
  final String id;
  final String name;
  final String specialty;
  final String imageUrl;
  final double rating;
  final double distanceKm;
  final String deliveryTime;
  final bool acceptsCustomOrders;

  const HomeCook({
    required this.id,
    required this.name,
    required this.specialty,
    required this.imageUrl,
    required this.rating,
    required this.distanceKm,
    required this.deliveryTime,
    required this.acceptsCustomOrders,
  });
}
