import 'package:flutter/material.dart';

enum AppPaletteFlavor {
  royalBlue,     // "Royal Cobalt Blue" (Swapnojatri Official Brand Theme)
  paddyField,    // Legacy alias
  ledgerRed,
  pineTreasury,
}

/// Swapnojatri Official Color System
/// Optimizes for clarity, trust, and vibrant modern mobile banking aesthetics:
/// Royal Cobalt Blue (#0066FF / #0052CC) + Deep Navy (#0A2540) + Sky Cyan (#00B4D8) + Success Green (#00C853)
class AppPalette extends ThemeExtension<AppPalette> {
  final Color canvas;
  final Color surface;
  final Color surfaceSunken;
  final Color rule;
  final Color ruleStrong;
  final Color ink;
  final Color inkSecondary;
  final Color inkTertiary;
  final Color pine; // Primary Brand Royal Blue
  final Color pineDeep; // Deep Navy / Indigo
  final Color pineTint; // Soft Blue Chip Well
  final Color brass; // Sky Cyan / Electric Accent
  final Color brassLight; // Bright Cyan Accent
  final Color vermilion; // Error / Rejection Red
  final Color jade; // Success Profit Green (#00C853)
  final Color amberInk; // Warning / Pending Amber
  final Color slate; // Information Blue

  const AppPalette({
    required this.canvas,
    required this.surface,
    required this.surfaceSunken,
    required this.rule,
    required this.ruleStrong,
    required this.ink,
    required this.inkSecondary,
    required this.inkTertiary,
    required this.pine,
    required this.pineDeep,
    required this.pineTint,
    required this.brass,
    required this.brassLight,
    required this.vermilion,
    required this.jade,
    required this.amberInk,
    required this.slate,
  });

  // ==========================================
  // 1. PRIMARY THEME: Royal Cobalt Blue System (Swapnojatri Spec)
  // ==========================================

  /// Light — Royal Blue & Clean Slate
  static const royalBlueLight = AppPalette(
    canvas: Color(0xFFF8FAFC),         // Soft modern Slate-50 canvas
    surface: Color(0xFFFFFFFF),        // Crisp pure white cards and sheets
    surfaceSunken: Color(0xFFF1F5F9),  // Soft sunken well (Slate-100)
    rule: Color(0xFFE2E8F0),           // Slate-200 hairline border
    ruleStrong: Color(0xFFCBD5E1),     // Slate-300 boundary frame
    ink: Color(0xFF0F172A),            // Slate-900 high-contrast primary text
    inkSecondary: Color(0xFF64748B),   // Slate-500 secondary labels
    inkTertiary: Color(0xFF94A3B8),    // Slate-400 metadata
    pine: Color(0xFF0066FF),           // Vibrant Royal Cobalt Blue
    pineDeep: Color(0xFF0A2540),       // Deep Midnight Navy
    pineTint: Color(0xFFEBF3FF),       // Soft Royal Blue Chip Tint
    brass: Color(0xFF00B4D8),          // Sky Cyan Accent
    brassLight: Color(0xFF48CAE4),     // Bright Cyan Highlight
    vermilion: Color(0xFFEF4444),      // Modern Coral Red
    jade: Color(0xFF00C853),           // Profit / Success Green
    amberInk: Color(0xFFF59E0B),       // Amber Warning
    slate: Color(0xFF0066FF),          // Primary Info Blue
  );

  /// Dark — Deep Midnight Navy System
  static const royalBlueDark = AppPalette(
    canvas: Color(0xFF0A1118),         // Deep midnight canvas
    surface: Color(0xFF131D28),        // Elevated navy surface
    surfaceSunken: Color(0xFF0D151F),  // Recessed dark well
    rule: Color(0xFF1E2D3D),           // Dark hairline rule
    ruleStrong: Color(0xFF2C3E52),     // Dark perimeter border
    ink: Color(0xFFF8FAFC),            // High-contrast clean white text
    inkSecondary: Color(0xFF94A3B8),   // Secondary text
    inkTertiary: Color(0xFF64748B),    // Tertiary metadata
    pine: Color(0xFF2979FF),           // Radiant electric blue
    pineDeep: Color(0xFF0052CC),       // Deep brand blue
    pineTint: Color(0xFF132338),       // Active chip well
    brass: Color(0xFF00B4D8),          // Sky Cyan
    brassLight: Color(0xFF48CAE4),     // Bright highlight
    vermilion: Color(0xFFF87171),      // Warning red
    jade: Color(0xFF00E676),           // Verified credit jade
    amberInk: Color(0xFFFBBF24),       // Warm amber
    slate: Color(0xFF38BDF8),          // Sky slate
  );

  // Backward compatibility aliases
  static const paddyLight = royalBlueLight;
  static const paddyDark = royalBlueDark;
  static const ledgerLight = royalBlueLight;
  static const ledgerDark = royalBlueDark;
  static const pineLight = royalBlueLight;
  static const pineDark = royalBlueDark;

  @override
  AppPalette copyWith({
    Color? canvas,
    Color? surface,
    Color? surfaceSunken,
    Color? rule,
    Color? ruleStrong,
    Color? ink,
    Color? inkSecondary,
    Color? inkTertiary,
    Color? pine,
    Color? pineDeep,
    Color? pineTint,
    Color? brass,
    Color? brassLight,
    Color? vermilion,
    Color? jade,
    Color? amberInk,
    Color? slate,
  }) {
    return AppPalette(
      canvas: canvas ?? this.canvas,
      surface: surface ?? this.surface,
      surfaceSunken: surfaceSunken ?? this.surfaceSunken,
      rule: rule ?? this.rule,
      ruleStrong: ruleStrong ?? this.ruleStrong,
      ink: ink ?? this.ink,
      inkSecondary: inkSecondary ?? this.inkSecondary,
      inkTertiary: inkTertiary ?? this.inkTertiary,
      pine: pine ?? this.pine,
      pineDeep: pineDeep ?? this.pineDeep,
      pineTint: pineTint ?? this.pineTint,
      brass: brass ?? this.brass,
      brassLight: brassLight ?? this.brassLight,
      vermilion: vermilion ?? this.vermilion,
      jade: jade ?? this.jade,
      amberInk: amberInk ?? this.amberInk,
      slate: slate ?? this.slate,
    );
  }

  @override
  AppPalette lerp(ThemeExtension<AppPalette>? other, double t) {
    if (other is! AppPalette) return this;
    return AppPalette(
      canvas: Color.lerp(canvas, other.canvas, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      surfaceSunken: Color.lerp(surfaceSunken, other.surfaceSunken, t)!,
      rule: Color.lerp(rule, other.rule, t)!,
      ruleStrong: Color.lerp(ruleStrong, other.ruleStrong, t)!,
      ink: Color.lerp(ink, other.ink, t)!,
      inkSecondary: Color.lerp(inkSecondary, other.inkSecondary, t)!,
      inkTertiary: Color.lerp(inkTertiary, other.inkTertiary, t)!,
      pine: Color.lerp(pine, other.pine, t)!,
      pineDeep: Color.lerp(pineDeep, other.pineDeep, t)!,
      pineTint: Color.lerp(pineTint, other.pineTint, t)!,
      brass: Color.lerp(brass, other.brass, t)!,
      brassLight: Color.lerp(brassLight, other.brassLight, t)!,
      vermilion: Color.lerp(vermilion, other.vermilion, t)!,
      jade: Color.lerp(jade, other.jade, t)!,
      amberInk: Color.lerp(amberInk, other.amberInk, t)!,
      slate: Color.lerp(slate, other.slate, t)!,
    );
  }
}

extension AppPaletteContext on BuildContext {
  AppPalette get palette => Theme.of(this).extension<AppPalette>() ?? AppPalette.royalBlueLight;
}

/// Static color constants
class AppColors {
  AppColors._();

  static const royalBlue = Color(0xFF0066FF);
  static const royalBlueDark = Color(0xFF0052CC);
  static const midnightNavy = Color(0xFF0A2540);
  static const skyCyan = Color(0xFF00B4D8);
  static const profitGreen = Color(0xFF00C853);
  static const lightBg = Color(0xFFF8FAFC);
  static const darkBg = Color(0xFF0A1118);
  static const lightTextPrimary = Color(0xFF0F172A);
  static const lightTextSecondary = Color(0xFF64748B);
  static const darkTextPrimary = Color(0xFFF8FAFC);
  static const darkTextSecondary = Color(0xFF94A3B8);
}
