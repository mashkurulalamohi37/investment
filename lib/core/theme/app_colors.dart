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

  /// Light — "Day sheet"
  static const light = AppPalette(
    canvas: Color(0xFFF3F4F0),         // Cool linen, faint green cast. Never pure white, never cream.
    surface: Color(0xFFFCFCFA),        // Lighter than canvas — elevation is lightness, not shadow.
    surfaceSunken: Color(0xFFEAEBE5),  // Wells: lot map field, table headers, disabled inputs.
    rule: Color(0xFFD6D9D0),           // 1px hairline. The default separator in the entire app.
    ruleStrong: Color(0xFFB7BCB1),     // Table outer borders, lot-map frame, section dividers.
    ink: Color(0xFF0E1512),            // Primary text, primary icons.
    inkSecondary: Color(0xFF4A5551),   // Secondary text, labels, inactive icons.
    inkTertiary: Color(0xFF7D8781),    // Metadata, timestamps, margin ticks, placeholders.
    pine: Color(0xFF12352A),           // Institutional color: primary buttons, hero card, owned lots, matra rules.
    pineDeep: Color(0xFF0A1F18),       // Hero card base, pressed state of pine.
    pineTint: Color(0xFFE3EDE7),       // Selected rows, owned-lot fills at small size, quiet badges.
    brass: Color(0xFF8F7328),          // Seals, certificate borders, lot serial numbers.
    brassLight: Color(0xFFC0A257),     // Seal highlight ring only.
    vermilion: Color(0xFFA6321E),      // Registrar's red. Destructive actions and rejected states only.
    jade: Color(0xFF136B4E),           // Credits, paid dividends, verified.
    amberInk: Color(0xFF8A5E12),       // Pending, awaiting verification, risk notes.
    slate: Color(0xFF33475A),          // Legal and informational tags.
  );

  /// Dark — "Night ledger"
  static const dark = AppPalette(
    canvas: Color(0xFF0C110F),
    surface: Color(0xFF131A17),        // One step lighter than canvas.
    surfaceSunken: Color(0xFF090D0B),  // Darker than canvas for wells — inverted from light mode.
    rule: Color(0xFF1F2A25),
    ruleStrong: Color(0xFF2E3C35),
    ink: Color(0xFFE9ECE7),
    inkSecondary: Color(0xFF9BA6A0),
    inkTertiary: Color(0xFF6B776F),
    pine: Color(0xFF1D4E3D),
    pineDeep: Color(0xFF0F2C22),
    pineTint: Color(0xFF16261F),
    brass: Color(0xFFC9A961),
    brassLight: Color(0xFFE0C489),
    vermilion: Color(0xFFD4614A),
    jade: Color(0xFF3FA07B),
    amberInk: Color(0xFFC79A3C),
    slate: Color(0xFF7E96AE),
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

/// Convenience context extension for accessing the active palette cleanly
extension AppPaletteContext on BuildContext {
  AppPalette get palette =>
      Theme.of(this).extension<AppPalette>() ??
      (Theme.of(this).brightness == Brightness.dark ? AppPalette.dark : AppPalette.light);
}

/// Backward compatibility namespace for static access where BuildContext is not directly available
class AppColors {
  static const Color primary = Color(0xFF12352A);
  static const Color primaryDark = Color(0xFF0A1F18);
  static const Color primaryMedium = Color(0xFF1D4E3D);
  static const Color primaryLight = Color(0xFF2B6B56);
  static const Color primarySubtle = Color(0xFFE3EDE7);

  static const Color accentGold = Color(0xFF8F7328);
  static const Color accentGoldLight = Color(0xFFC0A257);
  static const Color accentGoldDark = Color(0xFF6B551E);
  static const Color accentGoldMuted = Color(0xFFF7F2E2);

  static const Color success = Color(0xFF136B4E);
  static const Color successLight = Color(0xFFE6F5EF);
  static const Color successDark = Color(0xFF0D4B37);

  static const Color warning = Color(0xFF8A5E12);
  static const Color warningLight = Color(0xFFFEF3C7);
  static const Color warningDark = Color(0xFF6B480C);

  static const Color error = Color(0xFFA6321E);
  static const Color errorLight = Color(0xFFFEE2E2);
  static const Color errorDark = Color(0xFF7A2415);

  static const Color info = Color(0xFF33475A);
  static const Color infoLight = Color(0xFFEFF6FF);
  static const Color infoDark = Color(0xFF22303D);

  static const Color lightBg = Color(0xFFF3F4F0);
  static const Color lightSurface = Color(0xFFFCFCFA);
  static const Color lightCard = Color(0xFFFCFCFA);
  static const Color lightCardBorder = Color(0xFFD6D9D0);
  static const Color lightDivider = Color(0xFFD6D9D0);
  static const Color lightTextPrimary = Color(0xFF0E1512);
  static const Color lightTextSecondary = Color(0xFF4A5551);
  static const Color lightTextMuted = Color(0xFF7D8781);

  static const Color darkBg = Color(0xFF0C110F);
  static const Color darkSurface = Color(0xFF131A17);
  static const Color darkCard = Color(0xFF131A17);
  static const Color darkCardBorder = Color(0xFF1F2A25);
  static const Color darkDivider = Color(0xFF1F2A25);
  static const Color darkTextPrimary = Color(0xFFE9ECE7);
  static const Color darkTextSecondary = Color(0xFF9BA6A0);
  static const Color darkTextMuted = Color(0xFF6B776F);

  // The ONLY permitted gradient in the entire application: 6% delta vertical in HoldingCard
  static const LinearGradient holdingCardGradientLight = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFF12352A), Color(0xFF0A1F18)],
  );

  static const LinearGradient holdingCardGradientDark = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFF131A17), Color(0xFF090D0B)],
  );

  // Aliases for compatibility
  static const LinearGradient heroGradientLight = holdingCardGradientLight;
  static const LinearGradient heroGradientDark = holdingCardGradientDark;
  static const LinearGradient goldGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFC0A257), Color(0xFF8F7328)],
  );
}
