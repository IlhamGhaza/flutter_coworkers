import 'package:intl/intl.dart';

class FormatExt {
  static String formatDate(DateTime date) {
    return DateFormat('dd/MM/yyyy').format(date);
  }

  static String price(num number) {
    return NumberFormat.currency(symbol: '\$', decimalDigits: 0).format(number);
  }

  static String number(num number) {
    return NumberFormat.currency(symbol: '', decimalDigits: 0).format(number);
  }
}
