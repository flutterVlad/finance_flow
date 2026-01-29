import 'package:flutter/material.dart';

class AppTextButton extends StatelessWidget {
  final String text;
  final Color? color;
  final void Function()? onPressed;
  final TextStyle? style;
  final bool filled;

  const AppTextButton({
    super.key,
    required this.text,
    this.color,
    this.onPressed,
    this.style,
    this.filled = false,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textColor =
        color ?? (filled ? colorScheme.onPrimary : colorScheme.primary);

    return Material(
      borderRadius: .circular(20),
      color: filled ? colorScheme.primary : Colors.transparent,
      child: InkWell(
        borderRadius: .circular(16),
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          child: Text(
            text,
            style:
                style?.copyWith(color: textColor) ??
                TextStyle(color: textColor),
          ),
        ),
      ),
    );
  }
}
