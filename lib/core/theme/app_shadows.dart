import 'package:flutter/material.dart';

class AppShadows {
  AppShadows._();

  static const List<BoxShadow> none = [];

  static const List<BoxShadow> elevation1 = [
    BoxShadow(color: Color(0x0A000000), offset: Offset(0, 10), blurRadius: 20),
  ];

  static const List<BoxShadow> elevation2 = [
    BoxShadow(color: Color(0x17000000), offset: Offset(0, 12), blurRadius: 40),
  ];

  static const List<BoxShadow> elevation3 = [
    BoxShadow(color: Color(0x36151A40), offset: Offset(0, 12), blurRadius: 30),
  ];

  static const List<BoxShadow> elevation4 = [
    BoxShadow(color: Color(0x40000000), offset: Offset(0, 4), blurRadius: 14),
  ];

  static const List<BoxShadow> elevationSoft = [
    BoxShadow(color: Color(0x40CECECE), offset: Offset(0, 2), blurRadius: 8),
  ];

  static const List<BoxShadow> elevationSubtle = [
    BoxShadow(color: Color(0x0D000000), offset: Offset(0, 16), blurRadius: 40),
  ];

  static const List<BoxShadow> elevationMedium = [
    BoxShadow(color: Color(0x29000000), offset: Offset(0, 5), blurRadius: 10),
  ];

  // ─── Accent Shadows ───
  static const List<BoxShadow> primaryButtonShadow = [
    BoxShadow(color: Color(0x61684DD3), offset: Offset(0, 4), blurRadius: 14),
  ];

  static const List<BoxShadow> accentCardShadow = [
    BoxShadow(color: Color(0x33404567), offset: Offset(0, 7), blurRadius: 13),
  ];

  static const List<BoxShadow> mutedGlow = [
    BoxShadow(color: Color(0x45727F90), offset: Offset(0, 0), blurRadius: 30),
  ];

  static const List<BoxShadow> purpleGlow = [
    BoxShadow(color: Color(0x29777C97), offset: Offset(0, 11), blurRadius: 18),
  ];

  // ─── Card Shadows ───
  static const List<BoxShadow> cardShadow = [
    BoxShadow(color: Color(0x0F000000), offset: Offset(0, 12), blurRadius: 40),
  ];

  static const List<BoxShadow> cardShadowStrong = [
    BoxShadow(color: Color(0x17000000), offset: Offset(0, 12), blurRadius: 40),
    BoxShadow(color: Color(0x0A000000), offset: Offset(0, 2), blurRadius: 8),
  ];
}
