import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // ─── Primary & Brand ───
  static const Color primary = Color(0xFF8753F7);
  static const Color primaryDark = Color(0xFF604DD3);
  static const Color primaryLight = Color(0xFFA97FEB);
  static const Color primarySurface = Color(0xFFEFEDFE);
  static const Color primarySurfaceLight = Color(0xFFF3EEFF);
  static const Color primarySurfaceLighter = Color(0xFFEEE6FF);
  static const Color accent = Color(0xFF5C63FF);
  static const Color accentAlt = Color(0xFF4957FE);
  static const Color accentLight = Color(0xFF6B73FE);
  static const Color accentSoft = Color(0xFFAFA3FF);
  static const Color accentPale = Color(0xFFB0A6FF);
  static const Color purple = Color(0xFF5F259F);
  static const Color purpleMid = Color(0xFF4E4492);
  static const Color indigo = Color(0xFF7A8AF9);
  static const Color lavender = Color(0xFF698AD6);
  static const Color lilac = Color(0xFFC9C4FF);
  static const Color lilacLight = Color(0xFFDADAFF);
  static const Color lilacPale = Color(0xFFEAEAFF);

  // ─── Text Colors ───
  static const Color textPrimary = Color(0xFF1E1F26);
  static const Color textDark = Color(0xFF051D43);
  static const Color textSecondary = Color(0xFF727F90);
  static const Color textTertiary = Color(0xFF566170);
  static const Color textHint = Color(0xFFA0A3B5);
  static const Color textMuted = Color(0xFF939BA7);
  static const Color textAccent = Color(0xFF404567);
  static const Color textCardDark = Color(0xFF2A2A4C);
  static const Color textCardHeading = Color(0xFF2C2C37);
  static const Color textWhite = Color(0xFFFFFFFF);
  static const Color textBlack = Color(0xFF000000);
  static const Color textLabel = Color(0xFF222222);

  // ─── Semantic Colors ───
  static const Color error = Color(0xFFFF3B30);
  static const Color errorAlt = Color(0xFFF54A68);
  static const Color errorSoft = Color(0xFFF12C50);
  static const Color errorPink = Color(0xFFE88194);
  static const Color errorLight = Color(0xFFFFC5C5);
  static const Color errorSurface = Color(0xFFF7E6EA);
  static const Color success = Color(0xFF34C759);
  static const Color successDark = Color(0xFF138630);
  static const Color successAlt = Color(0xFF02B876);
  static const Color successMint = Color(0xFF10C796);
  static const Color successSurface = Color(0xFFDFFFE7);
  static const Color successSurfaceAlt = Color(0xFFD9EADA);
  static const Color warning = Color(0xFFFF9500);
  static const Color warningAlt = Color(0xFFFAC643);
  static const Color warningGold = Color(0xFFF9BF29);
  static const Color warningYellow = Color(0xFFFCC810);
  static const Color warningSurface = Color(0xFFFFF6D6);
  static const Color info = Color(0xFF4074FC);
  static const Color infoDark = Color(0xFF007AFF);
  static const Color infoLight = Color(0xFF4DA8F2);

  // ─── Teal / Cyan ───
  static const Color teal = Color(0xFF0AC8D1);
  static const Color tealDark = Color(0xFF07989F);
  static const Color tealLight = Color(0xFF21C6CE);
  static const Color tealMint = Color(0xFF25B29D);
  static const Color tealPale = Color(0xFFA2DEE5);
  static const Color tealSurface = Color(0xFFE3F9FF);
  static const Color cyan = Color(0xFF4AC3EA);

  // ─── Surface & Background ───
  static const Color background = Color(0xFFFFFFFF);
  static const Color surface = Color(0xFFF3F5FC);
  static const Color surfaceAlt = Color(0xFFF5F6FA);
  static const Color surfaceLight = Color(0xFFF3F7FD);
  static const Color surfaceMuted = Color(0xFFEEF0F7);
  static const Color surfaceGrey = Color(0xFFF4F4F4);
  static const Color surfaceGreyLight = Color(0xFFF5F5F5);
  static const Color surfaceDark = Color(0xFFDCE1EF);
  static const Color surfacePure = Color(0xFFFCFCFC);
  static const Color scaffoldBackground = Color(0xFFF3F5FC);

  // ─── Divider & Border ───
  static const Color divider = Color(0xFFE5E5E5);
  static const Color dividerLight = Color(0xFFE6E6E6);
  static const Color border = Color(0xFFD9D9D9);
  static const Color borderLight = Color(0xFFE0E0E0);
  static const Color borderMuted = Color(0xFFBCC4CE);
  static const Color borderSubtle = Color(0xFFD5D5D5);
  static const Color borderPale = Color(0xFFDFE2ED);

  // ─── Stroke Colors ───
  static const Color strokePrimary = Color(0xFF8753F7);
  static const Color strokeError = Color(0xFFFF3B30);
  static const Color strokeMuted = Color(0xFFBCC4CE);
  static const Color strokeLight = Color(0xFFF3F6FD);
  static const Color strokeSubtle = Color(0xFFD5D5D5);
  static const Color strokeDisabled = Color(0x1F767680);

  // ─── Dark Surfaces ───
  static const Color darkBg = Color(0xFF141414);
  static const Color darkSurface = Color(0xFF1F1F1F);
  static const Color darkCard = Color(0xFF22242D);
  static const Color darkNavy = Color(0xFF0B1C3F);
  static const Color darkSlate = Color(0xFF1D3B54);
  static const Color darkPurple = Color(0xFF261A54);
  static const Color darkBlue = Color(0xFF292C47);

  // ─── Social / Third-party ───
  static const Color google = Color(0xFFEA4335);
  static const Color googleGreen = Color(0xFF34A853);
  static const Color googleBlue = Color(0xFF4074FC);
  static const Color googleYellow = Color(0xFFFBBC04);
  static const Color mastercardRed = Color(0xFFEB001B);
  static const Color mastercardOrange = Color(0xFFFF5F00);
  static const Color visaYellow = Color(0xFFF79E1B);

  // ─── Gradients ───
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFF98A5FF), Color(0xFFB7ADFF)],
  );

  static const LinearGradient blueGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF4A56FE), Color(0xFF566FFA)],
  );

  static const LinearGradient purpleGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF6870FE), Color(0xFF8B90FA)],
  );

  static const LinearGradient pinkGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFBD70FE), Color(0xFFEF90FA)],
  );

  static const LinearGradient tealGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF40D5E6), Color(0xFF5577FF)],
  );

  static const LinearGradient orangeGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFFF9340), Color(0xFFFFCE45)],
  );

  static const LinearGradient navyGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFF222357), Color(0xFF254AA5)],
  );

  static const LinearGradient oceanGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF1898F0), Color(0xFF14C4DF)],
  );

  static const LinearGradient greenGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF7FCCF0), Color(0xFFBAFFDF)],
  );

  static const LinearGradient cardGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFFFFFFFF), Color(0xFFEEF0F8)],
  );

  static const LinearGradient goldGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFEADDA2), Color(0xFFFFF9A6)],
  );

  static const LinearGradient warmOrangeGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFC97332), Color(0xFFFFCE45)],
  );
}
