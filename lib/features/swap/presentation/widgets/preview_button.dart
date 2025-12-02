import 'package:flutter/material.dart';
import '../../../../core/constants/colors.dart';

class PreviewButton extends StatelessWidget {
  final bool isEnabled;
  
  const PreviewButton({
    Key? key,
    this.isEnabled = true,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: isEnabled
            ? () {
                // TODO: 導航到預覽頁面
                print('Preview pressed');
              }
            : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFFBFFC59),
          foregroundColor: Colors.black,
          disabledBackgroundColor: Colors.grey[800],
          disabledForegroundColor: AppColors.textSecondary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Text(
          'Preview',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}