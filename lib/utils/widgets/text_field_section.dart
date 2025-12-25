import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../theme.dart';

class Section extends StatelessWidget {
  final String title;
  final String? hintText;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final Widget? suffixIcon;
  final Widget? suffix;
  final Widget? prefixIcon;
  final Widget? prefix;
  final TextEditingController? controller;
  final int maxLength;
  final bool enableSuggestions;
  final void Function()? onTap;
  final void Function(String?)? onSubmit;
  final String? errorText;
  final bool isNumber;
  final bool isBool;
  final bool boolValue;
  final void Function(bool)? onBoolChange;

  const Section({
    super.key,
    required this.title,
    this.controller,
    this.hintText,
    this.inputFormatters,
    this.keyboardType,
    this.suffixIcon,
    this.suffix,
    this.prefixIcon,
    this.prefix,
    this.maxLength = 50,
    this.enableSuggestions = false,
    this.onTap,
    this.onSubmit,
    this.errorText,
    this.isNumber = false,
    this.isBool = false,
    this.boolValue = false,
    this.onBoolChange,
  });

  @override
  Widget build(BuildContext context) {
    if (!isBool) {
      return Column(
        crossAxisAlignment: .start,
        spacing: 8,
        children: [
          Text(title, style: const TextStyle(fontWeight: .bold, fontSize: 16)),
          InkWell(
            onTap: onTap,
            borderRadius: .circular(16),
            child: TextFormField(
              enableSuggestions: enableSuggestions,
              controller: controller,
              enabled: onTap == null,
              style: onTap != null
                  ? const TextStyle(color: AppColors.onSecondary)
                  : null,
              keyboardType: keyboardType,
              inputFormatters: [
                LengthLimitingTextInputFormatter(maxLength),
                ...(inputFormatters ?? []),
              ],
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: const TextStyle(color: AppColors.grey),
                suffix: suffix,
                prefix: prefix,
                suffixIcon: suffixIcon,
                prefixIcon: prefixIcon != null
                    ? Padding(
                        padding: const .only(left: 8.0),
                        child: prefixIcon,
                      )
                    : null,
                errorText: errorText,
                prefixIconConstraints: const BoxConstraints(
                  maxHeight: 50,
                  maxWidth: 50,
                ),
              ),
              onChanged: (value) {
                onSubmit?.call(controller?.text);
              },
              onEditingComplete: () {
                onSubmit?.call(controller?.text);
                FocusManager.instance.primaryFocus?.unfocus();
              },
              onSaved: onSubmit,
              onTapOutside: (_) {
                onSubmit?.call(controller?.text);
                FocusManager.instance.primaryFocus?.unfocus();
              },
            ),
          ),
        ],
      );
    } else {
      return Row(
        mainAxisAlignment: .spaceBetween,
        crossAxisAlignment: .center,
        children: [
          Text(title, style: const TextStyle(fontWeight: .bold, fontSize: 16)),
          Switch.adaptive(
            value: boolValue,
            onChanged: onBoolChange,
            activeTrackColor: AppColors.primary,
          ),
        ],
      );
    }
  }
}
