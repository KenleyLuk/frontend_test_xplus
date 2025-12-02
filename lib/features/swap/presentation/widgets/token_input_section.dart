import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/utils/currency_formatter.dart';
import 'token_icon.dart';

class TokenInputSection extends StatelessWidget {
  final String label;
  final String? tokenSymbol;
  final double balance;
  final String amount;
  final String? exchangeRate;
  final bool showMaxButton;
  final bool editable;
  final VoidCallback onTokenTap;
  final ValueChanged<String>? onAmountChanged;
  final VoidCallback? onMaxPressed;

  const TokenInputSection({
    Key? key,
    required this.label,
    this.tokenSymbol,
    required this.balance,
    required this.amount,
    this.exchangeRate,
    this.showMaxButton = false,
    this.editable = true,
    required this.onTokenTap,
    this.onAmountChanged,
    this.onMaxPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFFDDE1E1),
                fontSize: 24,
              ),
            ),
            const Spacer(),
            Text(
              'Balance: ${CurrencyFormatter.formatBalance(balance)}',
              style: const TextStyle(color: Color(0xFF494949), fontSize: 12),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            GestureDetector(
              onTap: onTokenTap,
              child: Row(
                children: [
                  TokenIcon(symbol: tokenSymbol, size: 24),
                  const SizedBox(width: 8),
                  Text(
                    tokenSymbol ?? '',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFDDE1E1),
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(width: 4),
                  SvgPicture.asset(
                    'assets/dropdown.svg',
                    width: 16,
                    height: 16,
                    fit: BoxFit.contain,
                    colorFilter: const ColorFilter.mode(
                      Color(0xFFDDE1E1),
                      BlendMode.srcIn,
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            if (editable)
              Expanded(
                child: TextField(
                  controller: TextEditingController(text: amount)
                    ..selection = TextSelection.collapsed(offset: amount.length),
                  onChanged: onAmountChanged,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFDDE1E1),
                    fontSize: 24,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: '0',
                    hintStyle: const TextStyle(color: Color(0xFF494949)),
                  ),
                ),
              )
            else
              Text(
                amount.isEmpty ? '0' : amount,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFDDE1E1),
                  fontSize: 24,
                ),
              ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            const Spacer(),
            if (showMaxButton)
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: GestureDetector(
                  onTap: onMaxPressed,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(
                        color: const Color(0xFFBFFC59),
                        width: 1,
                      ),
                      color: Colors.transparent,
                    ),
                    child: const Text(
                      'MAX',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFBFFC59),
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ),
            if (!editable && exchangeRate != null && exchangeRate!.isNotEmpty)
              Text(
                exchangeRate!,
                style: const TextStyle(color: Color(0xFF494949), fontSize: 12),
              ),
          ],
        ),
      ],
    );
  }
}
