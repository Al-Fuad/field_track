
import 'package:field_track/core/constant/app_color.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColor.backgroundLight,
      cardColor: AppColor.surfaceLight,
      colorScheme: const ColorScheme.light(
        primary: AppColor.primaryLight,
        secondary: AppColor.primaryLight,
        surface: AppColor.surfaceLight,
        background: AppColor.backgroundLight,
        error: AppColor.dangerTextLight,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColor.backgroundLight,
        elevation: 0,
        iconTheme: IconThemeData(color: AppColor.textPrimaryLight),
        titleTextStyle: TextStyle(
          color: AppColor.textPrimaryLight,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      textTheme: const TextTheme(
        headlineLarge: TextStyle(color: AppColor.textPrimaryLight, fontSize: 28, fontWeight: FontWeight.bold),
        titleLarge: TextStyle(color: AppColor.textPrimaryLight, fontSize: 20, fontWeight: FontWeight.w600),
        bodyLarge: TextStyle(color: AppColor.textPrimaryLight, fontSize: 16),
        bodyMedium: TextStyle(color: AppColor.textSecondaryLight, fontSize: 14),
        labelLarge: TextStyle(color: AppColor.textPrimaryLight, fontSize: 14, fontWeight: FontWeight.w500),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColor.surfaceLight,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        labelStyle: const TextStyle(color: AppColor.textSecondaryLight),
        hintStyle: const TextStyle(color: AppColor.textSecondaryLight),
        prefixIconColor: AppColor.textSecondaryLight,
        suffixIconColor: AppColor.textSecondaryLight,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColor.borderLight),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColor.borderLight),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColor.primaryLight, width: 2),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColor.primaryLight,
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 56),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          elevation: 0,
        ),
      ),
      sliderTheme: const SliderThemeData(
        activeTrackColor: AppColor.primaryLight,
        inactiveTrackColor: AppColor.borderLight,
        thumbColor: AppColor.primaryLight,
        overlayColor: Color(0x1F0D9488),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) return Colors.white;
          return Colors.grey;
        }),
        trackColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) return AppColor.primaryLight;
          return AppColor.borderLight;
        }),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColor.surfaceLight,
        selectedItemColor: AppColor.primaryLight,
        unselectedItemColor: AppColor.textSecondaryLight,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),
    );
  }
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColor.backgroundDark,
      cardColor: AppColor.surfaceDark,
      colorScheme: const ColorScheme.dark(
        primary: AppColor.primaryDark,
        secondary: AppColor.primaryDark,
        surface: AppColor.surfaceDark,
        background: AppColor.backgroundDark,
        error: AppColor.dangerTextDark,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColor.backgroundDark,
        elevation: 0,
        iconTheme: IconThemeData(color: AppColor.textPrimaryDark),
        titleTextStyle: TextStyle(
          color: AppColor.textPrimaryDark,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      textTheme: const TextTheme(
        headlineLarge: TextStyle(color: AppColor.textPrimaryDark, fontSize: 28, fontWeight: FontWeight.bold),
        titleLarge: TextStyle(color: AppColor.textPrimaryDark, fontSize: 20, fontWeight: FontWeight.w600),
        bodyLarge: TextStyle(color: AppColor.textPrimaryDark, fontSize: 16),
        bodyMedium: TextStyle(color: AppColor.textSecondaryDark, fontSize: 14),
        labelLarge: TextStyle(color: AppColor.textPrimaryDark, fontSize: 14, fontWeight: FontWeight.w500),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColor.surfaceDark,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        labelStyle: const TextStyle(color: AppColor.textSecondaryDark),
        hintStyle: const TextStyle(color: AppColor.textSecondaryDark),
        prefixIconColor: AppColor.textSecondaryDark,
        suffixIconColor: AppColor.textSecondaryDark,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColor.borderDark),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColor.borderDark),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColor.primaryDark, width: 2),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColor.primaryDark,
          foregroundColor: AppColor.backgroundDark,
          minimumSize: const Size(double.infinity, 56),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          elevation: 0,
        ),
      ),
      sliderTheme: const SliderThemeData(
        activeTrackColor: AppColor.primaryDark,
        inactiveTrackColor: AppColor.borderDark,
        thumbColor: AppColor.primaryDark,
        overlayColor: Color(0x1F2DD4BF),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) return Colors.white;
          return Colors.grey;
        }),
        trackColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) return AppColor.primaryDark;
          return AppColor.borderDark;
        }),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColor.surfaceDark,
        selectedItemColor: AppColor.primaryDark,
        unselectedItemColor: AppColor.textSecondaryDark,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),
    );
  }
}
