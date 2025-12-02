import '../entities/token.dart';

abstract class SwapRepository {
  double calculateExchangeRate(Token fromToken, Token toToken);
  double calculateToAmount(String fromAmount, double exchangeRate);
}

class SwapRepositoryImpl implements SwapRepository {
  @override
  double calculateExchangeRate(Token fromToken, Token toToken) {
    if (toToken.usdValue == 0) {
      throw Exception('Invalid exchange rate: toToken USD value is 0');
    }
    return fromToken.usdValue / toToken.usdValue;
  }
  
  @override
  double calculateToAmount(String fromAmount, double exchangeRate) {
    final amount = double.tryParse(fromAmount);
    if (amount == null || amount <= 0) {
      return 0.0;
    }
    return amount * exchangeRate;
  }
}

