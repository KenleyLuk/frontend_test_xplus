import 'package:flutter/material.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../core/constants/colors.dart';

class FeeSection extends StatelessWidget {
  const FeeSection({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Fee:',
          style: TextStyle(
            color: Color(0xFF494949),
            fontSize: Responsive.isTablet(context) ? 24 : 12,
            fontFamily: 'Baijam',
          ),
        ),
        Text(
          'Waived',
          style: TextStyle(
            color: Color(0xFF494949),
            fontSize: Responsive.isTablet(context) ? 24 : 12,
            fontFamily: 'Baijam',
          ),
        ),
      ],
    );
  }
}