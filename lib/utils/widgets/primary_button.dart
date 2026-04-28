import 'package:finance_flow/utils/theme.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    this.onTap,
    this.enabled = true,
    required this.text,
    this.isLoading = false,
    this.color,
  });

  final VoidCallback? onTap;
  final bool enabled;
  final String text;
  final bool isLoading;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final buttonColor = color ?? AppColors.primary;

    return TweenAnimationBuilder(
      duration: kThemeChangeDuration,
      tween: ColorTween(
        begin: enabled ? AppColors.grey : buttonColor,
        end: enabled ? buttonColor : AppColors.grey,
      ),
      builder: (_, color, _) => Material(
        type: .button,
        color: color,
        borderRadius: .circular(16),
        elevation: 3,
        child: InkWell(
          borderRadius: .circular(16),
          onTap: !isLoading && enabled ? onTap : null,
          child: SizedBox(
            height: 48,
            child: Center(
              child: isLoading
                  ? const SizedBox.square(
                      dimension: 20,
                      child: CircularProgressIndicator.adaptive(
                        strokeWidth: 2,
                        backgroundColor: AppColors.onPrimary,
                      ),
                    )
                  : Text(
                      text,
                      style: const TextStyle(
                        color: AppColors.onPrimary,
                        fontSize: 16,
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
