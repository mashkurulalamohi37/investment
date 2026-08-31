import 'package:flutter/material.dart';

/// Institutional Motion System (§8 of Khatian Specification)
/// Motion is evidence, not decoration. Only 4 distinct moments are permitted to animate.
class AppMotion {
  // Durations
  static const Duration instant = Duration(milliseconds: 90);
  static const Duration quick = Duration(milliseconds: 160);
  static const Duration standard = Duration(milliseconds: 240);
  static const Duration emphasis = Duration(milliseconds: 340);
  static const Duration narrative = Duration(milliseconds: 520);
  static const Duration count = Duration(milliseconds: 900);

  // Curves
  static const Cubic enter = Cubic(0.05, 0.70, 0.10, 1.00);      // Decelerate, for things arriving
  static const Cubic exit = Cubic(0.30, 0.00, 0.80, 0.15);       // Accelerate, for things leaving
  static const Cubic standardCurve = Cubic(0.20, 0.00, 0.00, 1.00); // Both ends, for in-place movement
  static const Cubic draw = Cubic(0.16, 1.00, 0.30, 1.00);       // easeOutQuart, for lines drawing
  static const SpringDescription settle = SpringDescription(mass: 1, stiffness: 380, damping: 28);
}
