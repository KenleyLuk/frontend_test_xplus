import 'package:flutter_test/flutter_test.dart';
import 'package:frontend_test_xplus/core/utils/currency_formatter.dart';

void main() {
  group('CurrencyFormatter', () {
    test('formatBalance formats numbers correctly', () {
      expect(CurrencyFormatter.formatBalance(1234567.89), '1,234,567.89');
      expect(CurrencyFormatter.formatBalance(0.005), '0.005');
      expect(CurrencyFormatter.formatBalance(100), '100');
      expect(CurrencyFormatter.formatBalance(1000), '1,000');
      expect(CurrencyFormatter.formatBalance(0), '0');
    });

    test('formatExchangeRate formats with 2 decimals', () {
      expect(CurrencyFormatter.formatExchangeRate(110554.89), '110,554.89');
      expect(CurrencyFormatter.formatExchangeRate(0.01), '0.01');
      expect(CurrencyFormatter.formatExchangeRate(1234567.89), '1,234,567.89');
    });
  });
}