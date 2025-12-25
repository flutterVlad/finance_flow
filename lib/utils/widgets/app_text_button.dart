import 'package:flutter/material.dart';

class AppTextButton extends StatelessWidget {
  final String text;
  final Color? color;
  final void Function()? onPressed;
  final TextStyle? style;

  const AppTextButton({
    super.key,
    required this.text,
    this.color,
    this.onPressed,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Material(
      borderRadius: .circular(16),
      color: Colors.transparent,
      child: InkWell(
        borderRadius: .circular(16),
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          child: Text(
            text,
            style:
                style?.copyWith(color: color ?? colorScheme.primary) ??
                TextStyle(color: color ?? colorScheme.primary),
          ),
        ),
      ),
    );
  }
}
