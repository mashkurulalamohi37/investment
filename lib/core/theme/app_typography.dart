import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

/// Institutional Typography Engine (§5 of Khatian Specification)
/// Figures & Display: Source Serif 4 / Noto Serif Bengali
/// Interface & Body: Archivo / Anek Bangla
class AppTypography {
  // Tabular & Lining features for financial number consistency
  static const List<FontFeature> tabularFontFeatures = [
    FontFeature.tabularFigures(),
    FontFeature.liningFigures(),
  ];

  static TextStyle _serifStyle({
    required double fontSize,
    required FontWeight fontWeight,
    required double height,
    required double tracking,
    required bool isBangla,
    Color? color,
  }) {
    final effectiveColor = color;
    final effectiveHeight = isBangla ? height + 0.20 : height;
    final effectiveTracking = isBangla ? 0.0 : tracking;

    if (isBangla) {
      return GoogleFonts.notoSerifBengali(
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

    return GoogleFonts.sourceSerif4(
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

  static TextStyle _sansStyle({
    required double fontSize,
    required FontWeight fontWeight,
    required double height,
    required double tracking,
    required bool isBangla,
    Color? color,
  }) {
    final effectiveColor = color;
    final effectiveHeight = isBangla ? height + 0.20 : height;
    final effectiveTracking = isBangla ? 0.0 : tracking;

    if (isBangla) {
      return GoogleFonts.anekBangla(
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

    return GoogleFonts.archivo(
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

  static TextStyle amountHero({bool isDark = false, bool isBangla = false, Color? color}) => _serifStyle(
        fontSize: 34,
        fontWeight: FontWeight.w600,
        height: 1.10,
        tracking: -0.6,
        isBangla: isBangla,
        color: color ?? (isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary),
      );

  static TextStyle amountLarge({bool isDark = false, bool isBangla = false, Color? color}) => _serifStyle(
        fontSize: 26,
        fontWeight: FontWeight.w600,
        height: 1.15,
        tracking: -0.4,
        isBangla: isBangla,
        color: color ?? (isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary),
      );

  static TextStyle amountMedium({bool isDark = false, bool isBangla = false, Color? color}) => _serifStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        height: 1.25,
        tracking: -0.2,
        isBangla: isBangla,
        color: color ?? (isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary),
      );

  static TextStyle amountSmall({bool isDark = false, bool isBangla = false, Color? color}) => _serifStyle(
        fontSize: 15,
        fontWeight: FontWeight.w600,
        height: 1.30,
        tracking: 0.0,
        isBangla: isBangla,
        color: color ?? (isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary),
      );

  static TextStyle titleLarge({bool isDark = false, bool isBangla = false, Color? color}) => _serifStyle(
        fontSize: 23,
        fontWeight: FontWeight.w500,
        height: 1.25,
        tracking: -0.3,
        isBangla: isBangla,
        color: color ?? (isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary),
      );

  static TextStyle titleMedium({bool isDark = false, bool isBangla = false, Color? color}) => _serifStyle(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        height: 1.30,
        tracking: -0.1,
        isBangla: isBangla,
        color: color ?? (isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary),
      );

  static TextStyle sectionLabel({bool isDark = false, bool isBangla = false, Color? color}) => _sansStyle(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        height: 1.35,
        tracking: 0.0,
        isBangla: isBangla,
        color: color ?? (isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary),
      );

  static TextStyle body({bool isDark = false, bool isBangla = false, Color? color}) => _sansStyle(
        fontSize: 15,
        fontWeight: FontWeight.w400,
        height: 1.50,
        tracking: 0.0,
        isBangla: isBangla,
        color: color ?? (isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary),
      );

  static TextStyle bodyStrong({bool isDark = false, bool isBangla = false, Color? color}) => _sansStyle(
        fontSize: 15,
        fontWeight: FontWeight.w500,
        height: 1.50,
        tracking: 0.0,
        isBangla: isBangla,
        color: color ?? (isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary),
      );

  static TextStyle caption({bool isDark = false, bool isBangla = false, Color? color}) => _sansStyle(
        fontSize: 12.5,
        fontWeight: FontWeight.w500,
        height: 1.40,
        tracking: 0.0,
        isBangla: isBangla,
        color: color ?? (isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary),
      );

  static TextStyle micro({bool isDark = false, bool isBangla = false, Color? color}) => _sansStyle(
        fontSize: 11.5,
        fontWeight: FontWeight.w500,
        height: 1.35,
        tracking: 0.0,
        isBangla: isBangla,
        color: color ?? (isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted),
      );

  static TextStyle mapTick({bool isDark = false, Color? color}) => GoogleFonts.archivo(
        fontSize: 9.5,
        fontWeight: FontWeight.w500,
        height: 1.0,
        letterSpacing: 0.2,
        color: color ?? (isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted),
      ).copyWith(leadingDistribution: TextLeadingDistribution.even);

  // --- Compatibility Aliases ---
  static TextStyle headingLarge({bool isDark = false, bool isBangla = false, Color? color}) => titleLarge(isDark: isDark, isBangla: isBangla, color: color);
  static TextStyle headingMedium({bool isDark = false, bool isBangla = false, Color? color}) => titleMedium(isDark: isDark, isBangla: isBangla, color: color);
  static TextStyle headingSmall({bool isDark = false, bool isBangla = false, Color? color}) => sectionLabel(isDark: isDark, isBangla: isBangla, color: color);
  static TextStyle bodyMedium({bool isDark = false, bool isBangla = false, Color? color}) => body(isDark: isDark, isBangla: isBangla, color: color);
  static TextStyle bodySmall({bool isDark = false, bool isBangla = false, Color? color}) => caption(isDark: isDark, isBangla: isBangla, color: color);
  static TextStyle financialAmountLarge({bool isDark = false, bool isBangla = false, Color? color}) => amountHero(isDark: isDark, isBangla: isBangla, color: color);
  static TextStyle financialAmountMedium({bool isDark = false, bool isBangla = false, Color? color}) => amountLarge(isDark: isDark, isBangla: isBangla, color: color);
  static TextStyle financialAmountSmall({bool isDark = false, bool isBangla = false, Color? color}) => amountSmall(isDark: isDark, isBangla: isBangla, color: color);
  static TextStyle kpiLabel({bool isDark = false, bool isBangla = false}) => caption(isDark: isDark, isBangla: isBangla);
}
