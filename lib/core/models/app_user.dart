import 'address_model.dart';

enum UserRole { customer, seller }

class AppUser {
  final String id;
  final String name;
  final String email;
  final String phone;
  final UserRole role;
  final List<String> favoriteFoodIds;
  final List<AddressModel> savedAddresses;

  const AppUser({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.role,
    required this.favoriteFoodIds,
    required this.savedAddresses,
  });
}
