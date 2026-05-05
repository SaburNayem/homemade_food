import 'package:get/get.dart';

import 'package:home_food/core/models/address_model.dart';
import 'package:home_food/core/services/dummy_data_service.dart';

class AppController extends GetxController {
  final DummyDataService _data = Get.find<DummyDataService>();

  final selectedBottomTab = 0.obs;
  final selectedCategory = 'All'.obs;
  final searchQuery = ''.obs;
  final selectedAddress = Rxn<AddressModel>();
  final selectedSpice = 'All'.obs;
  final onlyNearby = false.obs;
  final minRating = 0.0.obs;
  final vegetarianOnly = false.obs;
  final maxPrice = 20.0.obs;

  List<String> get categories => ['All', ..._data.categories];

  List<AddressModel> get savedAddresses => _data.addresses;

  @override
  void onInit() {
    selectedAddress.value = _data.addresses.first;
    super.onInit();
  }

  void selectTab(int index) => selectedBottomTab.value = index;

  void selectCategory(String category) => selectedCategory.value = category;

  void updateSearch(String value) => searchQuery.value = value;

  void selectAddress(AddressModel address) => selectedAddress.value = address;

  void resetFilters() {
    selectedSpice.value = 'All';
    onlyNearby.value = false;
    minRating.value = 0;
    vegetarianOnly.value = false;
    maxPrice.value = 20;
  }
}
