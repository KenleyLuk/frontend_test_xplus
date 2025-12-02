import '../../features/swap/domain/entities/token.dart';

class ValidationResult {
  final bool isValid;
  final String? errorMessage;
  
  const ValidationResult({
    required this.isValid,
    this.errorMessage,
  });
}

class SwapValidator {
  static ValidationResult validateSwap({
    required String amount,
    required double balance,
    required Token? fromToken,
    required Token? toToken,
  }) {
    if (fromToken == null || toToken == null) {
      return const ValidationResult(
        isValid: false,
        errorMessage: 'Please select both tokens',
      );
    }
    
    if (fromToken.symbol == toToken.symbol) {
      return const ValidationResult(
        isValid: false,
        errorMessage: 'Cannot swap same token',
      );
    }
    
    if (amount.isEmpty) {
      return const ValidationResult(
        isValid: false,
        errorMessage: 'Please enter an amount',
      );
    }
    
    final amountValue = double.tryParse(amount);
    if (amountValue == null || amountValue <= 0) {
      return const ValidationResult(
        isValid: false,
        errorMessage: 'Please enter a valid amount',
      );
    }
    
    if (amountValue > balance) {
      return const ValidationResult(
        isValid: false,
        errorMessage: 'Insufficient balance',
      );
    }
    
    return const ValidationResult(isValid: true);
  }
  
  static bool isValidNumber(String value) {
    if (value.isEmpty) return true;
    final regex = RegExp(r'^\d*\.?\d*$');
    return regex.hasMatch(value);
  }
}