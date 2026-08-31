import 'package:flutter/material.dart';

/// Semantic color tokens for Swapnojatri Investment Platform
class AppColors {
  AppColors._();

  // Primary Fintech Brand (Deep Emerald & Midnight Forest)
  static const Color primaryDark = Color(0xFF062319);
  static const Color primary = Color(0xFF0D3B2E);
  static const Color primaryMedium = Color(0xFF14533D);
  static const Color primaryLight = Color(0xFF1D7053);
  static const Color primarySubtle = Color(0xFFE6F4EE);

  // Secondary Accent (Champagne Gold / Warm Brass)
  static const Color accentGold = Color(0xFFD4AF37);
  static const Color accentGoldLight = Color(0xFFF3E5AB);
  static const Color accentGoldDark = Color(0xFF997A15);
  static const Color accentGoldMuted = Color(0xFFFAF4DE);

  // Status & Financial Indicators
  static const Color success = Color(0xFF10B981);
  static const Color successDark = Color(0xFF047857);
  static const Color successLight = Color(0xFFD1FAE5);
  
  static const Color warning = Color(0xFFF59E0B);
  static const Color warningDark = Color(0xFFB45309);
  static const Color warningLight = Color(0xFFFEF3C7);
  
  static const Color error = Color(0xFFEF4444);
  static const Color errorDark = Color(0xFFB91C1C);
  static const Color errorLight = Color(0xFFFEE2E2);
  
  static const Color info = Color(0xFF3B82F6);
  static const Color infoDark = Color(0xFF1D4ED8);
  static const Color infoLight = Color(0xFFDBEAFE);

  // Light Mode Surfaces & Neutrals
  static const Color lightBg = Color(0xFFF8FAFC);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightCard = Color(0xFFFFFFFF);
  static const Color lightCardBorder = Color(0xFFE2E8F0);
  static const Color lightDivider = Color(0xFFF1F5F9);

  // Light Mode Typography
  static const Color lightTextPrimary = Color(0xFF0F172A);
  static const Color lightTextSecondary = Color(0xFF475569);
  static const Color lightTextMuted = Color(0xFF94A3B8);
  static const Color lightTextInverse = Color(0xFFFFFFFF);

  // Dark Mode Surfaces & Neutrals
  static const Color darkBg = Color(0xFF070E13);
  static const Color darkSurface = Color(0xFF0F1A22);
  static const Color darkCard = Color(0xFF14242F);
  static const Color darkCardBorder = Color(0xFF1E3847);
  static const Color darkDivider = Color(0xFF1A2E3B);

  // Dark Mode Typography
  static const Color darkTextPrimary = Color(0xFFF8FAFC);
  static const Color darkTextSecondary = Color(0xFFCBD5E1);
  static const Color darkTextMuted = Color(0xFF64748B);
  static const Color darkTextInverse = Color(0xFF0F172A);

  // Gradients
  static const LinearGradient heroGradientDark = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF0A2B20),
      Color(0xFF081813),
      Color(0xFF040E0A),
    ],
  );

  static const LinearGradient heroGradientLight = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF0D3B2E),
      Color(0xFF14533D),
      Color(0xFF0A261D),
    ],
  );

  static const LinearGradient goldGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFF59E0B),
      Color(0xFFD4AF37),
      Color(0xFFB45309),
    ],
  );

  static const LinearGradient emeraldGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF10B981),
      Color(0xFF059669),
    ],
  );
}
