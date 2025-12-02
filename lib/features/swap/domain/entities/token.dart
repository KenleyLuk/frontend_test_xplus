import 'package:equatable/equatable.dart';

class Token extends Equatable {
  final String symbol;
  final String name;
  final double balance;
  final double usdValue;
  final int decimals;
  
  const Token({
    required this.symbol,
    required this.name,
    required this.balance,
    required this.usdValue,
    this.decimals = 8,
  });
  
  @override
  List<Object?> get props => [symbol, name, balance, usdValue, decimals];
}

