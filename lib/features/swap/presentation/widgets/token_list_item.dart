import 'package:flutter/material.dart';
import '../../domain/entities/token.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../../../core/utils/responsive.dart';
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
    final isTablet = Responsive.isTablet(context);
    
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: isTablet ? 48 : 20,
          vertical: isTablet ? 20 : 12,
        ),
        child: Row(
          children: [
            TokenIcon(
              symbol: token.symbol,
              size: isTablet ? 64 : 40,
            ),
            SizedBox(width: isTablet ? 20 : 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    token.name,
                    style: TextStyle(
                      color: Color(0xFFDDE1E1),
                      fontSize: isTablet ? 28 : 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: isTablet ? 8 : 4),
                  Text(
                    token.symbol,
                    style: TextStyle(
                      color: Color(0xFF7A7B7B),
                      fontSize: isTablet ? 20 : 12,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  CurrencyFormatter.formatBalance(token.balance),
                  style: TextStyle(
                    color: Color(0xFFDDE1E1),
                    fontSize: isTablet ? 20 : 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: isTablet ? 6 : 4),
                Text(
                  '≈ ${CurrencyFormatter.formatExchangeRate(token.usdValue)}',
                  style: TextStyle(
                    color: Color(0xFF7A7B7B),
                    fontSize: isTablet ? 18 : 12,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}