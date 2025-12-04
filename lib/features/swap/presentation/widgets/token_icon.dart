import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class TokenIcon extends StatelessWidget {
  final String? symbol;
  final double size;
  
  const TokenIcon({
    Key? key,
    this.symbol,
    this.size = 24,
  }) : super(key: key);

  // Check if the symbol is a currency
  bool _isCurrency(String symbol) {
    const currencies = ['USD', 'JPY', 'HKD', 'GBP', 'CNY', 'EUR'];
    return currencies.contains(symbol);
  }

  // Get the icon path based on the symbol
  String? _getIconPath(String symbol) {
    if (_isCurrency(symbol)) {
      // Currencies 使用 PNG
      final currencyMap = {
        'USD': 'assets/currencies/usd.png',
        'JPY': 'assets/currencies/jpy.png',
        'HKD': 'assets/currencies/hkd.png',
        'GBP': 'assets/currencies/gbp.png',
        'CNY': 'assets/currencies/rmb.png',  
        'EUR': 'assets/currencies/eur.png',
      };
      return currencyMap[symbol];
    } else {
      final tokenMap = {
        'WBTC': 'assets/tokens/btc.svg',  
        'ETH': 'assets/tokens/eth.svg',
        'USDT': 'assets/tokens/usdt.svg',
        'USDC': 'assets/tokens/usdc.svg',
        'DOGE': 'assets/tokens/doge.svg',
      };
      return tokenMap[symbol];
    }
  }
  
  
  @override
  Widget build(BuildContext context) {
    if (symbol == null) {
      return Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey[300],
        ),
      );
    }
    
    final iconPath = _getIconPath(symbol!);
    
    if (iconPath == null) {
      return Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey[400],
        ),
        child: Center(
          child: Text(
            symbol![0],
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: size * 0.5,
              fontFamily: 'Baijam',
            ),
          ),
        ),
      );
    }
    
    // 判斷係 SVG 還是 PNG
    if (iconPath.endsWith('.svg')) {
      return SizedBox(
        width: size,
        height: size,
        child: SvgPicture.asset(
          iconPath,
          width: size,
          height: size,
          fit: BoxFit.contain,
        ),
      );
    } else {
      // PNG 相片
      return SizedBox(
        width: size,
        height: size,
        child: Image.asset(
          iconPath,
          width: size,
          height: size,
          fit: BoxFit.contain,
        ),
      );
    }
  }
}