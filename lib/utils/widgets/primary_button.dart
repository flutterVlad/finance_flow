import 'package:finance_flow/utils/theme.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    this.onTap,
    this.enabled = true,
    required this.text,
    this.isLoading = false,
  });

  final VoidCallback? onTap;
  final bool enabled;
  final String text;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Material(
      type: .button,
      color: enabled ? AppColors.primary : AppColors.grey,
      borderRadius: .circular(16),
      elevation: 3,
      child: InkWell(
        borderRadius: .circular(16),
        onTap: enabled ? onTap : null,
        child: SizedBox(
          height: 50,
          child: Center(
            child: isLoading
                ? const CircularProgressIndicator.adaptive(strokeWidth: 2)
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
    );
  }
}
