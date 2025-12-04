import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/utils/responsive.dart';
import '../cubit/swap_cubit.dart';
import '../cubit/swap_state.dart';

class PreviewButton extends StatelessWidget {
  final bool isEnabled;
  
  const PreviewButton({
    Key? key,
    this.isEnabled = true,
  }) : super(key: key);

  bool _shouldShowIncorrectOrder(SwapState state) {
    final amount = state.fromAmount;

    // 檢查是否為空
    if (amount.isEmpty || amount == '0') {
      return true;
    }

    if(_hasInvalidFormat(amount)) {
      return true;
    }

    if(state.fromToken != null) {
      final amountValue = double.tryParse(amount);
      if (amountValue != null && amountValue > state.fromToken!.balance) {
        return true;
      }
    }

    final amountValue = double.tryParse(amount);
    if (amountValue == null || amountValue <= 0) {
      return true;
    }

    return false;
  }

  bool _hasInvalidFormat(String value) {
    if (value.isEmpty) return false;

    if (value == '0') return true;

    // 以多個 0 開頭後跟小數點，例如 "00.", "000."
    if (RegExp(r'^0{2,}\.').hasMatch(value)) return true;
    
    // 以小數點開頭後跟多個 0，例如 ".00", ".000"
    if (RegExp(r'^\.0{2,}$').hasMatch(value)) return true;
    
    // 多個 0 開頭但沒有小數點，例如 "00", "000"（但允許單個 "0"）
    if (RegExp(r'^0{2,}$').hasMatch(value)) return true;
    
    // 檢查是否有前導零（例如 "01", "02.5" 等，但不包括 "0.5"）
    if (RegExp(r'^0\d+').hasMatch(value) && !value.startsWith('0.')) {
      return true;
    }

    return false;
  }
  
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SwapCubit, SwapState>(
      builder: (context, state) {
        final isIncorrectOrder = _shouldShowIncorrectOrder(state);

        final isZero = state.fromAmount.isEmpty || 
                       state.fromAmount == '0' || 
                       (double.tryParse(state.fromAmount) ?? 0) == 0;
        
        final buttonText = isIncorrectOrder ? 'Incorrect Order' : 'Preview';
        final backgroundColor = isIncorrectOrder 
            ? const Color(0xFF242424) 
            : const Color(0xFFBFFC59);
        final textColor = isIncorrectOrder 
            ? const Color(0xFF000000) 
            : Colors.black;
        
        final maxWidth = Responsive.getButtonMaxWidth(context);
        
        return Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: maxWidth ?? double.infinity,
            ),
            child: SizedBox(
              width: double.infinity,
              height: Responsive.getButtonHeight(context),
              child: ElevatedButton(
                onPressed: isEnabled && !isZero
                    ? () {}
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: backgroundColor,
                  foregroundColor: textColor,
                  disabledBackgroundColor: isZero 
                      ? const Color(0xFF242424) 
                      : Colors.grey[800],
                  disabledForegroundColor: isZero 
                      ? const Color(0xFF000000) 
                      : AppColors.textSecondary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  buttonText,
                  style: TextStyle(
                    fontSize: Responsive.getButtonFontSize(context),
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Baijam',
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}