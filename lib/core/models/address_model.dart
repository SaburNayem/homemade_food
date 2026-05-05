enum AddressType { home, office, other }

class AddressModel {
  final String id;
  final String label;
  final String street;
  final String area;
  final String city;
  final double latitude;
  final double longitude;
  final AddressType type;

  const AddressModel({
    required this.id,
    required this.label,
    required this.street,
    required this.area,
    required this.city,
    required this.latitude,
    required this.longitude,
    required this.type,
  });

  String get fullAddress => '$street, $area, $city';
}
