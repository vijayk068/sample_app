import 'package:flutter/material.dart';

class AppRadius {
  AppRadius._();

  // ─── Radius Values ───
  static const double xs = 5.0;
  static const double sm = 8.0;
  static const double md = 11.0;
  static const double base = 12.0;
  static const double lg = 16.0;
  static const double xl = 20.0;
  static const double xxl = 24.0;
  static const double xxxl = 26.0;
  static const double card = 30.0;
  static const double pill = 33.0;
  static const double pillLarge = 47.0;
  static const double pillXL = 54.0;
  static const double full = 110.0;

  // ─── BorderRadius Presets ───
  static final BorderRadius borderRadiusXS = BorderRadius.circular(xs);
  static final BorderRadius borderRadiusSM = BorderRadius.circular(sm);
  static final BorderRadius borderRadiusMD = BorderRadius.circular(md);
  static final BorderRadius borderRadiusBase = BorderRadius.circular(base);
  static final BorderRadius borderRadiusLG = BorderRadius.circular(lg);
  static final BorderRadius borderRadiusXL = BorderRadius.circular(xl);
  static final BorderRadius borderRadiusXXL = BorderRadius.circular(xxl);
  static final BorderRadius borderRadiusCard = BorderRadius.circular(card);
  static final BorderRadius borderRadiusPill = BorderRadius.circular(pill);
  static final BorderRadius borderRadiusFull = BorderRadius.circular(full);

  // ─── Top-only (Bottom Sheets) ───
  static final BorderRadius topRadiusXXL = BorderRadius.only(
    topLeft: Radius.circular(xxl),
    topRight: Radius.circular(xxl),
  );

  static final BorderRadius topRadiusCard = BorderRadius.only(
    topLeft: Radius.circular(card),
    topRight: Radius.circular(card),
  );
}
