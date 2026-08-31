import 'package:flutter/material.dart';

/// Hierarchical Radius Tokens (Wise-inspired "Paddy Field" Shape System)
/// Buttons/Inputs: 14px, Cards: 18px, Hero: 20px, Sheets: 24px, Chips: Full Round.
/// Zero-radius (sharp corners) are reserved exclusively for literal legal documents.
class AppRadius {
  static const double zero = 0.0;    // Reserved exclusively for literal documents (Certificate, Lot Map)
  static const double control = 14.0; // Buttons, text inputs, dropdowns, segmented controls (14px)
  static const double card = 18.0;   // Standard cards, project cards, stat containers (18px)
  static const double hero = 20.0;   // Portfolio holding card, hero banners, dialogs (20px)
  static const double sheet = 24.0;  // Bottom sheet top corners, full-screen modals (24px)
  static const double chip = 999.0;  // Status badges, category pills, avatar chips (Full Round)
  static const double full = 999.0;  // Progress bar caps, circular badges

  // BorderRadius helpers
  static const BorderRadius borderZero = BorderRadius.zero;
  static const BorderRadius borderChip = BorderRadius.all(Radius.circular(chip));
  static const BorderRadius borderControl = BorderRadius.all(Radius.circular(control));
  static const BorderRadius borderButton = BorderRadius.all(Radius.circular(control));
  static const BorderRadius borderInput = BorderRadius.all(Radius.circular(control));
  static const BorderRadius borderCard = BorderRadius.all(Radius.circular(card));
  static const BorderRadius borderHero = BorderRadius.all(Radius.circular(hero));
  static const BorderRadius borderSheet = BorderRadius.vertical(top: Radius.circular(sheet));
  static const BorderRadius borderFull = BorderRadius.all(Radius.circular(full));

  // Compatibility aliases
  static const double xs = control;
  static const double sm = control;
  static const double md = card;
  static const double lg = hero;
  static const double xl = sheet;
  static const BorderRadius borderXs = borderControl;
  static const BorderRadius borderSm = borderControl;
  static const BorderRadius borderMd = borderCard;
  static const BorderRadius borderLg = borderHero;
  static const BorderRadius borderXl = borderSheet;
}
