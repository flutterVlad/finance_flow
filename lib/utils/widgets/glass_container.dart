import 'package:flutter/material.dart';

import '/utils/theme.dart';

class GlassContainer extends StatelessWidget {
  const GlassContainer({
    super.key,
    this.width,
    this.height,
    this.child,
    this.padding,
    this.shape,
    this.borderRadius,
    this.color = AppColors.lightGrey,
  });

  final double? width;
  final double? height;
  final Widget? child;
  final EdgeInsets? padding;
  final BoxShape? shape;
  final BorderRadius? borderRadius;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: borderRadius,
      color: Colors.transparent,
      child: Container(
        width: width,
        height: height,
        padding: padding,
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          color: color.withValues(alpha: 0.3),
          border: Border.all(color: color.withValues(alpha: 0.1), width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 10,
              spreadRadius: 0,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: child,
      ),
    );
  }
}

class AnimatedGlassContainer extends StatelessWidget {
  const AnimatedGlassContainer({
    super.key,
    this.duration = const Duration(milliseconds: 200),
    this.width,
    this.height,
    this.isSelected = false,
    this.selectedColor = AppColors.primary,
    this.disabledColor = AppColors.onPrimary,
    this.padding,
    this.child,
  });

  final Duration duration;
  final double? width;
  final double? height;
  final bool isSelected;
  final Color selectedColor;
  final Color disabledColor;
  final EdgeInsets? padding;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final currentColor = isSelected ? selectedColor : disabledColor;

    return AnimatedContainer(
      duration: duration,
      width: width,
      height: height,
      padding: padding,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: currentColor.withValues(alpha: 0.3),
        border: Border.all(
          color: currentColor.withValues(alpha: 0.1),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.white.withValues(alpha: 0.3),
            blurRadius: 10,
            spreadRadius: 0,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }
}
