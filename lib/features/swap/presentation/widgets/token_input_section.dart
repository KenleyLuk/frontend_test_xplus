import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/utils/currency_formatter.dart';
import 'token_icon.dart';
import 'package:flutter/material.dart';
import '../../../../core/utils/responsive.dart' as responsive;
import '../../../../core/constants/breakpoint.dart';
import '../../../../core/constants/spacing.dart';
import 'package:flutter/material.dart';
import '../../../../core/constants/colors.dart';

class AppTextStyles {
  // 字體家族
  static const String fontFamily = 'Baijam';
  
  // 標題樣式
  static TextStyle title(BuildContext context, {Color? color}) {
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: 56.0, // 平板，移動端需要根據 context 調整
      fontWeight: FontWeight.bold,
      color: color ?? AppColors.textWhite,
    );
  }
  
  // 標籤樣式（粗體）
  static TextStyle label(BuildContext context, {Color? color}) {
    return TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.bold,
      color: color ?? AppColors.textPrimary,
    );
  }
  
  // 主要文字樣式（粗體）
  static TextStyle bodyBold({Color? color, double? fontSize}) {
    return TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.bold,
      color: color ?? AppColors.textPrimary,
      fontSize: fontSize,
    );
  }
  
  // 主要文字樣式（中等）
  static TextStyle bodyMedium({Color? color, double? fontSize}) {
    return TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w500,
      color: color ?? AppColors.textPrimary,
      fontSize: fontSize,
    );
  }
  
  // 主要文字樣式（半粗體）
  static TextStyle bodySemiBold({Color? color, double? fontSize}) {
    return TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w600,
      color: color ?? AppColors.textPrimary,
      fontSize: fontSize,
    );
  }
  
  // 主要文字樣式（正常）
  static TextStyle body({Color? color, double? fontSize}) {
    return TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.normal,
      color: color ?? AppColors.textPrimary,
      fontSize: fontSize,
    );
  }
  
  // 次要文字樣式
  static TextStyle secondary({Color? color, double? fontSize}) {
    return TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.normal,
      color: color ?? AppColors.textSecondary,
      fontSize: fontSize,
    );
  }
  
  // 第三級文字樣式
  static TextStyle tertiary({Color? color, double? fontSize}) {
    return TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.normal,
      color: color ?? AppColors.textTertiary,
      fontSize: fontSize,
    );
  }
}

class Responsive {
  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width <= Breakpoint.mobile;
  }
  
  static bool isTablet(BuildContext context) {
    return MediaQuery.of(context).size.width > Breakpoint.mobile;
  }
  
  static double getPadding(BuildContext context) {
    return isMobile(context) ? AppSpacing.md : 32.0;
  }
  
  static double getCardPadding(BuildContext context) {
    return isMobile(context) ? 20.0 : 40.0;
  }
  
  // 平板電腦最大內容寬度 - 根據圖片調整為更寬
  static double getMaxContentWidth(BuildContext context) {
    return isTablet(context) ? 900.0 : double.infinity;
  }
  
  // 平板電腦水平 padding - 更大的左右間距
  static double getHorizontalPadding(BuildContext context) {
    return isTablet(context) ? 80.0 : AppSpacing.md;
  }
  
  // 平板電腦標題字體大小
  static double getTitleFontSize(BuildContext context) {
    return isTablet(context) ? 32.0 : 24.0;
  }
  
  // 平板電腦標籤字體大小
  static double getLabelFontSize(BuildContext context) {
    return isTablet(context) ? 28.0 : 24.0;
  }
}

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
    final isTablet = Responsive.isTablet(context);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              widget.label,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFFDDE1E1),
                fontSize: Responsive.getLabelFontSize(context),
                fontFamily: 'Baijam',
              ),
            ),
            const Spacer(),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Balance: ',
                    style: TextStyle(
                      color: Color(0xFF6F7174),
                      fontSize: isTablet ? 18 : 12,
                      fontFamily: 'Baijam',
                    ),
                  ),
                  TextSpan(
                    text: CurrencyFormatter.formatBalance(widget.balance),
                    style: TextStyle(
                      color: Color(0xFF6F7174),
                      fontSize: isTablet ? 18 : 12,
                      fontFamily: 'Baijam',
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
                  TokenIcon(symbol: widget.tokenSymbol, size: isTablet ? 32 : 24),
                  SizedBox(width: isTablet ? 12 : 8),
                  Text(
                    widget.tokenSymbol ?? '',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFDDE1E1),
                      fontSize: isTablet ? 22 : 18,
                      fontFamily: 'Baijam',
                    ),
                  ),
                  const SizedBox(width: 4),
                  SvgPicture.asset(
                    'assets/dropdown.svg',
                    width: isTablet ? 20 : 16,
                    height: isTablet ? 20 : 16,
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
                      _amountController.selection = TextSelection.collapsed(
                        offset: value.length,
                      );
                    },
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFDDE1E1),
                      fontSize: isTablet ? 32 : 24,
                      fontFamily: 'Baijam',
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      hintText: '0',
                      hintStyle: TextStyle(
                        color: Color(0xFF494949),
                        fontSize: isTablet ? 36 : 24,
                        fontFamily: 'Baijam',
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
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFDDE1E1),
                  fontSize: isTablet ? 36 : 24,
                  fontFamily: 'Baijam',
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
                    padding: EdgeInsets.symmetric(
                      horizontal: isTablet ? 16 : 8,
                      vertical: isTablet ? 8 : 2,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(isTablet ? 20 : 10),
                      border: Border.all(
                        color: const Color(0xFFBFFC59),
                        width: 1,
                      ),
                      color: Colors.transparent,
                    ),
                    child: Text(
                      'MAX',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFBFFC59),
                        fontSize: isTablet ? 18 : 12,
                        fontFamily: 'Baijam',
                      ),
                    ),
                  ),
                ),
              ),
            if (!widget.editable && widget.exchangeRate != null && widget.exchangeRate!.isNotEmpty)
              Text(
                widget.exchangeRate!,
                style: TextStyle(
                  color: Color(0xFF494949),
                  fontSize: isTablet ? 18 : 12,
                  fontFamily: 'Baijam',
                ),
              ),
          ],
        ),
      ],
    );
  }
}
