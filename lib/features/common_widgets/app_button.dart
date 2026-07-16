import 'package:flutter/material.dart';
import 'package:sample_app/core/theme/colors.dart' show AppColors;

import '../../core/theme/app_radius.dart';
import '../../core/theme/app_shadows.dart';

enum AppButtonVariant { filled, outlined, pill, text, gradient, error, success }

enum AppButtonSize { small, medium, large }

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final AppButtonVariant variant;
  final AppButtonSize size;
  final bool isLoading;
  final bool isFullWidth;
  final IconData? icon;
  final IconData? trailingIcon;
  final Gradient? gradient;

  const AppButton({
    super.key,
    required this.text,
    this.onPressed,
    this.variant = AppButtonVariant.filled,
    this.size = AppButtonSize.medium,
    this.isLoading = false,
    this.isFullWidth = true,
    this.icon,
    this.trailingIcon,
    this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: isFullWidth ? double.infinity : null,
      height: _height,
      child: variant == AppButtonVariant.gradient
          ? _buildGradientButton()
          : variant == AppButtonVariant.outlined ||
                variant == AppButtonVariant.error
          ? _buildOutlinedButton()
          : variant == AppButtonVariant.text
          ? _buildTextButton()
          : _buildFilledButton(),
    );
  }

  double get _height {
    switch (size) {
      case AppButtonSize.small:
        return 37;
      case AppButtonSize.medium:
        return 48;
      case AppButtonSize.large:
        return 60;
    }
  }

  double get _fontSize {
    switch (size) {
      case AppButtonSize.small:
        return 13;
      case AppButtonSize.medium:
        return 15;
      case AppButtonSize.large:
        return 16;
    }
  }

  BorderRadius get _borderRadius {
    switch (variant) {
      case AppButtonVariant.pill:
        return AppRadius.borderRadiusFull;
      case AppButtonVariant.error:
        return AppRadius.borderRadiusPill;
      case AppButtonVariant.success:
        return AppRadius.borderRadiusCard;
      default:
        switch (size) {
          case AppButtonSize.small:
            return AppRadius.borderRadiusBase;
          case AppButtonSize.medium:
            return AppRadius.borderRadiusMD;
          case AppButtonSize.large:
            return BorderRadius.circular(AppRadius.xxxl);
        }
    }
  }

  Color get _backgroundColor {
    switch (variant) {
      case AppButtonVariant.filled:
      case AppButtonVariant.pill:
        return AppColors.primary;
      case AppButtonVariant.success:
        return AppColors.successSurface;
      default:
        return Colors.transparent;
    }
  }

  Color get _foregroundColor {
    switch (variant) {
      case AppButtonVariant.filled:
      case AppButtonVariant.pill:
      case AppButtonVariant.gradient:
        return AppColors.textWhite;
      case AppButtonVariant.error:
        return AppColors.error;
      case AppButtonVariant.success:
        return AppColors.success;
      default:
        return AppColors.primary;
    }
  }

  Widget _buildContent() {
    if (isLoading) {
      return SizedBox(
        width: 20,
        height: 20,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          color: _foregroundColor,
        ),
      );
    }
    final textWidget = Text(
      text,
      style: TextStyle(
        fontFamily: 'ProximaNova',
        fontWeight: FontWeight.w600,
        fontSize: _fontSize,
        color: _foregroundColor,
      ),
    );
    if (icon != null || trailingIcon != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 20, color: _foregroundColor),
            const SizedBox(width: 8),
          ],
          textWidget,
          if (trailingIcon != null) ...[
            const SizedBox(width: 8),
            Icon(trailingIcon, size: 20, color: _foregroundColor),
          ],
        ],
      );
    }
    return textWidget;
  }

  Widget _buildFilledButton() {
    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: _backgroundColor,
        foregroundColor: _foregroundColor,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: _borderRadius),
        padding: EdgeInsets.symmetric(
          horizontal: size == AppButtonSize.large ? 16 : 24,
        ),
      ),
      child: _buildContent(),
    );
  }

  Widget _buildOutlinedButton() {
    return OutlinedButton(
      onPressed: isLoading ? null : onPressed,
      style: OutlinedButton.styleFrom(
        foregroundColor: _foregroundColor,
        side: BorderSide(
          color: variant == AppButtonVariant.error
              ? AppColors.error
              : AppColors.primary,
          width: 1.5,
        ),
        shape: RoundedRectangleBorder(borderRadius: _borderRadius),
        padding: EdgeInsets.symmetric(
          horizontal: size == AppButtonSize.small ? 16 : 24,
        ),
      ),
      child: _buildContent(),
    );
  }

  Widget _buildTextButton() {
    return TextButton(
      onPressed: isLoading ? null : onPressed,
      style: TextButton.styleFrom(foregroundColor: _foregroundColor),
      child: _buildContent(),
    );
  }

  Widget _buildGradientButton() {
    return Container(
      decoration: BoxDecoration(
        gradient: gradient ?? AppColors.blueGradient,
        borderRadius: _borderRadius,
        boxShadow: AppShadows.primaryButtonShadow,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isLoading ? null : onPressed,
          borderRadius: _borderRadius,
          child: Center(child: _buildContent()),
        ),
      ),
    );
  }
}
