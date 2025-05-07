import 'package:flutter/material.dart';

class AppColors {
  // Primary and accent colors
  static const Color primary =
      Color(0xFF2196F3); // Blue - keeping the same primary color
  static const Color secondary =
      Color(0xFF607D8B); // BlueGrey - keeping the same secondary

  // Background colors - changed to light variants
  static const Color background = Color(0xFFF5F7FA); // Light gray background
  static const Color cardBackground = Colors.white; // White card background

  // Text colors - inverted from dark theme
  static const Color textPrimary =
      Color(0xFF2D3748); // Dark gray for primary text
  static const Color textSecondary =
      Color(0xFF718096); // Medium gray for secondary text

  // Status colors - kept the same but slightly adjusted for light theme visibility
  static const Color error =
      Color(0xFFE53E3E); // Slightly darker red for better visibility
  static const Color success = Color(0xFF38A169); // Slightly darker green
  static const Color warning = Color(0xFFED8936); // Slightly darker orange

  // Additional colors for light theme
  static const Color border = Color(0xFFE2E8F0); // Light gray border color
  static const Color divider = Color(0xFFEDF2F7); // Very light gray divider
  static const Color hover = Color(0xFFF7FAFC); // Hover state background
}
