import 'package:flutter/material.dart';
import 'package:sample_app/core/theme/colors.dart';

class AppFonts {
  AppFonts._();

  static const String proximaNova = 'ProximaNova';
  static const String poppins = 'Poppins';
  static const String infra = 'Infra';
  static const String roboto = 'Roboto';
  static const String sfPro = 'SFProDisplay';
  static const String lato = 'Lato';
  static const String montserrat = 'Montserrat';
  static const String inter = 'Inter';
}

class AppTextStyles {
  AppTextStyles._();

  // ════════════════════════════════════════════
  //  PROXIMA NOVA (Primary Font)
  // ════════════════════════════════════════════

  // ─── Display ───
  static const TextStyle displayXL = TextStyle(
    fontFamily: AppFonts.proximaNova,
    fontWeight: FontWeight.w800,
    fontSize: 70,
    height: 1.1,
    color: AppColors.textDark,
  );

  static const TextStyle displayLarge = TextStyle(
    fontFamily: AppFonts.proximaNova,
    fontWeight: FontWeight.w700,
    fontSize: 44,
    height: 1.2,
    color: AppColors.textWhite,
  );

  static const TextStyle displayMedium = TextStyle(
    fontFamily: AppFonts.proximaNova,
    fontWeight: FontWeight.w400,
    fontSize: 30,
    color: AppColors.textPrimary,
  );

  static const TextStyle displaySmall = TextStyle(
    fontFamily: AppFonts.proximaNova,
    fontWeight: FontWeight.w700,
    fontSize: 25,
    color: AppColors.textPrimary,
  );

  // ─── Headline ───
  static const TextStyle headlineLarge = TextStyle(
    fontFamily: AppFonts.proximaNova,
    fontWeight: FontWeight.w700,
    fontSize: 20,
    height: 1.3,
    color: AppColors.textPrimary,
  );

  static const TextStyle headlineMedium = TextStyle(
    fontFamily: AppFonts.proximaNova,
    fontWeight: FontWeight.w700,
    fontSize: 18,
    color: AppColors.textPrimary,
  );

  static const TextStyle headlineSmall = TextStyle(
    fontFamily: AppFonts.proximaNova,
    fontWeight: FontWeight.w700,
    fontSize: 16,
    height: 1.1,
    color: AppColors.primary,
  );

  // ─── Title ───
  static const TextStyle titleLarge = TextStyle(
    fontFamily: AppFonts.proximaNova,
    fontWeight: FontWeight.w600,
    fontSize: 24,
    color: AppColors.textPrimary,
  );

  static const TextStyle titleMedium = TextStyle(
    fontFamily: AppFonts.proximaNova,
    fontWeight: FontWeight.w600,
    fontSize: 20,
    color: AppColors.textPrimary,
  );

  static const TextStyle titleSmall = TextStyle(
    fontFamily: AppFonts.proximaNova,
    fontWeight: FontWeight.w600,
    fontSize: 18,
    color: AppColors.textPrimary,
  );

  // ─── Label ───
  static const TextStyle labelLarge = TextStyle(
    fontFamily: AppFonts.proximaNova,
    fontWeight: FontWeight.w600,
    fontSize: 17,
    color: AppColors.textPrimary,
  );

  static const TextStyle labelMedium = TextStyle(
    fontFamily: AppFonts.proximaNova,
    fontWeight: FontWeight.w600,
    fontSize: 16,
    color: AppColors.textDark,
  );

  static const TextStyle labelSmall = TextStyle(
    fontFamily: AppFonts.proximaNova,
    fontWeight: FontWeight.w600,
    fontSize: 15,
    height: 1.3,
    color: AppColors.textPrimary,
  );

  // ─── Body ───
  static const TextStyle bodyLarge = TextStyle(
    fontFamily: AppFonts.proximaNova,
    fontWeight: FontWeight.w400,
    fontSize: 16,
    color: AppColors.textPrimary,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontFamily: AppFonts.proximaNova,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    color: AppColors.textSecondary,
  );

  static const TextStyle bodySmall = TextStyle(
    fontFamily: AppFonts.proximaNova,
    fontWeight: FontWeight.w400,
    fontSize: 13,
    color: AppColors.textPrimary,
  );

  static const TextStyle bodyThin = TextStyle(
    fontFamily: AppFonts.proximaNova,
    fontWeight: FontWeight.w100,
    fontSize: 13,
    color: AppColors.textPrimary,
  );

  // ─── Caption ───
  static const TextStyle captionLarge = TextStyle(
    fontFamily: AppFonts.proximaNova,
    fontWeight: FontWeight.w600,
    fontSize: 14,
    color: AppColors.textPrimary,
  );

  static const TextStyle captionMedium = TextStyle(
    fontFamily: AppFonts.proximaNova,
    fontWeight: FontWeight.w600,
    fontSize: 13,
    height: 1.3,
    color: AppColors.textPrimary,
  );

  static const TextStyle captionSmall = TextStyle(
    fontFamily: AppFonts.proximaNova,
    fontWeight: FontWeight.w400,
    fontSize: 12,
    color: AppColors.textMuted,
  );

  static const TextStyle captionTiny = TextStyle(
    fontFamily: AppFonts.proximaNova,
    fontWeight: FontWeight.w400,
    fontSize: 11,
    color: AppColors.textMuted,
  );

  static const TextStyle captionMicro = TextStyle(
    fontFamily: AppFonts.proximaNova,
    fontWeight: FontWeight.w400,
    fontSize: 10,
    color: AppColors.primary,
  );

  // ─── Semantic ───
  static const TextStyle hintText = TextStyle(
    fontFamily: AppFonts.proximaNova,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    color: AppColors.textHint,
  );

  static const TextStyle linkText = TextStyle(
    fontFamily: AppFonts.proximaNova,
    fontWeight: FontWeight.w600,
    fontSize: 14,
    color: AppColors.primary,
  );

  static const TextStyle errorText = TextStyle(
    fontFamily: AppFonts.proximaNova,
    fontWeight: FontWeight.w600,
    fontSize: 14,
    color: AppColors.error,
  );

  // ─── Button Text ───
  static const TextStyle buttonLarge = TextStyle(
    fontFamily: AppFonts.proximaNova,
    fontWeight: FontWeight.w600,
    fontSize: 16,
    color: AppColors.textWhite,
  );

  static const TextStyle buttonMedium = TextStyle(
    fontFamily: AppFonts.proximaNova,
    fontWeight: FontWeight.w600,
    fontSize: 15,
    height: 1.3,
    color: AppColors.textWhite,
  );

  static const TextStyle buttonSmall = TextStyle(
    fontFamily: AppFonts.proximaNova,
    fontWeight: FontWeight.w700,
    fontSize: 14,
    color: AppColors.textWhite,
  );

  // ════════════════════════════════════════════
  //  POPPINS (Secondary / Auth Screens)
  // ════════════════════════════════════════════

  static const TextStyle poppinsHeading = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w700,
    fontSize: 22,
    height: 1.065,
    color: AppColors.textCardHeading,
  );

  static const TextStyle poppinsTitleLarge = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w600,
    fontSize: 20,
    height: 1.1,
    color: AppColors.textDark,
  );

  static const TextStyle poppinsTitleMedium = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w600,
    fontSize: 18,
    height: 1.1,
    color: AppColors.textDark,
  );

  static const TextStyle poppinsLabelLarge = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w600,
    fontSize: 16,
    height: 1.065,
    color: AppColors.textAccent,
  );

  static const TextStyle poppinsLabelMedium = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w600,
    fontSize: 15,
    height: 1.1,
    color: AppColors.textWhite,
  );

  static const TextStyle poppinsLabelSmall = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w600,
    fontSize: 14,
    height: 1.7,
    color: AppColors.textCardDark,
  );

  static const TextStyle poppinsBody = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    height: 1.065,
    color: AppColors.textHint,
  );

  static const TextStyle poppinsBodyMedium = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w500,
    fontSize: 14,
    height: 1.065,
    color: AppColors.errorAlt,
  );

  static const TextStyle poppinsMedium = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w500,
    fontSize: 16,
    height: 1.065,
    color: AppColors.textSecondary,
  );

  static const TextStyle poppinsLinkMedium = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w500,
    fontSize: 16,
    height: 1.065,
    color: AppColors.info,
  );

  static const TextStyle poppinsCaption = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w400,
    fontSize: 12,
    height: 1.5,
    color: AppColors.textCardDark,
  );

  static const TextStyle poppinsCaptionMedium = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w500,
    fontSize: 12,
    color: AppColors.textSecondary,
  );

  static const TextStyle poppinsMediumSmall = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w500,
    fontSize: 13,
    color: AppColors.textCardDark,
  );

  static const TextStyle poppinsSmall = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w500,
    fontSize: 10,
    height: 1.5,
    color: AppColors.textAccent,
  );

  static const TextStyle poppinsLight = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w300,
    fontSize: 13,
    height: 1.065,
    color: AppColors.textAccent,
  );

  static const TextStyle poppinsLightSmall = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w300,
    fontSize: 11,
    height: 1.5,
    color: AppColors.textDark,
  );

  static const TextStyle poppinsLightCaption = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w300,
    fontSize: 10,
    height: 1.3,
    color: AppColors.textTertiary,
  );

  // ════════════════════════════════════════════
  //  INFRA (Alternate UI)
  // ════════════════════════════════════════════

  static const TextStyle infraTitle = TextStyle(
    fontFamily: AppFonts.infra,
    fontWeight: FontWeight.w600,
    fontSize: 20,
    height: 1.065,
    color: AppColors.textPrimary,
  );

  static const TextStyle infraLabel = TextStyle(
    fontFamily: AppFonts.infra,
    fontWeight: FontWeight.w600,
    fontSize: 16,
    height: 1.065,
    color: AppColors.textPrimary,
  );

  static const TextStyle infraBody = TextStyle(
    fontFamily: AppFonts.infra,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    height: 1.07,
    color: AppColors.textPrimary,
  );

  static const TextStyle infraCaption = TextStyle(
    fontFamily: AppFonts.infra,
    fontWeight: FontWeight.w400,
    fontSize: 11,
    color: AppColors.textPrimary,
  );

  static const TextStyle infraMedium = TextStyle(
    fontFamily: AppFonts.infra,
    fontWeight: FontWeight.w500,
    fontSize: 13,
    height: 1.18,
    color: AppColors.textWhite,
  );
}
