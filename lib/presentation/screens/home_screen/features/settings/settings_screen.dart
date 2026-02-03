import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '/presentation/screens/home_screen/features/settings/bloc/settings_bloc.dart';
import '/presentation/screens/home_screen/widgets/avatar_view.dart';
import '/utils/widgets/toast_service.dart';
import 'widgets/settings_column.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final account = context.select(
      (SettingsBloc settings) => settings.state.selectedAccount,
    );

    final firstSettings = [
      SettingElement(
        icon: Icons.person,
        title: 'Personal Information',
        onTap: () {
          context.pushNamed('editAccount', extra: account);
        },
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

    return BlocListener<SettingsBloc, SettingsState>(
      listener: (context, state) {
        if (state.response != null) {
          ToastService.showToast(
            message: state.response?.message,
            success: state.response?.success,
          );
        }
      },
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: const Text(
                'My Profile',
                style: TextStyle(fontWeight: .bold),
              ),
              pinned: true,
              actions: [
                IconButton(
                  onPressed: () {
                    context.read<SettingsBloc>().add(
                      const DeleteAllAccountsEvent(),
                    );
                  },
                  icon: const Icon(Icons.more_vert),
                ),
              ],
            ),
            const SliverToBoxAdapter(
              child: AspectRatio(
                aspectRatio: 2.5,
                child: Center(child: AvatarView(imageSize: 80)),
              ),
            ),
            SliverToBoxAdapter(child: SettingsColumn(elements: firstSettings)),
            SliverToBoxAdapter(child: SettingsColumn(elements: secondSettings)),
            SliverToBoxAdapter(child: SettingsColumn(elements: thirdSettings)),
          ],
        ),
      ),
    );
  }
}
