import 'package:flutter/material.dart';

/// Elevation & Shadow tokens for clean fintech cards and popups
class AppShadows {
  AppShadows._();

  static const List<BoxShadow> lightSubtle = [
    BoxShadow(
      color: Color(0x080F172A),
      blurRadius: 10,
      offset: Offset(0, 2),
    ),
    BoxShadow(
      color: Color(0x060F172A),
      blurRadius: 20,
      offset: Offset(0, 8),
    ),
  ];

  static const List<BoxShadow> lightCard = [
    BoxShadow(
      color: Color(0x0A0F172A),
      blurRadius: 14,
      offset: Offset(0, 4),
    ),
    BoxShadow(
      color: Color(0x050F172A),
      blurRadius: 30,
      offset: Offset(0, 12),
    ),
  ];

  static const List<BoxShadow> lightHero = [
    BoxShadow(
      color: Color(0x1F0D3B2E),
      blurRadius: 24,
      offset: Offset(0, 10),
    ),
  ];

  static const List<BoxShadow> darkCard = [
    BoxShadow(
      color: Color(0x40000000),
      blurRadius: 14,
      offset: Offset(0, 4),
    ),
  ];

  static const List<BoxShadow> darkHero = [
    BoxShadow(
      color: Color(0x60000000),
      blurRadius: 30,
      offset: Offset(0, 12),
    ),
  ];

  static const List<BoxShadow> goldGlow = [
    BoxShadow(
      color: Color(0x33D4AF37),
      blurRadius: 18,
      offset: Offset(0, 4),
    ),
  ];
}
