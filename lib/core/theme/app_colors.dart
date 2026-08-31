import 'package:flutter/material.dart';

/// Institutional Banking & Wealth Management Palette
/// Benchmarked against Swiss/British Private Banking (Revolut Ultra, Wise, Apple Wallet)
class AppColors {
  // Institutional Brand Primary - Deep Oxford Pine
  static const Color primary = Color(0xFF0B281E);
  static const Color primaryDark = Color(0xFF061812);
  static const Color primaryMedium = Color(0xFF134233);
  static const Color primaryLight = Color(0xFF1C5C48);
  static const Color primarySubtle = Color(0xFFEBF5F0);

  // Muted Matte Gold - Institutional Asset Accent (Used sparingly)
  static const Color accentGold = Color(0xFFC59B27);
  static const Color accentGoldLight = Color(0xFFDFBA4C);
  static const Color accentGoldDark = Color(0xFFA07B18);
  static const Color accentGoldMuted = Color(0xFFF7F2E2);

  // Semantic Financial Feedback (Crisp & High Contrast)
  static const Color success = Color(0xFF0D8A5E);
  static const Color successLight = Color(0xFFE6F5EF);
  static const Color successDark = Color(0xFF095C3F);

  static const Color warning = Color(0xFFD97706);
  static const Color warningLight = Color(0xFFFEF3C7);
  static const Color warningDark = Color(0xFFB45309);

  static const Color error = Color(0xFFDC2626);
  static const Color errorLight = Color(0xFFFEE2E2);
  static const Color errorDark = Color(0xFF991B1B);

  static const Color info = Color(0xFF2563EB);
  static const Color infoLight = Color(0xFFEFF6FF);
  static const Color infoDark = Color(0xFF1D4ED8);

  // Crisp Ceramic Light Mode Surfaces
  static const Color lightBg = Color(0xFFF8FAFC);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightCard = Color(0xFFFFFFFF);
  static const Color lightCardBorder = Color(0xFFE2E8F0);
  static const Color lightDivider = Color(0xFFEEF2F6);
  static const Color lightTextPrimary = Color(0xFF0F172A);
  static const Color lightTextSecondary = Color(0xFF475569);
  static const Color lightTextMuted = Color(0xFF94A3B8);

  // Refined Slate Dark Mode Surfaces
  static const Color darkBg = Color(0xFF0B0F14);
  static const Color darkSurface = Color(0xFF111822);
  static const Color darkCard = Color(0xFF151E2B);
  static const Color darkCardBorder = Color(0xFF243242);
  static const Color darkDivider = Color(0xFF1C2736);
  static const Color darkTextPrimary = Color(0xFFF8FAFC);
  static const Color darkTextSecondary = Color(0xFF94A3B8);
  static const Color darkTextMuted = Color(0xFF64748B);

  // Solid Elegant Cards (No AI-vibe neon gradients)
  static const LinearGradient heroGradientLight = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF0B281E), Color(0xFF123D2F)],
  );

  static const LinearGradient heroGradientDark = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF0E1A16), Color(0xFF070D0B)],
  );

  static const LinearGradient goldGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFDFBA4C), Color(0xFFC59B27)],
  );
}
