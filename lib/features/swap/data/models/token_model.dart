import '../../domain/entities/token.dart';

class TokenModel extends Token {
  const TokenModel({
    required super.symbol,
    required super.name,
    required super.balance,
    required super.usdValue,
    super.decimals,
  });
  
  factory TokenModel.fromJson(Map<String, dynamic> json) {
    return TokenModel(
      symbol: json['symbol'] as String,
      name: json['name'] as String,
      balance: double.parse(json['balance'].toString()),
      usdValue: double.parse(json['usdValue'].toString()),
      decimals: 8,
    );
  }
}