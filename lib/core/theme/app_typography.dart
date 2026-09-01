import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

/// Swapnojatri Typography Engine (Poppins & Hind Siliguri Specification)
class AppTypography {
  static const List<FontFeature> tabularFontFeatures = [
    FontFeature.tabularFigures(),
    FontFeature.liningFigures(),
  ];

  static TextStyle _fontStyle({
    required double fontSize,
    required FontWeight fontWeight,
    required double height,
    required double tracking,
    required bool isBangla,
    Color? color,
  }) {
    final effectiveColor = color;
    final effectiveHeight = isBangla ? height + 0.15 : height;
    final effectiveTracking = isBangla ? 0.0 : tracking;

    if (isBangla) {
      return GoogleFonts.hindSiliguri(
        fontSize: fontSize,
        fontWeight: fontWeight,
        height: effectiveHeight,
        letterSpacing: effectiveTracking,
        color: effectiveColor,
      ).copyWith(
        leadingDistribution: TextLeadingDistribution.even,
        fontFeatures: tabularFontFeatures,
      );
    }

    return GoogleFonts.poppins(
      fontSize: fontSize,
      fontWeight: fontWeight,
      height: effectiveHeight,
      letterSpacing: effectiveTracking,
      color: effectiveColor,
    ).copyWith(
      leadingDistribution: TextLeadingDistribution.even,
      fontFeatures: tabularFontFeatures,
    );
  }

  // --- Scale Tokens ---

  static TextStyle amountHero({bool isDark = false, bool isBangla = false, Color? color}) => _fontStyle(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        height: 1.15,
        tracking: -0.5,
        isBangla: isBangla,
        color: color ?? (isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary),
      );

  static TextStyle amountLarge({bool isDark = false, bool isBangla = false, Color? color}) => _fontStyle(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        height: 1.20,
        tracking: -0.4,
        isBangla: isBangla,
        color: color ?? (isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary),
      );

  static TextStyle amountMedium({bool isDark = false, bool isBangla = false, Color? color}) => _fontStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        height: 1.25,
        tracking: -0.2,
        isBangla: isBangla,
        color: color ?? (isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary),
      );

  static TextStyle amountSmall({bool isDark = false, bool isBangla = false, Color? color}) => _fontStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        height: 1.30,
        tracking: -0.1,
        isBangla: isBangla,
        color: color ?? (isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary),
      );

  static TextStyle titleLarge({bool isDark = false, bool isBangla = false, Color? color}) => _fontStyle(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        height: 1.25,
        tracking: -0.2,
        isBangla: isBangla,
        color: color ?? (isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary),
      );

  static TextStyle titleMedium({bool isDark = false, bool isBangla = false, Color? color}) => _fontStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        height: 1.30,
        tracking: 0.0,
        isBangla: isBangla,
        color: color ?? (isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary),
      );

  static TextStyle body({bool isDark = false, bool isBangla = false, Color? color}) => _fontStyle(
        fontSize: 13.5,
        fontWeight: FontWeight.w400,
        height: 1.45,
        tracking: 0.0,
        isBangla: isBangla,
        color: color ?? (isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary),
      );

  static TextStyle bodyStrong({bool isDark = false, bool isBangla = false, Color? color}) => _fontStyle(
        fontSize: 13.5,
        fontWeight: FontWeight.w600,
        height: 1.40,
        tracking: 0.0,
        isBangla: isBangla,
        color: color ?? (isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary),
      );

  static TextStyle bodySmall({bool isDark = false, bool isBangla = false, Color? color}) => _fontStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        height: 1.40,
        tracking: 0.0,
        isBangla: isBangla,
        color: color ?? (isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary),
      );

  static TextStyle caption({bool isDark = false, bool isBangla = false, Color? color}) => _fontStyle(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        height: 1.35,
        tracking: 0.2,
        isBangla: isBangla,
        color: color ?? (isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary),
      );

  static TextStyle button({bool isDark = false, bool isBangla = false, Color? color}) => _fontStyle(
        fontSize: 14.5,
        fontWeight: FontWeight.w600,
        height: 1.20,
        tracking: 0.2,
        isBangla: isBangla,
        color: color ?? Colors.white,
      );

  static TextStyle headingLarge({bool isDark = false, bool isBangla = false, Color? color}) =>
      amountLarge(isDark: isDark, isBangla: isBangla, color: color);

  static TextStyle headingMedium({bool isDark = false, bool isBangla = false, Color? color}) =>
      titleLarge(isDark: isDark, isBangla: isBangla, color: color);

  static TextStyle headingSmall({bool isDark = false, bool isBangla = false, Color? color}) =>
      titleMedium(isDark: isDark, isBangla: isBangla, color: color);

  static TextStyle bodyMedium({bool isDark = false, bool isBangla = false, Color? color}) =>
      body(isDark: isDark, isBangla: isBangla, color: color);

  static TextStyle sectionLabel({bool isDark = false, bool isBangla = false, Color? color}) =>
      caption(isDark: isDark, isBangla: isBangla, color: color);

  static TextStyle micro({bool isDark = false, bool isBangla = false, Color? color}) =>
      caption(isDark: isDark, isBangla: isBangla, color: color);

  static TextStyle financialAmountMedium({bool isDark = false, bool isBangla = false, Color? color}) =>
      amountMedium(isDark: isDark, isBangla: isBangla, color: color);

  static TextStyle financialAmountSmall({bool isDark = false, bool isBangla = false, Color? color}) =>
      amountSmall(isDark: isDark, isBangla: isBangla, color: color);

  static TextStyle badgeLabel({bool isDark = false, bool isBangla = false, Color? color}) =>
      caption(isDark: isDark, isBangla: isBangla, color: color);
}
