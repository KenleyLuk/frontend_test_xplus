import 'package:flutter/material.dart';

class DisclaimerText extends StatelessWidget {
  const DisclaimerText({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Text(
      '* Exchange rates may vary with market changes. Final\n'
      'amounts depend on current rates and are not guaranteed.\n'
      'Users accept the risk of rate fluctuations.',
      style: TextStyle(color: Color(0xFF494949), fontSize: 12),
      textAlign: TextAlign.left,
    );
  }
}