import 'package:flutter/material.dart';

/// Swapnojatri / LandVest 100 — Audited Land Registry & Private Bank Palette
/// Grounded strictly in physical Sub-Registry deeds (দলিল), RS Khatians (খতিয়ান),
/// and institutional Escrow Bank custody.
class AppPalette extends ThemeExtension<AppPalette> {
  final Color canvas;
  final Color surface;
  final Color surfaceSunken;
  final Color rule;
  final Color ruleStrong;
  final Color ink;
  final Color inkSecondary;
  final Color inkTertiary;
  final Color pine; // Primary Institutional Treasury Color
  final Color pineDeep;
  final Color pineTint;
  final Color brass; // Precious Accent: Reserved strictly for seals and lot center dot
  final Color brassLight;
  final Color vermilion; // Rejection/Error strictly
  final Color jade; // Audited Credit/Success strictly
  final Color amberInk; // Escrow Pending strictly
  final Color slate; // Cadastral Survey tag

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

  /// Light — "Day Sheet" (Archival Dolil Deed Paper & Iron-Gall Ink)
  static const light = AppPalette(
    canvas: Color(0xFFF3F6F4),         // Unbleached archival rag paper (75% of UI)
    surface: Color(0xFFFFFFFF),        // Printed parcel sheet / card folio
    surfaceSunken: Color(0xFFEAEFEA),  // Survey map grid ground & ledger audit well
    rule: Color(0xFFD6DDD6),           // 1pt zinc ruling hairline divider
    ruleStrong: Color(0xFFB8C2B8),     // Boundary perimeter frame
    ink: Color(0xFF0F171A),            // Iron-gall judicial record ink (17.8:1 contrast)
    inkSecondary: Color(0xFF374845),   // Secondary survey dimension text (7.2:1 contrast)
    inkTertiary: Color(0xFF60736F),    // RS Khatian volume & hash stamp (4.6:1 contrast)
    pine: Color(0xFF132E27),           // Treasury Registry Slate-Green (Institutional Trust)
    pineDeep: Color(0xFF0B1E1A),       // Vault shadow base
    pineTint: Color(0xFFE5EDE8),       // Selected lot tint
    brass: Color(0xFFB3822A),          // Burnished Brass (Seals & Lot dot ONLY)
    brassLight: Color(0xFFD4A247),     // Highlight foil
    vermilion: Color(0xFFA31F1F),      // Sub-Registry Rejection Crimson ONLY (6.8:1)
    jade: Color(0xFF0A6B48),           // Audited Escrow Jade strictly for dividends (5.6:1)
    amberInk: Color(0xFF945800),       // Escrow pending disclosure (5.1:1)
    slate: Color(0xFF435A56),          // Cadastral coordinate label
  );

  /// Dark — "Night Ledger" (Vault Slate & Engraved Silver)
  static const dark = AppPalette(
    canvas: Color(0xFF0A1010),         // Deep carbon vault interior (zero colored shadow)
    surface: Color(0xFF121C1C),        // Elevated dark ledger folio
    surfaceSunken: Color(0xFF080C0C),  // Recessed survey map canvas
    rule: Color(0xFF1E2C2C),           // Dark hairline zinc rule
    ruleStrong: Color(0xFF2E4040),     // Dark perimeter border
    ink: Color(0xFFF0F5F3),            // Engraved silver text (14.6:1 contrast)
    inkSecondary: Color(0xFF9AB0AB),   // High-contrast secondary text (7.1:1 contrast)
    inkTertiary: Color(0xFF667C77),    // Dark metadata & hashes (4.5:1 contrast)
    pine: Color(0xFF1D3D34),           // Illuminated treasury spruce
    pineDeep: Color(0xFF10241E),       // Base spruce
    pineTint: Color(0xFF162923),       // Active chip well
    brass: Color(0xFFD4A247),          // Radiant brass wax seal
    brassLight: Color(0xFFE5BC6A),     // Bright seal highlight
    vermilion: Color(0xFFE04848),      // Rejected alert
    jade: Color(0xFF1CB078),           // Verified credit jade
    amberInk: Color(0xFFE09422),       // Warning amber
    slate: Color(0xFF8CA39E),          // Dark coordinate text
  );

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
  AppPalette get palette => Theme.of(this).extension<AppPalette>() ?? AppPalette.light;
}

class AppColors {
  static const primary = Color(0xFF132E27);
  static const primaryDark = Color(0xFF1D3D34);
  static const primarySubtle = Color(0xFFE5EDE8);
  static const secondary = Color(0xFFB3822A);
  static const accent = Color(0xFFB3822A);
  static const gold = Color(0xFFB3822A);
  static const success = Color(0xFF0A6B48);
  static const successDark = Color(0xFF1CB078);
  static const error = Color(0xFFA31F1F);
  static const errorLight = Color(0xFFFDE8E8);
  static const warning = Color(0xFF945800);

  static const lightBg = Color(0xFFF3F6F4);
  static const darkBg = Color(0xFF0A1010);
  static const lightSurface = Color(0xFFFFFFFF);
  static const darkSurface = Color(0xFF121C1C);
  static const lightCard = Color(0xFFFFFFFF);
  static const darkCard = Color(0xFF121C1C);
  static const lightCardBorder = Color(0xFFD6DDD6);
  static const darkCardBorder = Color(0xFF1E2C2C);

  static const lightTextPrimary = Color(0xFF0F171A);
  static const darkTextPrimary = Color(0xFFF0F5F3);
  static const lightTextSecondary = Color(0xFF374845);
  static const darkTextSecondary = Color(0xFF9AB0AB);
  static const lightTextMuted = Color(0xFF60736F);
  static const darkTextMuted = Color(0xFF667C77);

  // The one permitted subtle 4% architectural vertical gradient (§4)
  static const holdingCardGradientLight = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF132E27),
      Color(0xFF0B1E1A),
    ],
  );

  static const holdingCardGradientDark = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF142923),
      Color(0xFF0D1B17),
    ],
  );
}
