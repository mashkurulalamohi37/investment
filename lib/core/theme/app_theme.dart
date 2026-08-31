import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app_colors.dart';
import 'app_radius.dart';

class AppTheme {
  static ThemeData light() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppPalette.light.canvas,
      extensions: const [AppPalette.light],
      colorScheme: ColorScheme.light(
        primary: AppPalette.light.pine,
        surface: AppPalette.light.surface,
        onPrimary: AppPalette.light.canvas,
        onSurface: AppPalette.light.ink,
        outline: AppPalette.light.rule,
        outlineVariant: AppPalette.light.ruleStrong,
        error: AppPalette.light.vermilion,
      ),
      dividerTheme: DividerThemeData(
        color: AppPalette.light.rule,
        thickness: 1.0,
        space: 1.0,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: AppPalette.light.canvas,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        iconTheme: IconThemeData(color: AppPalette.light.ink, size: 20),
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      cardTheme: CardThemeData(
        color: AppPalette.light.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: AppRadius.borderCard,
          side: BorderSide(color: AppPalette.light.rule, width: 1.0),
        ),
      ),
    );
  }

  static ThemeData dark() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppPalette.dark.canvas,
      extensions: const [AppPalette.dark],
      colorScheme: ColorScheme.dark(
        primary: AppPalette.dark.pine,
        surface: AppPalette.dark.surface,
        onPrimary: AppPalette.dark.ink,
        onSurface: AppPalette.dark.ink,
        outline: AppPalette.dark.rule,
        outlineVariant: AppPalette.dark.ruleStrong,
        error: AppPalette.dark.vermilion,
      ),
      dividerTheme: DividerThemeData(
        color: AppPalette.dark.rule,
        thickness: 1.0,
        space: 1.0,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: AppPalette.dark.canvas,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        iconTheme: IconThemeData(color: AppPalette.dark.ink, size: 20),
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      cardTheme: CardThemeData(
        color: AppPalette.dark.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: AppRadius.borderCard,
          side: BorderSide(color: AppPalette.dark.rule, width: 1.0),
        ),
      ),
    );
  }
}
