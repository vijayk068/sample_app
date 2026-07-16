import 'package:flutter/material.dart';
import 'package:sample_app/core/theme/app_radius.dart';
import 'package:sample_app/core/theme/app_topography.dart';
import 'package:sample_app/core/theme/colors.dart';

enum AppTextFieldVariant { standard, pill, rounded, search }

class AppTextField extends StatelessWidget {
  final String? hint;
  final String? label;
  final TextEditingController? controller;
  final bool obscureText;
  final TextInputType? keyboardType;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;
  final bool readOnly;
  final int maxLines;
  final AppTextFieldVariant variant;
  final bool hasError;
  final String? errorText;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;

  const AppTextField({
    super.key,
    this.hint,
    this.label,
    this.controller,
    this.obscureText = false,
    this.keyboardType,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.onChanged,
    this.readOnly = false,
    this.maxLines = 1,
    this.variant = AppTextFieldVariant.standard,
    this.hasError = false,
    this.errorText,
    this.focusNode,
    this.textInputAction,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      validator: validator,
      onChanged: onChanged,
      readOnly: readOnly,
      maxLines: maxLines,
      focusNode: focusNode,
      textInputAction: textInputAction,
      style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textPrimary),
      decoration: InputDecoration(
        hintText: hint,
        labelText: label,
        hintStyle: AppTextStyles.hintText,
        labelStyle: AppTextStyles.bodyMedium,
        errorText: errorText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: _fillColor,
        contentPadding: _contentPadding,
        border: _border,
        enabledBorder: _enabledBorder,
        focusedBorder: _focusedBorder,
        errorBorder: _errorBorder,
        focusedErrorBorder: _focusedErrorBorder,
      ),
    );
  }

  Color get _fillColor {
    switch (variant) {
      case AppTextFieldVariant.search:
        return AppColors.surfaceGrey;
      default:
        return AppColors.background;
    }
  }

  EdgeInsets get _contentPadding {
    switch (variant) {
      case AppTextFieldVariant.pill:
      case AppTextFieldVariant.search:
        return const EdgeInsets.symmetric(horizontal: 20, vertical: 16);
      case AppTextFieldVariant.rounded:
        return const EdgeInsets.symmetric(horizontal: 20, vertical: 22);
      default:
        return const EdgeInsets.symmetric(horizontal: 16, vertical: 18);
    }
  }

  BorderRadius get _radius {
    switch (variant) {
      case AppTextFieldVariant.pill:
        return AppRadius.borderRadiusFull;
      case AppTextFieldVariant.rounded:
        return AppRadius.borderRadiusXL;
      case AppTextFieldVariant.search:
        return AppRadius.borderRadiusXL;
      default:
        return AppRadius.borderRadiusXS;
    }
  }

  Color get _strokeColor {
    switch (variant) {
      case AppTextFieldVariant.pill:
        return AppColors.strokeDisabled;
      case AppTextFieldVariant.rounded:
        return AppColors.strokeLight;
      case AppTextFieldVariant.search:
        return AppColors.surfaceGrey;
      default:
        return AppColors.strokeMuted;
    }
  }

  OutlineInputBorder get _border => OutlineInputBorder(
    borderRadius: _radius,
    borderSide: BorderSide(color: _strokeColor, width: 1),
  );

  OutlineInputBorder get _enabledBorder => OutlineInputBorder(
    borderRadius: _radius,
    borderSide: BorderSide(
      color: hasError ? AppColors.strokeError : _strokeColor,
      width: 1,
    ),
  );

  OutlineInputBorder get _focusedBorder => OutlineInputBorder(
    borderRadius: _radius,
    borderSide: BorderSide(
      color: hasError ? AppColors.strokeError : AppColors.strokePrimary,
      width: 1.5,
    ),
  );

  OutlineInputBorder get _errorBorder => OutlineInputBorder(
    borderRadius: _radius,
    borderSide: const BorderSide(color: AppColors.strokeError, width: 1),
  );

  OutlineInputBorder get _focusedErrorBorder => OutlineInputBorder(
    borderRadius: _radius,
    borderSide: const BorderSide(color: AppColors.strokeError, width: 1.5),
  );
}
