import 'package:flutter/material.dart';
import 'package:flutter_ui/core/theme/app_color.dart';

class AppTheme {
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.background,
    primaryColor: AppColors.primary,
    cardColor: AppColors.cardBackground,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.cardBackground,
      elevation: 0,
    ),
  );
}