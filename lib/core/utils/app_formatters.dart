import 'package:intl/intl.dart';

class AppFormatters {
  static final _currency = NumberFormat.currency(
    symbol: '\$',
    decimalDigits: 0,
  );
  static final _date = DateFormat('MMM d');
  static final _dateTime = DateFormat('MMM d, h:mm a');

  static String price(double value) => _currency.format(value);

  static String date(DateTime value) => _date.format(value);

  static String dateTime(DateTime value) => _dateTime.format(value);
}
