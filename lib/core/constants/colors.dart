import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors
  static const Color primaryGreen = Color(0xFFBFFC59);
  static const Color primaryGreenAlt = Color(0xFF00FF88); // Alternative green
  
  // Background Colors
  static const Color darkBackground = Color(0xFF000000);
  static const Color cardBackground = Color(0xFF0F1011);
  static const Color modalBackground = Color(0xFF1F1F1F);
  static const Color buttonBackgroundDark = Color(0xFF242424);
  
  // Text Colors
  static const Color textPrimary = Color(0xFFDDE1E1);
  static const Color textSecondary = Color(0xFF7A7B7B);
  static const Color textTertiary = Color(0xFF494949);
  static const Color textDark = Color(0xFF000000);
  static const Color textWhite = Colors.white;
  
  // Border & Divider Colors
  static const Color borderPrimary = Color(0xFF616363);
  static const Color borderSecondary = Color(0xFF6F7174);
  static const Color divider = Color(0xFF2F3031);
  
  // UI Element Colors
  static const Color dragHandle = Colors.grey; // For modal drag handle
  static const Color transparent = Colors.transparent;
  
  // Helper methods for opacity
  static Color blackWithOpacity(double opacity) => Colors.black.withOpacity(opacity);
  static Color greyWithOpacity(int shade, double opacity) => Colors.grey[shade]!.withOpacity(opacity);
}