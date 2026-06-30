import 'package:flutter/material.dart';
class AppColor {

  // Backgrounds
  static const Color backgroundLight = Color(0xFFF4F6F8);
  static const Color backgroundDark = Color(0xFF0E1521);
  // Surface / Cards
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color surfaceDark = Color(0xFF172030);
  // Primary (Buttons, Active states, etc.)
  static const Color primaryLight = Color(0xFF0D9488); // Deep Teal
  static const Color primaryDark = Color(0xFF2DD4BF);  // Bright Cyan/Mint
  // Text Colors
  static const Color textPrimaryLight = Color(0xFF111827);
  static const Color textSecondaryLight = Color(0xFF6B7280);
  static const Color textPrimaryDark = Color(0xFFFFFFFF);
  static const Color textSecondaryDark = Color(0xFF9CA3AF);
  // Accent / Status Colors
  // Offline Banner
  static const Color offlineBgLight = Color(0xFFFEF3C7);
  static const Color offlineTextLight = Color(0xFFB45309);
  static const Color offlineBgDark = Color(0xFF2D200D);
  static const Color offlineTextDark = Color(0xFFF59E0B);
  // Pending Status
  static const Color pendingBgLight = Color(0xFFFEF3C7);
  static const Color pendingTextLight = Color(0xFFB45309);
  static const Color pendingBgDark = Color(0xFF2D200D);
  static const Color pendingTextDark = Color(0xFFF59E0B);
  // Completed Status
  static const Color completedBgLight = Color(0xFFD1FAE5);
  static const Color completedTextLight = Color(0xFF065F46);
  static const Color completedBgDark = Color(0xFF062F24);
  static const Color completedTextDark = Color(0xFF10B981);
  // Danger / Delete
  static const Color dangerBorderLight = Color(0xFFEF4444);
  static const Color dangerTextLight = Color(0xFFEF4444);
  static const Color dangerBgLight = Color(0xFFFEE2E2);
  
  static const Color dangerBorderDark = Color(0xFFEF4444);
  static const Color dangerTextDark = Color(0xFFF87171);
  static const Color dangerBgDark = Color(0xFF2D1414);
  // Borders
  static const Color borderLight = Color(0xFFE5E7EB);
  static const Color borderDark = Color(0xFF263147);
  
  // Keep legacy names for safety if any other file references them
  static const Color backgroud = backgroundLight;
  static const Color backgroudDark = backgroundDark;
}
