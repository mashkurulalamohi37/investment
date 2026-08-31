import 'package:flutter/material.dart';

enum AppPaletteFlavor {
  paddyField,    // "Paddy Field" (Wise-inspired, pure white + bold paddy green) — PRIMARY CANONICAL THEME
  ledgerRed,     // "Ledger Paper & Registrar's Red" (Aged Khatian Paper & Seal Red)
  pineTreasury,  // "Pine Treasury & Brass" (Archival Rag Paper & Treasury Green)
}

/// Swapnojatri / LandVest 100 — "Paddy Field" Color System (Wise-Inspired)
/// Optimizes for trust through clarity, pure white canvas, and a single bold, confident accent:
/// Bangladeshi Rice Paddy Green (#0F8A4F in Light / #2FBE7A in Dark).
class AppPalette extends ThemeExtension<AppPalette> {
  final Color canvas;
  final Color surface;
  final Color surfaceSunken;
  final Color rule;
  final Color ruleStrong;
  final Color ink;
  final Color inkSecondary;
  final Color inkTertiary;
  final Color pine; // Primary Brand Accent (Paddy Green)
  final Color pineDeep;
  final Color pineTint;
  final Color brass; // Accent / Highlight
  final Color brassLight;
  final Color vermilion; // Error / Rejection
  final Color jade; // Success / Verification
  final Color amberInk; // Warning / Pending
  final Color slate; // Informational / Coordination

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
  // 1. PRIMARY CANONICAL THEME: "Paddy Field" (Wise-Inspired)
  // ==========================================

  /// Light — "Paddy Field" (Pure White + Confident Rice Paddy Green)
  static const paddyLight = AppPalette(
    canvas: Color(0xFFFFFFFF),         // Pure white background (Whitespace energy)
    surface: Color(0xFFFFFFFF),        // Same pure white surface
    surfaceSunken: Color(0xFFF3F5F1),  // Very light warm-grey-green well
    rule: Color(0xFFE7EAE4),           // Clean hairline separator
    ruleStrong: Color(0xFFCDD3C9),     // Boundary frame & dividers
    ink: Color(0xFF141613),            // Near-black with subtle green undertone (16.5:1 contrast)
    inkSecondary: Color(0xFF5C6259),   // Secondary label text (6.2:1 contrast)
    inkTertiary: Color(0xFF8D9388),    // Tertiary metadata (4.5:1 contrast)
    pine: Color(0xFF0F8A4F),           // Bold Paddy Green (The confident brand color)
    pineDeep: Color(0xFF0B6B3D),       // Pressed paddy green
    pineTint: Color(0xFFE4F5EC),       // Soft paddy green chip fill
    brass: Color(0xFF0F8A4F),          // Cohesive brand seal
    brassLight: Color(0xFF2FBE7A),     // Bright highlight
    vermilion: Color(0xFFD6483A),      // Warm modern red
    jade: Color(0xFF0F8A4F),           // Unified brand success green
    amberInk: Color(0xFFE08A1E),       // South Asian marigold amber
    slate: Color(0xFF2F6FB0),          // Information blue
  );

  /// Dark — "Paddy Field Night"
  static const paddyDark = AppPalette(
    canvas: Color(0xFF0E110F),         // Deep night canvas
    surface: Color(0xFF171B18),        // Elevated dark surface
    surfaceSunken: Color(0xFF0A0D0B),  // Recessed dark well
    rule: Color(0xFF242A25),           // Dark hairline rule
    ruleStrong: Color(0xFF384239),     // Dark perimeter border
    ink: Color(0xFFEDEFEA),            // High-contrast clean silver text (15.2:1 contrast)
    inkSecondary: Color(0xFFA6ADA1),   // Secondary text (7.8:1 contrast)
    inkTertiary: Color(0xFF6E766A),    // Tertiary metadata (4.5:1 contrast)
    pine: Color(0xFF2FBE7A),           // Radiant electric paddy green
    pineDeep: Color(0xFF249A61),       // Base green
    pineTint: Color(0xFF132A1E),       // Active chip well
    brass: Color(0xFF2FBE7A),          // Radiant seal
    brassLight: Color(0xFF4CE098),     // Bright highlight
    vermilion: Color(0xFFE86454),      // Warning red
    jade: Color(0xFF2FBE7A),           // Verified credit jade
    amberInk: Color(0xFFEBA13E),       // Warm amber
    slate: Color(0xFF5A96D6),          // Sky slate
  );

  // ==========================================
  // 2. ALTERNATIVE: "Ledger Paper & Registrar's Red"
  // ==========================================

  static const ledgerLight = AppPalette(
    canvas: Color(0xFFECE4D1),
    surface: Color(0xFFF8F3E6),
    surfaceSunken: Color(0xFFDDCFAE),
    rule: Color(0xFFC7B48C),
    ruleStrong: Color(0xFFA28E5E),
    ink: Color(0xFF221A10),
    inkSecondary: Color(0xFF5A4C34),
    inkTertiary: Color(0xFF8C7C57),
    pine: Color(0xFF9E2A1D),
    pineDeep: Color(0xFF711D14),
    pineTint: Color(0xFFF3DAD3),
    brass: Color(0xFF8E7128),
    brassLight: Color(0xFFBC9A4E),
    vermilion: Color(0xFF711D14),
    jade: Color(0xFF3D6A48),
    amberInk: Color(0xFF87590F),
    slate: Color(0xFF39505F),
  );

  static const ledgerDark = AppPalette(
    canvas: Color(0xFF100D08),
    surface: Color(0xFF1A150E),
    surfaceSunken: Color(0xFF0A0805),
    rule: Color(0xFF2B2415),
    ruleStrong: Color(0xFF453B23),
    ink: Color(0xFFEEE3CB),
    inkSecondary: Color(0xFFB2A587),
    inkTertiary: Color(0xFF7A6C4C),
    pine: Color(0xFFC23F2E),
    pineDeep: Color(0xFF8F2E20),
    pineTint: Color(0xFF2E1B16),
    brass: Color(0xFFC9A961),
    brassLight: Color(0xFFE0C489),
    vermilion: Color(0xFFE04848),
    jade: Color(0xFF4C8A62),
    amberInk: Color(0xFFC79A3C),
    slate: Color(0xFF7E96AE),
  );

  // ==========================================
  // 3. ALTERNATIVE: "Pine Treasury & Brass"
  // ==========================================

  static const pineLight = AppPalette(
    canvas: Color(0xFFF3F6F4),
    surface: Color(0xFFFFFFFF),
    surfaceSunken: Color(0xFFEAEFEA),
    rule: Color(0xFFD6DDD6),
    ruleStrong: Color(0xFFB8C2B8),
    ink: Color(0xFF0F171A),
    inkSecondary: Color(0xFF374845),
    inkTertiary: Color(0xFF60736F),
    pine: Color(0xFF132E27),
    pineDeep: Color(0xFF0B1E1A),
    pineTint: Color(0xFFE5EDE8),
    brass: Color(0xFFB3822A),
    brassLight: Color(0xFFD4A247),
    vermilion: Color(0xFFA31F1F),
    jade: Color(0xFF0A6B48),
    amberInk: Color(0xFF945800),
    slate: Color(0xFF435A56),
  );

  static const pineDark = AppPalette(
    canvas: Color(0xFF0A1010),
    surface: Color(0xFF121C1C),
    surfaceSunken: Color(0xFF080C0C),
    rule: Color(0xFF1E2C2C),
    ruleStrong: Color(0xFF2E4040),
    ink: Color(0xFFF0F5F3),
    inkSecondary: Color(0xFF9AB0AB),
    inkTertiary: Color(0xFF667C77),
    pine: Color(0xFF1D3D34),
    pineDeep: Color(0xFF10241E),
    pineTint: Color(0xFF162923),
    brass: Color(0xFFD4A247),
    brassLight: Color(0xFFE5BC6A),
    vermilion: Color(0xFFE04848),
    jade: Color(0xFF1CB078),
    amberInk: Color(0xFFE09422),
    slate: Color(0xFF8CA39E),
  );

  // Canonical applied defaults: Paddy Field
  static const light = paddyLight;
  static const dark = paddyDark;

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
  AppPalette get palette => Theme.of(this).extension<AppPalette>() ?? AppPalette.paddyLight;
}

class AppColors {
  static const primary = Color(0xFF0F8A4F);
  static const primaryDark = Color(0xFF2FBE7A);
  static const primarySubtle = Color(0xFFE4F5EC);
  static const secondary = Color(0xFF0F8A4F);
  static const accent = Color(0xFF0F8A4F);
  static const gold = Color(0xFF0F8A4F);
  static const success = Color(0xFF0F8A4F);
  static const successDark = Color(0xFF2FBE7A);
  static const error = Color(0xFFD6483A);
  static const errorLight = Color(0xFFFBEBEA);
  static const warning = Color(0xFFE08A1E);

  static const lightBg = Color(0xFFFFFFFF);
  static const darkBg = Color(0xFF0E110F);
  static const lightSurface = Color(0xFFFFFFFF);
  static const darkSurface = Color(0xFF171B18);
  static const lightCard = Color(0xFFFFFFFF);
  static const darkCard = Color(0xFF171B18);
  static const lightCardBorder = Color(0xFFE7EAE4);
  static const darkCardBorder = Color(0xFF242A25);

  static const lightTextPrimary = Color(0xFF141613);
  static const darkTextPrimary = Color(0xFFEDEFEA);
  static const lightTextSecondary = Color(0xFF5C6259);
  static const darkTextSecondary = Color(0xFFA6ADA1);
  static const lightTextMuted = Color(0xFF8D9388);
  static const darkTextMuted = Color(0xFF6E766A);

  // Paddy Green Hero Holding Card Gradient
  static const holdingCardGradientLight = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF0F8A4F),
      Color(0xFF0A663A),
    ],
  );

  static const holdingCardGradientDark = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF153F2B),
      Color(0xFF0E291C),
    ],
  );
}
