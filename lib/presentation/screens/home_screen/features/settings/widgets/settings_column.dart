import 'package:finance_flow/utils/theme.dart';
import 'package:flutter/material.dart';

class SettingsColumn extends StatelessWidget {
  const SettingsColumn({super.key, this.elements = const []});

  final List<SettingElement> elements;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const .all(16),
      child: ClipRRect(
        borderRadius: .circular(16),
        child: Material(
          borderRadius: .circular(16),
          color: AppColors.onPrimary,
          child: ListView.separated(
            shrinkWrap: true,
            padding: .zero,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return elements[index];
            },
            separatorBuilder: (_, _) {
              return const Divider(color: AppColors.lightGrey, height: 0);
            },
            itemCount: elements.length,
          ),
        ),
      ),
    );
  }
}

class SettingElement extends StatelessWidget {
  const SettingElement({
    super.key,
    required this.icon,
    required this.title,
    this.onTap,
  });

  final VoidCallback? onTap;
  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          spacing: 8,
          children: [
            Icon(icon, color: AppColors.primary),
            Expanded(
              child: Text(title, style: const TextStyle(fontWeight: .w500)),
            ),
            const Icon(Icons.keyboard_arrow_right, color: AppColors.lightGrey),
          ],
        ),
      ),
    );
  }
}
