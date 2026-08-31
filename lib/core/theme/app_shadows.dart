import 'package:flutter/material.dart';

/// Institutional Shadow Tokens (§6 of Khatian Specification)
/// Only 2 tokens. Light mode only. Dark mode has zero shadows.
class AppShadows {
  // Resting: Cards sitting on canvas (paired with 1px rule border)
  static const List<BoxShadow> resting = [
    BoxShadow(
      color: Color.fromRGBO(14, 21, 18, 0.05),
      blurRadius: 2,
      offset: Offset(0, 1),
    ),
  ];

  // Lifted: Bottom sheets, dialogs, certificate preview
  static const List<BoxShadow> lifted = [
    BoxShadow(
      color: Color.fromRGBO(14, 21, 18, 0.13),
      blurRadius: 32,
      offset: Offset(0, 12),
    ),
    BoxShadow(
      color: Color.fromRGBO(14, 21, 18, 0.05),
      blurRadius: 6,
      offset: Offset(0, 2),
    ),
  ];

  // Dark Mode: Zero shadows
  static const List<BoxShadow> none = [];

  // Compatibility aliases
  static const List<BoxShadow> lightCard = resting;
  static const List<BoxShadow> lightHero = resting;
  static const List<BoxShadow> lightModal = lifted;
  static const List<BoxShadow> darkCard = none;
  static const List<BoxShadow> darkHero = none;
  static const List<BoxShadow> darkModal = none;
}
