import 'package:flutter/material.dart';

import 'widgets/avatar_view.dart';
import 'widgets/settings_column.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final firstSettings = [
      SettingElement(
        icon: Icons.person,
        title: 'Personal Information',
        onTap: () {},
      ),
      SettingElement(icon: Icons.language, title: 'Language', onTap: () {}),
      SettingElement(
        icon: Icons.credit_card_rounded,
        title: 'Payment method',
        onTap: () {},
      ),
    ];

    final secondSettings = [
      SettingElement(
        icon: Icons.security,
        title: 'Account Security',
        onTap: () {},
      ),
      SettingElement(
        icon: Icons.notifications_none,
        title: 'Notifications',
        onTap: () {},
      ),
      SettingElement(
        icon: Icons.delete_outline,
        title: 'Clear Cache',
        onTap: () {},
      ),
      SettingElement(icon: Icons.settings, title: 'Settings', onTap: () {}),
    ];

    final thirdSettings = [
      SettingElement(
        icon: Icons.help_outline,
        title: 'Help Centre',
        onTap: () {},
      ),
      SettingElement(
        icon: Icons.policy_outlined,
        title: 'Privacy & Policy',
        onTap: () {},
      ),
      SettingElement(
        icon: Icons.info_outline,
        title: 'Abount App',
        onTap: () {},
      ),
    ];

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: const Text(
              'My Profile',
              style: TextStyle(fontWeight: .bold),
            ),
            pinned: true,
            actions: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
            ],
          ),
          const SliverToBoxAdapter(child: AvatarView()),
          SliverToBoxAdapter(child: SettingsColumn(elements: firstSettings)),
          SliverToBoxAdapter(child: SettingsColumn(elements: secondSettings)),
          SliverToBoxAdapter(child: SettingsColumn(elements: thirdSettings)),
        ],
      ),
    );
  }
}
