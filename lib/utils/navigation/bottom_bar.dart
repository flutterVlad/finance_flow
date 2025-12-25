import 'package:flutter/material.dart';

import '../svgs/svg.dart';
import '../svgs/svgs.dart';
import '../theme.dart';

class BottomBar extends StatelessWidget {
  final void Function(int) onTap;
  final int currentIndex;
  final Duration animationDuration;

  const BottomBar({
    super.key,
    required this.onTap,
    required this.currentIndex,
    this.animationDuration = const Duration(milliseconds: 200),
  });

  @override
  Widget build(BuildContext context) {
    final items = [
      BottomBarItem(
        icon: Svgs.home,
        onPressed: () => onTap(0),
        isSelected: currentIndex == 0,
        animationDuration: animationDuration,
      ),
      BottomBarItem(
        icon: Svgs.wallet,
        onPressed: () => onTap(1),
        isSelected: currentIndex == 1,
        animationDuration: animationDuration,
      ),
      BottomBarItem(
        icon: Svgs.addRounded,
        onPressed: () => onTap(2),
        isSelected: currentIndex == 2,
        animationDuration: animationDuration,
      ),
      BottomBarItem(
        icon: Svgs.pieChart,
        onPressed: () => onTap(3),
        isSelected: currentIndex == 3,
        animationDuration: animationDuration,
      ),
    ];

    return Padding(
      padding: const .only(left: 32, right: 32),
      child: SizedBox(
        height: 56,
        child: ClipRRect(
          borderRadius: .circular(50),
          child: BackdropFilter(
            filter: .blur(sigmaX: 3, sigmaY: 3),
            child: Material(
              color: AppColors.primary.withValues(alpha: 0.6),
              child: Padding(
                padding: const .all(8),
                child: Row(mainAxisAlignment: .spaceBetween, children: items),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class BottomBarItem extends StatelessWidget {
  final SvgData icon;
  final bool isSelected;
  final Color selectedColor;
  final Color disabledColor;
  final VoidCallback? onPressed;
  final Duration animationDuration;

  const BottomBarItem({
    super.key,
    required this.icon,
    this.isSelected = false,
    this.selectedColor = AppColors.primary500,
    this.disabledColor = AppColors.onPrimary,
    this.onPressed,
    this.animationDuration = const Duration(milliseconds: 200),
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onPressed,
        behavior: HitTestBehavior.opaque,
        child: AnimatedContainer(
          duration: animationDuration,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isSelected
                ? selectedColor.withValues(alpha: 0.5)
                : Colors.transparent,
          ),
          child: Padding(
            padding: const .all(8),
            child: Svg(
              icon,
              color: isSelected ? selectedColor : disabledColor,
              size: 24,
            ),
          ),
        ),
      ),
    );
  }
}
