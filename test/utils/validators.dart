import 'package:flutter_test/flutter_test.dart';
import 'package:frontend_test_xplus/core/utils/validators.dart';
import 'package:frontend_test_xplus/features/swap/domain/entities/token.dart';

void main() {
  final wbtc = Token(symbol: 'WBTC', name: 'Wrapped Bitcoin', balance: 0.005, usdValue: 110554.89);
  final usd = Token(symbol: 'USD', name: 'US Dollar', balance: 321.33, usdValue: 1.0);

  group('SwapValidator', () {
    test('validateSwap returns invalid for null tokens', () {
      expect(SwapValidator.validateSwap(amount: '100', balance: 100.0, fromToken: null, toToken: usd).isValid, false);
      expect(SwapValidator.validateSwap(amount: '100', balance: 100.0, fromToken: wbtc, toToken: null).isValid, false);
    });

    test('validateSwap returns invalid for same token', () {
      final result = SwapValidator.validateSwap(amount: '100', balance: 100.0, fromToken: wbtc, toToken: wbtc);
      expect(result.isValid, false);
      expect(result.errorMessage, 'Cannot swap same token');
    });

    test('validateSwap returns invalid for empty amount', () {
      final result = SwapValidator.validateSwap(amount: '', balance: 100.0, fromToken: wbtc, toToken: usd);
      expect(result.isValid, false);
      expect(result.errorMessage, 'Please enter an amount');
    });

    test('validateSwap returns invalid for invalid amount', () {
      final result = SwapValidator.validateSwap(amount: 'abc', balance: 100.0, fromToken: wbtc, toToken: usd);
      expect(result.isValid, false);
      expect(result.errorMessage, 'Please enter a valid amount');
    });

    test('validateSwap returns invalid for insufficient balance', () {
      final result = SwapValidator.validateSwap(amount: '100', balance: 50.0, fromToken: wbtc, toToken: usd);
      expect(result.isValid, false);
      expect(result.errorMessage, 'Insufficient balance');
    });

    test('validateSwap returns valid for valid input', () {
      final result = SwapValidator.validateSwap(amount: '0.001', balance: 0.005, fromToken: wbtc, toToken: usd);
      expect(result.isValid, true);
    });

    test('isValidNumber validates number format', () {
      expect(SwapValidator.isValidNumber(''), true);
      expect(SwapValidator.isValidNumber('123'), true);
      expect(SwapValidator.isValidNumber('123.45'), true);
      expect(SwapValidator.isValidNumber('0.5'), true);
      expect(SwapValidator.isValidNumber('.5'), true);
      expect(SwapValidator.isValidNumber('abc'), false);
      expect(SwapValidator.isValidNumber('12.34.56'), false);
    });
  });
}