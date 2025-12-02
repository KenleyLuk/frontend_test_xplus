import 'package:intl/intl.dart';

class CurrencyFormatter {
  static String formatBalance(double balance) {
    return NumberFormat('#,##0.########').format(balance);
  }
  
  static String formatExchangeRate(double rate) {
    return NumberFormat('#,##0.00').format(rate);
  }
}