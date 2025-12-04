import 'package:flutter/material.dart';
import '../constants/breakpoint.dart';
import '../constants/spacing.dart';

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
    return isTablet(context) ? 56.0 : 24.0;
  }
  
  // 平板電腦標籤字體大小
  static double getLabelFontSize(BuildContext context) {
    return isTablet(context) ? 28.0 : 24.0;
  }

  static double getButtonHeight(BuildContext context) {
    return isTablet(context) ? 96.0 : 56.0;
  }
  
  static double getButtonFontSize(BuildContext context) {
    return isTablet(context) ? 32.0 : 16.0;
  }
  
  // 限制 tablet寬度
  static double? getButtonMaxWidth(BuildContext context) {
    return isTablet(context) ? 600.0 : null; 
  }
}