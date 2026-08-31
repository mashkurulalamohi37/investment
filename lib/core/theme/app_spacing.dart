import 'package:flutter/material.dart';

/// 4pt Base Spacing Scale (§6 of Khatian Specification)
class AppSpacing {
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 12.0;
  static const double lg = 16.0;
  static const double xl = 20.0;     // Screen horizontal gutter
  static const double xxl = 24.0;
  static const double xxxl = 32.0;   // Section gap
  static const double huge = 40.0;
  static const double giant = 56.0;

  // Semantic Insets
  static const EdgeInsets screenPadding = EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0);
  static const EdgeInsets cardPadding = EdgeInsets.all(16.0);
  static const EdgeInsets cardPaddingLarge = EdgeInsets.all(20.0);
}
