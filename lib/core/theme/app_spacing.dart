import 'package:flutter/material.dart';

class AppSpacing {
  AppSpacing._();

  // ─── Base Spacing Scale ───
  static const double xxs = 2.0;
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 10.0;
  static const double base = 12.0;
  static const double lg = 16.0;
  static const double xl = 18.0;
  static const double xxl = 20.0;
  static const double xxxl = 24.0;
  static const double xxxxl = 30.0;

  // ─── Screen Padding ───
  static const double screenHorizontal = 20.0;
  static const double screenHorizontalLarge = 30.0;
  static const double screenTop = 18.0;
  static const double screenBottom = 16.0;

  static const EdgeInsets screenPadding = EdgeInsets.symmetric(
    horizontal: screenHorizontal,
  );

  static const EdgeInsets screenPaddingLarge = EdgeInsets.symmetric(
    horizontal: screenHorizontalLarge,
  );

  static const EdgeInsets screenPaddingAll = EdgeInsets.fromLTRB(
    screenHorizontal,
    screenTop,
    screenHorizontal,
    screenBottom,
  );

  // ─── Card Padding ───
  static const EdgeInsets cardPadding = EdgeInsets.all(md);
  static const EdgeInsets cardPaddingLarge = EdgeInsets.all(lg);
  static const EdgeInsets cardPaddingXL = EdgeInsets.all(xxl);

  // ─── Section Spacing ───
  static const double sectionGap = 24.0;
  static const double sectionGapLarge = 30.0;
  static const double sectionGapSmall = 16.0;

  // ─── Item Spacing ───
  static const double itemGapTiny = 4.0;
  static const double itemGapSmall = 8.0;
  static const double itemGap = 10.0;
  static const double itemGapMedium = 12.0;
  static const double itemGapLarge = 16.0;
  static const double itemGapXL = 20.0;

  // ─── Icon Spacing ───
  static const double iconGap = 10.5;
  static const double iconGapSmall = 8.0;

  // ─── Vertical Gaps (SizedBox helpers) ───
  static const SizedBox verticalGap2 = SizedBox(height: xxs);
  static const SizedBox verticalGap4 = SizedBox(height: xs);
  static const SizedBox verticalGap8 = SizedBox(height: sm);
  static const SizedBox verticalGap10 = SizedBox(height: md);
  static const SizedBox verticalGap12 = SizedBox(height: base);
  static const SizedBox verticalGap16 = SizedBox(height: lg);
  static const SizedBox verticalGap20 = SizedBox(height: xxl);
  static const SizedBox verticalGap24 = SizedBox(height: xxxl);
  static const SizedBox verticalGap30 = SizedBox(height: xxxxl);

  // ─── Horizontal Gaps ───
  static const SizedBox horizontalGap4 = SizedBox(width: xs);
  static const SizedBox horizontalGap8 = SizedBox(width: sm);
  static const SizedBox horizontalGap10 = SizedBox(width: md);
  static const SizedBox horizontalGap12 = SizedBox(width: base);
  static const SizedBox horizontalGap16 = SizedBox(width: lg);
  static const SizedBox horizontalGap20 = SizedBox(width: xxl);
}
