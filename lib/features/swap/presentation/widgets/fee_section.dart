import 'package:flutter/material.dart';

class FeeSection extends StatelessWidget {
  const FeeSection({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Fee:',
          style: TextStyle(color: Color(0xFF494949), fontSize: 12),
        ),
        Text(
          'Waived',
          style: TextStyle(color: Color(0xFF494949), fontSize: 12),
        ),
      ],
    );
  }
}