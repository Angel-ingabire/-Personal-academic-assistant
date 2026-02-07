import 'package:flutter/material.dart';

/// ALU-branded color palette matching the UI design screens.
class AppColors {
  // Primary ALU colors (from design spec)
  static const Color aluRed = Color(0xFFAE2828);
  static const Color charcoal = Color(0xFF1E1917);

  // Background colors (dark navy blue theme to match screenshots)
  static const Color background = Color(0xFF0D1B2A); // Dark navy blue – app background, app bar, bottom nav
  static const Color cardBackground = Colors.white; // White cards for content
  static const Color darkCardBackground = Color(0xFF1B263B); // Dark blue – summary cards (e.g. Active Projects)

  // Text colors
  static const Color textPrimary = Colors.white;
  static const Color textSecondary = Color(0xFFB0B8C4);
  static const Color textDark = Color(0xFF1E1917); // For text on white cards

  // Accent colors
  static const Color accentYellow = Color(0xFFFACC15); // Bright yellow for buttons/accents
  static const Color warningRed = aluRed; // Red for warnings/at-risk indicators
  static const Color successGreen = Color(0xFF16A34A);

  // Border and divider colors
  static const Color borderGrey = Color(0xFF374151);
  static const Color dividerGrey = Color(0xFFE5E7EB);

  // Navigation
  static const Color bottomNavInactive = Color(0xFF6B7280);
  static const Color bottomNavActive = accentYellow; // Yellow for active tab
}

