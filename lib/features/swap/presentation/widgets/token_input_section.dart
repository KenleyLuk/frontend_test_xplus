import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/utils/currency_formatter.dart';
import 'token_icon.dart';

class TokenInputSection extends StatefulWidget {
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
  State<TokenInputSection> createState() => _TokenInputSectionState();
}

class _TokenInputSectionState extends State<TokenInputSection> {
  late TextEditingController _amountController;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    // amount係空，默認設置"0"
    final initialValue = widget.amount.isEmpty ? '0' : widget.amount;
    _amountController = TextEditingController(text: initialValue);
    _focusNode = FocusNode();
  }

  @override
  void didUpdateWidget(TokenInputSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.amount != oldWidget.amount) {
      // 新的 amount係空，設置"0"
      final newValue = widget.amount.isEmpty ? '0' : widget.amount;
      _amountController.text = newValue;

      // 將cursor 移到最右邊
      _amountController.selection = TextSelection.collapsed(
        offset: newValue.length,
      );
    }
  }

  @override
  void dispose() {
    _amountController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              widget.label,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFFDDE1E1),
                fontSize: 24,
              ),
            ),
            const Spacer(),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Balance: ',
                    style: const TextStyle(
                      color: Color(0xFF6F7174), // 淺灰色
                      fontSize: 12,
                    ),
                  ),
                  TextSpan(
                    text: CurrencyFormatter.formatBalance(widget.balance),
                    style: const TextStyle(
                      color: Color(0xFFDDE1E1), 
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            GestureDetector(
              onTap: widget.onTokenTap,
              child: Row(
                children: [
                  TokenIcon(symbol: widget.tokenSymbol, size: 24),
                  const SizedBox(width: 8),
                  Text(
                    widget.tokenSymbol ?? '',
                    style: const TextStyle(
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
            if (widget.editable)
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    _focusNode.requestFocus();
                  },
                  child: TextField(
                    controller: _amountController,
                    focusNode: _focusNode,
                    onChanged: (value) {
                      widget.onAmountChanged?.call(value);
                      // 確保cursor係最右邊
                      _amountController.selection = TextSelection.collapsed(
                        offset: value.length,
                      );
                    },
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    textAlign: TextAlign.right, 
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFDDE1E1),
                      fontSize: 24, 
                    ),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      hintText: '0',
                      hintStyle: TextStyle(
                        color: Color(0xFF494949),
                        fontSize: 24,
                      ),
                      contentPadding: EdgeInsets.zero,
                      isDense: true,
                    ),
                  ),
                ),
              )
            else
              Text(
                widget.amount.isEmpty ? '0' : widget.amount,
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
            if (widget.showMaxButton)
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: GestureDetector(
                  onTap: widget.onMaxPressed,
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
            if (!widget.editable && widget.exchangeRate != null && widget.exchangeRate!.isNotEmpty)
              Text(
                widget.exchangeRate!,
                style: const TextStyle(color: Color(0xFF494949), fontSize: 12),
              ),
          ],
        ),
      ],
    );
  }
}
