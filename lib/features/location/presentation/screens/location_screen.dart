import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:home_food/core/controllers/app_controller.dart';
import 'package:home_food/core/models/address_model.dart';
import 'package:home_food/core/widgets/section_header.dart';

class LocationScreen extends StatelessWidget {
  const LocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final app = Get.find<AppController>();

    return Scaffold(
      appBar: AppBar(title: const Text('Select delivery location')),
      body: Obx(
        () => ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const SectionHeader(title: 'Saved addresses'),
            const SizedBox(height: 12),
            ...app.savedAddresses.map(
              (address) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _SelectableAddressTile(
                  address: address,
                  selected: app.selectedAddress.value?.id == address.id,
                  onTap: () => app.selectAddress(address),
                ),
              ),
            ),
            const SizedBox(height: 12),
            const SectionHeader(title: 'Manual location'),
            const SizedBox(height: 12),
            const TextField(
              decoration: InputDecoration(
                hintText: 'Type street, area, or landmark',
                prefixIcon: Icon(Icons.edit_location_alt_outlined),
              ),
            ),
            const SizedBox(height: 20),
            const SectionHeader(title: 'Choose from map'),
            const SizedBox(height: 12),
            Container(
              height: 220,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFFFF1DC), Color(0xFFF9D38A)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(28),
              ),
              alignment: Alignment.center,
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.map_outlined,
                    size: 56,
                    color: Color(0xFFE67E22),
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Map picker placeholder for future Google Maps integration',
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SelectableAddressTile extends StatelessWidget {
  final AddressModel address;
  final bool selected;
  final VoidCallback onTap;

  const _SelectableAddressTile({
    required this.address,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: selected ? const Color(0xFFE67E22) : Colors.transparent,
            width: 1.5,
          ),
        ),
        child: Row(
          children: [
            Icon(
              selected
                  ? Icons.radio_button_checked
                  : Icons.radio_button_off_outlined,
              color: selected ? const Color(0xFFE67E22) : Colors.grey,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    address.label,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 4),
                  Text(address.fullAddress),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
