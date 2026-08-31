import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

/// Typography tokens supporting English & Bengali typography, prominent financial numbers and KPIs
class AppTypography {
  AppTypography._();

  static TextStyle displayLarge({bool isDark = false, bool isBangla = false}) {
    final color = isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;
    return isBangla
        ? GoogleFonts.hindSiliguri(fontSize: 32, fontWeight: FontWeight.w700, color: color, height: 1.2)
        : GoogleFonts.outfit(fontSize: 32, fontWeight: FontWeight.w700, color: color, letterSpacing: -0.5, height: 1.2);
  }

  static TextStyle displayMedium({bool isDark = false, bool isBangla = false}) {
    final color = isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;
    return isBangla
        ? GoogleFonts.hindSiliguri(fontSize: 26, fontWeight: FontWeight.w700, color: color, height: 1.25)
        : GoogleFonts.outfit(fontSize: 26, fontWeight: FontWeight.w700, color: color, letterSpacing: -0.4, height: 1.25);
  }

  static TextStyle headingLarge({bool isDark = false, bool isBangla = false}) {
    final color = isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;
    return isBangla
        ? GoogleFonts.hindSiliguri(fontSize: 22, fontWeight: FontWeight.w600, color: color)
        : GoogleFonts.outfit(fontSize: 22, fontWeight: FontWeight.w600, color: color, letterSpacing: -0.2);
  }

  static TextStyle headingMedium({bool isDark = false, bool isBangla = false}) {
    final color = isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;
    return isBangla
        ? GoogleFonts.hindSiliguri(fontSize: 18, fontWeight: FontWeight.w600, color: color)
        : GoogleFonts.outfit(fontSize: 18, fontWeight: FontWeight.w600, color: color);
  }

  static TextStyle headingSmall({bool isDark = false, bool isBangla = false}) {
    final color = isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;
    return isBangla
        ? GoogleFonts.hindSiliguri(fontSize: 16, fontWeight: FontWeight.w600, color: color)
        : GoogleFonts.outfit(fontSize: 16, fontWeight: FontWeight.w600, color: color);
  }

  static TextStyle bodyLarge({bool isDark = false, bool isBangla = false}) {
    final color = isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;
    return isBangla
        ? GoogleFonts.hindSiliguri(fontSize: 15, fontWeight: FontWeight.w400, color: color, height: 1.5)
        : GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w400, color: color, height: 1.5);
  }

  static TextStyle bodyMedium({bool isDark = false, bool isBangla = false}) {
    final color = isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;
    return isBangla
        ? GoogleFonts.hindSiliguri(fontSize: 14, fontWeight: FontWeight.w400, color: color, height: 1.45)
        : GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w400, color: color, height: 1.45);
  }

  static TextStyle bodySmall({bool isDark = false, bool isBangla = false}) {
    final color = isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted;
    return isBangla
        ? GoogleFonts.hindSiliguri(fontSize: 12, fontWeight: FontWeight.w400, color: color)
        : GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w400, color: color);
  }

  static TextStyle caption({bool isDark = false, bool isBangla = false}) {
    final color = isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted;
    return isBangla
        ? GoogleFonts.hindSiliguri(fontSize: 11, fontWeight: FontWeight.w500, color: color, letterSpacing: 0.2)
        : GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w500, color: color, letterSpacing: 0.2);
  }

  // Specialized Financial & KPI Typography
  static TextStyle financialAmountLarge({Color? color, bool isDark = false}) {
    return GoogleFonts.outfit(
      fontSize: 32,
      fontWeight: FontWeight.w800,
      color: color ?? (isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary),
      letterSpacing: -0.5,
      height: 1.1,
    );
  }

  static TextStyle financialAmountMedium({Color? color, bool isDark = false}) {
    return GoogleFonts.outfit(
      fontSize: 22,
      fontWeight: FontWeight.w700,
      color: color ?? (isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary),
      letterSpacing: -0.3,
      height: 1.15,
    );
  }

  static TextStyle financialAmountSmall({Color? color, bool isDark = false}) {
    return GoogleFonts.outfit(
      fontSize: 16,
      fontWeight: FontWeight.w700,
      color: color ?? (isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary),
    );
  }

  static TextStyle kpiLabel({bool isDark = false, bool isBangla = false}) {
    return isBangla
        ? GoogleFonts.hindSiliguri(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted,
          )
        : GoogleFonts.inter(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.3,
            color: isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted,
          );
  }
}
