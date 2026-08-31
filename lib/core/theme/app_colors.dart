import 'package:flutter/material.dart';

enum AppPaletteFlavor {
  ledgerRed,     // "Ledger Paper & Registrar's Red" (Aged Khatian Paper & Seal Red)
  pineTreasury,  // "Pine Treasury & Brass" (Archival Rag Paper & Treasury Green)
}

/// Swapnojatri / LandVest 100 — Audited Land Registry & Private Bank Palette
class AppPalette extends ThemeExtension<AppPalette> {
  final Color canvas;
  final Color surface;
  final Color surfaceSunken;
  final Color rule;
  final Color ruleStrong;
  final Color ink;
  final Color inkSecondary;
  final Color inkTertiary;
  final Color pine; // Primary Institutional Color (Treasury Pine OR Registrar Red)
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

  // ==========================================
  // 1. DIRECTION A: "Ledger Paper & Registrar's Red"
  // ==========================================

  /// Light — "Ledger Paper & Registrar's Red"
  static const ledgerLight = AppPalette(
    canvas: Color(0xFFECE4D1),         // Aged kraft/manila paper
    surface: Color(0xFFF8F3E6),        // Fresh khatian ledger sheet
    surfaceSunken: Color(0xFFDDCFAE),  // Stained ledger audit well
    rule: Color(0xFFC7B48C),           // Worn ink-brown hairline
    ruleStrong: Color(0xFFA28E5E),     // Table outer borders & lot frame
    ink: Color(0xFF221A10),            // Iron-gall warm brown ink (15.8:1)
    inkSecondary: Color(0xFF5A4C34),   // Secondary schedule descriptions
    inkTertiary: Color(0xFF8C7C57),    // Metadata, timestamps & ticks
    pine: Color(0xFF9E2A1D),           // Registrar's Red (Institutional Action)
    pineDeep: Color(0xFF711D14),       // Pressed registrar red
    pineTint: Color(0xFFF3DAD3),       // Selected lot tint
    brass: Color(0xFF8E7128),          // Notarial brass wax seal
    brassLight: Color(0xFFBC9A4E),     // Brass highlight ring
    vermilion: Color(0xFF711D14),      // Destructive (outlined only)
    jade: Color(0xFF3D6A48),           // Audited credit/success
    amberInk: Color(0xFF87590F),       // Escrow pending disclosure
    slate: Color(0xFF39505F),          // Cadastral coordinate label
  );

  /// Dark — "Night Registry & Registrar's Red"
  static const ledgerDark = AppPalette(
    canvas: Color(0xFF100D08),         // Deep carbon vault interior
    surface: Color(0xFF1A150E),        // Elevated dark ledger folio
    surfaceSunken: Color(0xFF0A0805),  // Recessed survey map canvas
    rule: Color(0xFF2B2415),           // Dark hairline zinc rule
    ruleStrong: Color(0xFF453B23),     // Dark perimeter border
    ink: Color(0xFFEEE3CB),            // Engraved parchment silver text (14.2:1)
    inkSecondary: Color(0xFFB2A587),   // High-contrast secondary text
    inkTertiary: Color(0xFF7A6C4C),    // Dark metadata & hashes
    pine: Color(0xFFC23F2E),           // Illuminated registrar red
    pineDeep: Color(0xFF8F2E20),       // Base red
    pineTint: Color(0xFF2E1B16),       // Active chip well
    brass: Color(0xFFC9A961),          // Radiant brass wax seal
    brassLight: Color(0xFFE0C489),     // Bright seal highlight
    vermilion: Color(0xFFE04848),      // Rejected alert
    jade: Color(0xFF4C8A62),           // Verified credit jade
    amberInk: Color(0xFFC79A3C),       // Warning amber
    slate: Color(0xFF7E96AE),          // Dark coordinate text
  );

  // ==========================================
  // 2. DIRECTION B: "Pine Treasury & Brass"
  // ==========================================

  /// Light — "Day Sheet" (Archival Rag Paper & Iron-Gall Ink)
  static const pineLight = AppPalette(
    canvas: Color(0xFFF3F6F4),         // Unbleached archival rag paper
    surface: Color(0xFFFFFFFF),        // Printed parcel sheet
    surfaceSunken: Color(0xFFEAEFEA),  // Survey map grid ground
    rule: Color(0xFFD6DDD6),           // 1pt zinc ruling hairline
    ruleStrong: Color(0xFFB8C2B8),     // Boundary perimeter frame
    ink: Color(0xFF0F171A),            // Iron-gall judicial ink (17.8:1)
    inkSecondary: Color(0xFF374845),   // Secondary survey text
    inkTertiary: Color(0xFF60736F),    // Volume & hash stamp
    pine: Color(0xFF132E27),           // Treasury Registry Slate-Green
    pineDeep: Color(0xFF0B1E1A),       // Vault shadow base
    pineTint: Color(0xFFE5EDE8),       // Selected lot tint
    brass: Color(0xFFB3822A),          // Burnished Brass
    brassLight: Color(0xFFD4A247),     // Highlight foil
    vermilion: Color(0xFFA31F1F),      // Rejection Crimson
    jade: Color(0xFF0A6B48),           // Audited Escrow Jade
    amberInk: Color(0xFF945800),       // Escrow pending
    slate: Color(0xFF435A56),          // Cadastral coordinate
  );

  /// Dark — "Night Ledger" (Vault Slate & Engraved Silver)
  static const pineDark = AppPalette(
    canvas: Color(0xFF0A1010),         // Deep carbon vault
    surface: Color(0xFF121C1C),        // Elevated dark folio
    surfaceSunken: Color(0xFF080C0C),  // Recessed map canvas
    rule: Color(0xFF1E2C2C),           // Hairline zinc rule
    ruleStrong: Color(0xFF2E4040),     // Perimeter border
    ink: Color(0xFFF0F5F3),            // Engraved silver text (14.6:1)
    inkSecondary: Color(0xFF9AB0AB),   // High-contrast secondary
    inkTertiary: Color(0xFF667C77),    // Dark metadata
    pine: Color(0xFF1D3D34),           // Illuminated spruce
    pineDeep: Color(0xFF10241E),       // Base spruce
    pineTint: Color(0xFF162923),       // Active chip well
    brass: Color(0xFFD4A247),          // Radiant brass
    brassLight: Color(0xFFE5BC6A),     // Bright highlight
    vermilion: Color(0xFFE04848),      // Rejected alert
    jade: Color(0xFF1CB078),           // Verified jade
    amberInk: Color(0xFFE09422),       // Warning amber
    slate: Color(0xFF8CA39E),          // Dark coordinate
  );

  // Defaults (Active system default)
  static const light = ledgerLight;
  static const dark = ledgerDark;

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
  AppPalette get palette => Theme.of(this).extension<AppPalette>() ?? AppPalette.ledgerLight;
}

class AppColors {
  static const primary = Color(0xFF9E2A1D);
  static const primaryDark = Color(0xFFC23F2E);
  static const primarySubtle = Color(0xFFF3DAD3);
  static const secondary = Color(0xFF8E7128);
  static const accent = Color(0xFF8E7128);
  static const gold = Color(0xFF8E7128);
  static const success = Color(0xFF3D6A48);
  static const successDark = Color(0xFF4C8A62);
  static const error = Color(0xFF711D14);
  static const errorLight = Color(0xFFF3DAD3);
  static const warning = Color(0xFF87590F);

  static const lightBg = Color(0xFFECE4D1);
  static const darkBg = Color(0xFF100D08);
  static const lightSurface = Color(0xFFF8F3E6);
  static const darkSurface = Color(0xFF1A150E);
  static const lightCard = Color(0xFFF8F3E6);
  static const darkCard = Color(0xFF1A150E);
  static const lightCardBorder = Color(0xFFC7B48C);
  static const darkCardBorder = Color(0xFF2B2415);

  static const lightTextPrimary = Color(0xFF221A10);
  static const darkTextPrimary = Color(0xFFEEE3CB);
  static const lightTextSecondary = Color(0xFF5A4C34);
  static const darkTextSecondary = Color(0xFFB2A587);
  static const lightTextMuted = Color(0xFF8C7C57);
  static const darkTextMuted = Color(0xFF7A6C4C);

  // The one permitted subtle 4% architectural vertical gradient (§4)
  static const holdingCardGradientLight = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF8A2419),
      Color(0xFF651A12),
    ],
  );

  static const holdingCardGradientDark = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF9E2A1D),
      Color(0xFF6B1B12),
    ],
  );
}
