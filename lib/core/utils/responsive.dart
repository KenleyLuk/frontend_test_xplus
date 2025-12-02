import 'package:flutter/material.dart';
import '../constants/breakpoint.dart';
import '../constants/spacing.dart';

class Responsive {
  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width <= Breakpoint.mobile;
  }
  
  static double getPadding(BuildContext context) {
    return isMobile(context) ? AppSpacing.md : AppSpacing.lg;
  }
  
  static double getCardPadding(BuildContext context) {
    return isMobile(context) ? 20.0 : 32.0;
  }
}