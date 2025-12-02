import 'package:equatable/equatable.dart';
import '../../domain/entities/token.dart';
import '../../../../core/utils/currency_formatter.dart';

class SwapState extends Equatable {
  final Token? fromToken;
  final Token? toToken;
  final String fromAmount;
  final String toAmount;
  final double exchangeRate;
  final bool isValid;
  final String? errorMessage;
  
  const SwapState({
    this.fromToken,
    this.toToken,
    this.fromAmount = '',
    this.toAmount = '',
    this.exchangeRate = 0.0,
    this.isValid = false,
    this.errorMessage,
  });
  
  String get exchangeRateText {
    if (fromToken == null || toToken == null || exchangeRate == 0.0) {
      return '';
    }
    return '1 ${fromToken!.symbol}: ${CurrencyFormatter.formatExchangeRate(exchangeRate)} ${toToken!.symbol}';
  }
  
  SwapState copyWith({
    Token? fromToken,
    Token? toToken,
    String? fromAmount,
    String? toAmount,
    double? exchangeRate,
    bool? isValid,
    String? errorMessage,
    bool clearFromAmount = false,
    bool clearToAmount = false,
    bool clearError = false,
  }) {
    return SwapState(
      fromToken: fromToken ?? this.fromToken,
      toToken: toToken ?? this.toToken,
      fromAmount: clearFromAmount ? '' : (fromAmount ?? this.fromAmount),
      toAmount: clearToAmount ? '' : (toAmount ?? this.toAmount),
      exchangeRate: exchangeRate ?? this.exchangeRate,
      isValid: isValid ?? this.isValid,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }
  
  @override
  List<Object?> get props => [
    fromToken,
    toToken,
    fromAmount,
    toAmount,
    exchangeRate,
    isValid,
    errorMessage,
  ];
}