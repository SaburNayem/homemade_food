import 'package:flutter_test/flutter_test.dart';
import 'package:home_food/core/services/dummy_data_service.dart';

void main() {
  test('dummy food data is available', () {
    final service = DummyDataService();

    expect(service.foods, isNotEmpty);
    expect(service.homeCooks, isNotEmpty);
    expect(service.demoCustomer.name, 'Nadia Rahman');
  });
}
