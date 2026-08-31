import 'package:flutter/material.dart';

class AppShadows {
  // Soft, realistic institutional ambient diffusion
  static const List<BoxShadow> lightCard = [
    BoxShadow(
      color: Color(0x0A0F172A),
      blurRadius: 6,
      offset: Offset(0, 2),
    ),
  ];

  static const List<BoxShadow> lightHero = [
    BoxShadow(
      color: Color(0x140B281E),
      blurRadius: 16,
      offset: Offset(0, 6),
    ),
  ];

  static const List<BoxShadow> lightModal = [
    BoxShadow(
      color: Color(0x1A0F172A),
      blurRadius: 24,
      offset: Offset(0, -4),
    ),
  ];

  // Dark Mode Subtle Elevation
  static const List<BoxShadow> darkCard = [
    BoxShadow(
      color: Color(0x33000000),
      blurRadius: 8,
      offset: Offset(0, 2),
    ),
  ];

  static const List<BoxShadow> darkHero = [
    BoxShadow(
      color: Color(0x4D000000),
      blurRadius: 16,
      offset: Offset(0, 6),
    ),
  ];

  static const List<BoxShadow> darkModal = [
    BoxShadow(
      color: Color(0x80000000),
      blurRadius: 32,
      offset: Offset(0, -6),
    ),
  ];
}
