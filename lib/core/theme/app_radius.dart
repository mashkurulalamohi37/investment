import 'package:flutter/material.dart';

/// Hierarchical Radius Tokens (§6 of Khatian Specification)
/// Rule of thumb: Documents & pieces of land have square corners (0). Interactive controls are softly rounded (6).
class AppRadius {
  static const double zero = 0.0;    // Lot map, cells, tables, certificate frames, seal plates
  static const double chip = 2.0;    // Status chips, serial-number boxes, lot badges
  static const double control = 6.0; // Buttons, text inputs, dropdowns, segmented controls
  static const double card = 10.0;   // Standard cards: vouchers, documents, project cards
  static const double hero = 14.0;   // Portfolio holding card, dialogs
  static const double sheet = 20.0;  // Bottom sheet top corners only
  static const double full = 999.0;  // Progress bar caps and avatars only

  // BorderRadius helpers
  static const BorderRadius borderZero = BorderRadius.zero;
  static const BorderRadius borderChip = BorderRadius.all(Radius.circular(chip));
  static const BorderRadius borderControl = BorderRadius.all(Radius.circular(control));
  static const BorderRadius borderCard = BorderRadius.all(Radius.circular(card));
  static const BorderRadius borderHero = BorderRadius.all(Radius.circular(hero));
  static const BorderRadius borderSheet = BorderRadius.vertical(top: Radius.circular(sheet));
  static const BorderRadius borderFull = BorderRadius.all(Radius.circular(full));

  // Compatibility aliases
  static const double xs = chip;
  static const double sm = control;
  static const double md = card;
  static const double lg = hero;
  static const double xl = sheet;
  static const BorderRadius borderXs = borderChip;
  static const BorderRadius borderSm = borderControl;
  static const BorderRadius borderMd = borderCard;
  static const BorderRadius borderLg = borderHero;
  static const BorderRadius borderXl = borderSheet;
}
