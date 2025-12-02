import 'package:flutter/material.dart';
import '../../domain/entities/token.dart';
import '../../../../core/utils/currency_formatter.dart';
import 'token_icon.dart';

class TokenListItem extends StatelessWidget {
  final Token token;
  final VoidCallback onTap;
  
  const TokenListItem({
    Key? key,
    required this.token,
    required this.onTap,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: TokenIcon(symbol: token.symbol, size: 40),
      title: Text(
        token.name,
        style: TextStyle(color: Color(0xFFDDE1E1), fontSize: 18, fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        token.symbol,
        style: TextStyle(color: Color(0xFF7A7B7B), fontSize: 12),
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            CurrencyFormatter.formatBalance(token.balance),
            style: TextStyle(color: Color(0xFFDDE1E1), fontSize: 12, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            '≈ ${CurrencyFormatter.formatExchangeRate(token.usdValue)}',
            style: TextStyle(color: Color(0xFF7A7B7B), fontSize: 12),
          ),
        ],
      ),
      onTap: onTap,
    );
  }
}