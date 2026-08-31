import 'package:flutter/material.dart';

/// Sovereign Private Wealth & Land Registry Palette
/// Replaces generic AI-green with Majestic Obsidian Navy & Champagne Gold
class AppPalette extends ThemeExtension<AppPalette> {
  final Color canvas;
  final Color surface;
  final Color surfaceSunken;
  final Color rule;
  final Color ruleStrong;
  final Color ink;
  final Color inkSecondary;
  final Color inkTertiary;
  final Color pine; // Sovereign Obsidian Navy (Primary Brand Token)
  final Color pineDeep;
  final Color pineTint;
  final Color brass; // Warm Champagne Gold (Heritage Accent Token)
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

  /// Light — Royal Silk Ivory & Sovereign Obsidian Navy
  static const light = AppPalette(
    canvas: Color(0xFFF7F9FC),         // Luminous warm porcelain silk
    surface: Color(0xFFFFFFFF),        // Crisp pure porcelain surface
    surfaceSunken: Color(0xFFEEF2F6),  // Architectural sunken well
    rule: Color(0xFFE2E8F0),           // Crisp 1px hairline border
    ruleStrong: Color(0xFFCBD5E1),     // Definitive frame border
    ink: Color(0xFF0F172A),            // Deep Obsidian Charcoal — 100% legibility
    inkSecondary: Color(0xFF334155),   // Slate Charcoal for secondary copy
    inkTertiary: Color(0xFF64748B),    // Cool Slate for metadata & timestamps
    pine: Color(0xFF0C192C),           // Sovereign Obsidian Navy (Royal Authority)
    pineDeep: Color(0xFF050D18),       // Deep obsidian base
    pineTint: Color(0xFFEFF4FA),       // Soft porcelain navy tint
    brass: Color(0xFFC59B3F),          // Warm Brushed Champagne Gold
    brassLight: Color(0xFFE4BD68),     // Radiant gold highlight
    vermilion: Color(0xFFDC2626),      // Red alert & rejection
    jade: Color(0xFF059669),           // Verified badge, dividend returns, positive delta
    amberInk: Color(0xFFD97706),       // Warm amber for escrow disclosures
    slate: Color(0xFF475569),          // Legal jurisdiction tags
  );

  /// Dark — Luxury Midnight Obsidian & Radiant Champagne Gold
  static const dark = AppPalette(
    canvas: Color(0xFF070B12),         // Midnight Obsidian Velvet
    surface: Color(0xFF0F1726),        // Elevated Deep Navy Slate
    surfaceSunken: Color(0xFF05080E),  // Sunken dark well
    rule: Color(0xFF1E293B),           // Dark hairline divider
    ruleStrong: Color(0xFF334155),     // Dark strong frame outline
    ink: Color(0xFFF8FAFC),            // Pristine crisp white text
    inkSecondary: Color(0xFF94A3B8),   // High-contrast readable secondary
    inkTertiary: Color(0xFF64748B),    // Legible metadata
    pine: Color(0xFF1E3A5F),           // Radiant Royal Navy / Cobalt
    pineDeep: Color(0xFF0F2238),       // Base navy
    pineTint: Color(0xFF132238),       // Dark navy highlight tint
    brass: Color(0xFFE5B85C),          // Radiant champagne gold
    brassLight: Color(0xFFF2D186),     // Bright gold highlight
    vermilion: Color(0xFFEF4444),      // Red alert
    jade: Color(0xFF10B981),           // Glowing verified jade
    amberInk: Color(0xFFF59E0B),       // Warm gold warning
    slate: Color(0xFF94A3B8),          // Slate tag
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
  static const primary = Color(0xFF0C192C);
  static const primaryDark = Color(0xFF1E3A5F);
  static const primarySubtle = Color(0xFFEFF4FA);
  static const secondary = Color(0xFFC59B3F);
  static const accent = Color(0xFFC59B3F);
  static const gold = Color(0xFFC59B3F);
  static const success = Color(0xFF059669);
  static const successDark = Color(0xFF10B981);
  static const error = Color(0xFFDC2626);
  static const errorLight = Color(0xFFFEE2E2);
  static const warning = Color(0xFFD97706);

  static const lightBg = Color(0xFFF7F9FC);
  static const darkBg = Color(0xFF070B12);
  static const lightSurface = Color(0xFFFFFFFF);
  static const darkSurface = Color(0xFF0F1726);
  static const lightCard = Color(0xFFFFFFFF);
  static const darkCard = Color(0xFF0F1726);
  static const lightCardBorder = Color(0xFFE2E8F0);
  static const darkCardBorder = Color(0xFF1E293B);

  static const lightTextPrimary = Color(0xFF0F172A);
  static const darkTextPrimary = Color(0xFFF8FAFC);
  static const lightTextSecondary = Color(0xFF334155);
  static const darkTextSecondary = Color(0xFF94A3B8);
  static const lightTextMuted = Color(0xFF64748B);
  static const darkTextMuted = Color(0xFF64748B);

  static const holdingCardGradientLight = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF0C192C),
      Color(0xFF162740),
    ],
  );

  static const holdingCardGradientDark = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF0D1829),
      Color(0xFF17283F),
    ],
  );
}
