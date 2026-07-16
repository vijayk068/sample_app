import 'package:flutter/material.dart';
import 'package:sample_app/core/theme/app_radius.dart';
import 'package:sample_app/core/theme/app_shadows.dart';
import 'package:sample_app/core/theme/colors.dart';

import '../../core/theme/app_spacing.dart';

enum AppCardVariant { flat, elevated, subtle, gradient }

class AppCard extends StatelessWidget {
  final Widget child;
  final AppCardVariant variant;
  final double? radius;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final VoidCallback? onTap;
  final Color? color;
  final Gradient? gradient;
  final double? width;
  final double? height;
  final List<BoxShadow>? shadow;
  final Border? border;

  const AppCard({
    super.key,
    required this.child,
    this.variant = AppCardVariant.flat,
    this.radius,
    this.padding,
    this.margin,
    this.onTap,
    this.color,
    this.gradient,
    this.width,
    this.height,
    this.shadow,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      decoration: BoxDecoration(
        color: gradient == null ? (color ?? AppColors.background) : null,
        gradient: gradient,
        borderRadius: BorderRadius.circular(radius ?? AppRadius.card),
        boxShadow: shadow ?? _shadow,
        border: border,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(radius ?? AppRadius.card),
          child: Padding(
            padding: padding ?? AppSpacing.cardPadding,
            child: child,
          ),
        ),
      ),
    );
  }

  List<BoxShadow> get _shadow {
    switch (variant) {
      case AppCardVariant.flat:
        return AppShadows.none;
      case AppCardVariant.elevated:
        return AppShadows.cardShadow;
      case AppCardVariant.subtle:
        return AppShadows.elevationSoft;
      case AppCardVariant.gradient:
        return AppShadows.none;
    }
  }
}

class AppBottomSheet extends StatelessWidget {
  final Widget child;
  final double? radius;
  final EdgeInsets? padding;

  const AppBottomSheet({
    super.key,
    required this.child,
    this.radius,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(radius ?? AppRadius.card),
          topRight: Radius.circular(radius ?? AppRadius.card),
        ),
      ),
      padding: padding ?? const EdgeInsets.all(20),
      child: child,
    );
  }
}

class AppModal extends StatelessWidget {
  final Widget child;
  final double? radius;
  final EdgeInsets? padding;
  final double? width;

  const AppModal({
    super.key,
    required this.child,
    this.radius,
    this.padding,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius ?? AppRadius.card),
      ),
      child: Container(
        width: width ?? 345,
        padding: padding ?? const EdgeInsets.all(24),
        child: child,
      ),
    );
  }
}
