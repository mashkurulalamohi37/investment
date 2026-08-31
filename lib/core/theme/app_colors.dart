import 'package:flutter/material.dart';

/// Institutional Banking & Land Registry Palette ("The Khatian Concept")
/// Exposes strictly typed tokens via [ThemeExtension<AppPalette>]
class AppPalette extends ThemeExtension<AppPalette> {
  final Color canvas;
  final Color surface;
  final Color surfaceSunken;
  final Color rule;
  final Color ruleStrong;
  final Color ink;
  final Color inkSecondary;
  final Color inkTertiary;
  final Color pine;
  final Color pineDeep;
  final Color pineTint;
  final Color brass;
  final Color brassLight;
  final Color vermilion;
  final Color jade;
  final Color amberInk;
  final Color slate;

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

  /// Light — High-Contrast Royal Architectural Linen & Deep Pine
  static const light = AppPalette(
    canvas: Color(0xFFF8FAF7),         // Crisp, pure warm linen paper with luminous clarity
    surface: Color(0xFFFFFFFF),        // Pure paper white for cards & sheets
    surfaceSunken: Color(0xFFEFF3EE),  // Architectural sunken wells & map fields
    rule: Color(0xFFDCE2DA),           // Crisp, refined 1px hairline border
    ruleStrong: Color(0xFFB8C2B5),     // Architectural frame borders & table dividers
    ink: Color(0xFF0C1612),            // Deep obsidian charcoal — ultra-legible high contrast
    inkSecondary: Color(0xFF32423B),   // Dark pine charcoal for secondary copy (never washed out)
    inkTertiary: Color(0xFF5E6F67),    // Crisp metadata & labels
    pine: Color(0xFF0F3B2E),           // Sovereign Forest Emerald (luxurious institutional depth)
    pineDeep: Color(0xFF072119),       // Base gradient and pressed state
    pineTint: Color(0xFFE8F2EC),       // Soft sage tint for active pills & highlight rows
    brass: Color(0xFFB58A2B),          // Royal heritage gold & engraved seals
    brassLight: Color(0xFFD6AB47),     // Gold highlight ring
    vermilion: Color(0xFFB3261E),      // Registrar's stamp red
    jade: Color(0xFF0D7A55),           // Verified badge, dividend returns, positive delta
    amberInk: Color(0xFF9E6310),       // Pending status, escrow disclosures
    slate: Color(0xFF283E50),          // Legal jurisdiction tags
  );

  /// Dark — Luxury Obsidian Midnight & Glowing Emerald
  static const dark = AppPalette(
    canvas: Color(0xFF080D0B),         // Deep obsidian velvet
    surface: Color(0xFF101915),        // Elevated dark pine slate
    surfaceSunken: Color(0xFF050806),  // Deep sunken well
    rule: Color(0xFF1B2922),           // Subtle dark separator
    ruleStrong: Color(0xFF2A3D34),     // Strong frame outline
    ink: Color(0xFFF7FAF8),            // Pristine, crisp white text
    inkSecondary: Color(0xFFA8B8AF),   // High-contrast readable secondary
    inkTertiary: Color(0xFF72837B),    // Legible metadata
    pine: Color(0xFF1E614B),           // Vibrant luminous emerald
    pineDeep: Color(0xFF0F382C),       // Dark pine base
    pineTint: Color(0xFF132B22),       // Dark pine highlight tint
    brass: Color(0xFFD4AF37),          // Radiant royal gold foil
    brassLight: Color(0xFFE8C868),     // Bright gold highlight
    vermilion: Color(0xFFE05343),      // Red alert
    jade: Color(0xFF22C55E),           // Glowing verified jade
    amberInk: Color(0xFFD99B26),       // Warm gold warning
    slate: Color(0xFF8BA5BF),          // Slate tag
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
  static const primary = Color(0xFF0F3B2E);
  static const primaryDark = Color(0xFF1E614B);
  static const primarySubtle = Color(0xFFE8F2EC);
  static const secondary = Color(0xFFB58A2B);
  static const accent = Color(0xFFB58A2B);
  static const gold = Color(0xFFB58A2B);
  static const success = Color(0xFF0D7A55);
  static const successDark = Color(0xFF22C55E);
  static const error = Color(0xFFB3261E);
  static const errorLight = Color(0xFFFDE8E8);
  static const warning = Color(0xFF9E6310);

  static const lightBg = Color(0xFFF8FAF7);
  static const darkBg = Color(0xFF080D0B);
  static const lightSurface = Color(0xFFFFFFFF);
  static const darkSurface = Color(0xFF101915);
  static const lightCard = Color(0xFFFFFFFF);
  static const darkCard = Color(0xFF101915);
  static const lightCardBorder = Color(0xFFDCE2DA);
  static const darkCardBorder = Color(0xFF1B2922);

  static const lightTextPrimary = Color(0xFF0C1612);
  static const darkTextPrimary = Color(0xFFF7FAF8);
  static const lightTextSecondary = Color(0xFF32423B);
  static const darkTextSecondary = Color(0xFFA8B8AF);
  static const lightTextMuted = Color(0xFF5E6F67);
  static const darkTextMuted = Color(0xFF72837B);

  static const holdingCardGradientLight = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF0F3B2E),
      Color(0xFF09251D),
    ],
  );

  static const holdingCardGradientDark = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF142B23),
      Color(0xFF0B1914),
    ],
  );
}
