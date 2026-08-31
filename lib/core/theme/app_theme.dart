import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app_colors.dart';
import 'app_radius.dart';

class AppTheme {
  static ThemeData light({AppPaletteFlavor flavor = AppPaletteFlavor.ledgerRed}) {
    final palette = flavor == AppPaletteFlavor.ledgerRed
        ? AppPalette.ledgerLight
        : AppPalette.pineLight;

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: palette.canvas,
      extensions: [palette],
      colorScheme: ColorScheme.light(
        primary: palette.pine,
        surface: palette.surface,
        onPrimary: palette.canvas,
        onSurface: palette.ink,
        outline: palette.rule,
        outlineVariant: palette.ruleStrong,
        error: palette.vermilion,
      ),
      dividerTheme: DividerThemeData(
        color: palette.rule,
        thickness: 1.0,
        space: 1.0,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: palette.canvas,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        iconTheme: IconThemeData(color: palette.ink, size: 20),
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      cardTheme: CardThemeData(
        color: palette.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: AppRadius.borderCard,
          side: BorderSide(color: palette.rule, width: 1.0),
        ),
      ),
    );
  }

  static ThemeData dark({AppPaletteFlavor flavor = AppPaletteFlavor.ledgerRed}) {
    final palette = flavor == AppPaletteFlavor.ledgerRed
        ? AppPalette.ledgerDark
        : AppPalette.pineDark;

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: palette.canvas,
      extensions: [palette],
      colorScheme: ColorScheme.dark(
        primary: palette.pine,
        surface: palette.surface,
        onPrimary: palette.ink,
        onSurface: palette.ink,
        outline: palette.rule,
        outlineVariant: palette.ruleStrong,
        error: palette.vermilion,
      ),
      dividerTheme: DividerThemeData(
        color: palette.rule,
        thickness: 1.0,
        space: 1.0,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: palette.canvas,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        iconTheme: IconThemeData(color: palette.ink, size: 20),
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      cardTheme: CardThemeData(
        color: palette.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: AppRadius.borderCard,
          side: BorderSide(color: palette.rule, width: 1.0),
        ),
      ),
    );
  }
}
