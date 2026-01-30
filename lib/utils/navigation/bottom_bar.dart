import 'package:flutter/material.dart';

import '/utils/svgs/svg.dart';
import '/utils/theme.dart';
import '/utils/widgets/glass_container.dart';

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
      padding: const .symmetric(horizontal: 32),
      child: SizedBox(
        height: 72,
        child: ClipRRect(
          borderRadius: .circular(32),
          child: BackdropFilter(
            filter: .blur(sigmaY: 10, sigmaX: 10),
            child: GlassContainer(
              borderRadius: .circular(32),
              padding: const .all(8),
              child: Row(mainAxisAlignment: .spaceBetween, children: items),
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
    this.selectedColor = AppColors.primary,
    this.disabledColor = AppColors.onSurface,
    this.onPressed,
    this.animationDuration = const Duration(milliseconds: 200),
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onPressed,
        behavior: HitTestBehavior.opaque,
        child: AnimatedGlassContainer(
          duration: animationDuration,
          width: isSelected ? 56 : 48,
          height: isSelected ? 56 : 48,
          isSelected: isSelected,
          padding: const .all(8),
          child: Svg(
            icon,
            color: isSelected
                ? selectedColor.withValues(alpha: 0.7)
                : disabledColor.withValues(alpha: 0.7),
            size: 24,
          ),
        ),
      ),
    );
  }
}
