import 'package:flutter/material.dart';

/// Swapnojatri / LandVest 100 — Notarial & Audited Motion System
/// Motion is evidence of state change and legal certainty, not decoration.
/// Every animation adheres strictly to a reduced-motion instant fallback.
class AppMotion {
  // 1. Timing Tokens
  static const Duration instant = Duration(milliseconds: 80);    // Tap feedback, micro color shifts (<100ms)
  static const Duration quick = Duration(milliseconds: 160);      // Color/opacity transitions, chip toggles (150-200ms)
  static const Duration standard = Duration(milliseconds: 240);   // Sheet/accordion expansion & reveals (200-250ms)
  static const Duration emphasis = Duration(milliseconds: 320);   // Modal entry & page transitions (300-350ms)
  static const Duration narrative = Duration(milliseconds: 500);  // Horizontal Matra rule drawing (400-600ms)
  static const Duration numberRoll = Duration(milliseconds: 800); // Rare hero portfolio count-up
  static const Duration count = Duration(milliseconds: 800);      // Alias for numberRoll

  // 2. Easing Curves (No bounce/elastic/back-out permitted anywhere)
  static const Cubic enter = Cubic(0.05, 0.70, 0.10, 1.00);        // Decelerate — for elements arriving on screen
  static const Cubic exit = Cubic(0.30, 0.00, 0.80, 0.15);         // Accelerate — for elements leaving
  static const Cubic standardCurve = Cubic(0.20, 0.00, 0.00, 1.00); // Symmetric — for in-place reordering / slider
  static const Cubic draw = Cubic(0.16, 1.00, 0.30, 1.00);         // easeOutQuart — for horizontal Matra line draw

  /// Checks if motion is enabled (enforces legal accessibility requirement)
  static bool isMotionEnabled(BuildContext context) {
    return !MediaQuery.of(context).disableAnimations;
  }

  /// Returns 0ms duration if reduced motion is requested, else [duration]
  static Duration responsiveDuration(BuildContext context, Duration duration) {
    return isMotionEnabled(context) ? duration : Duration.zero;
  }
}
