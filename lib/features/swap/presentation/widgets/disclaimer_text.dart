import 'package:flutter/material.dart';
import '../../../../core/utils/responsive.dart';

class DisclaimerText extends StatelessWidget {
  const DisclaimerText({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Text(
        '* Exchange rates may vary with market changes. Final amounts depend on current rates and are not guaranteed. Users accept the risk of rate fluctuations.' ,
        style: TextStyle(
          color: Color(0xFF494949),
          fontSize: Responsive.isTablet(context) ? 24 : 12,
        ),
        textAlign: TextAlign.left,
      ),
    );
  }
}