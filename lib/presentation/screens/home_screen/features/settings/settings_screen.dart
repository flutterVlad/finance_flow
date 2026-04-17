import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '/l10n/app_localizations.dart';
import '/presentation/screens/home_screen/features/settings/bloc/settings_bloc.dart';
import '/presentation/screens/home_screen/widgets/avatar_view.dart';
import '/utils/theme.dart';
import '/utils/widgets/toast_service.dart';
import 'widgets/settings_column.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final account = context.select(
      (SettingsBloc settings) => settings.state.selectedAccount,
    );

    final firstSettings = [
      SettingElement(
        icon: Icons.person,
        title: account != null ? s.editAccount : s.createAccount,
        onTap: () {
          context.pushNamed('editAccount', extra: account);
        },
      ),
      SettingElement(icon: Icons.language, title: s.language, onTap: () {}),
      SettingElement(
        icon: Icons.credit_card_rounded,
        title: s.paymentMethod,
        onTap: () {},
      ),
    ];

    final secondSettings = [
      SettingElement(
        icon: Icons.security,
        title: s.accountSecurity,
        onTap: () {},
      ),
      SettingElement(
        icon: Icons.notifications_none,
        title: s.notifications,
        onTap: () {},
      ),
      SettingElement(
        icon: Icons.delete_outline,
        title: s.clearCache,
        onTap: () {},
      ),
      SettingElement(icon: Icons.settings, title: s.settings, onTap: () {}),
    ];

    final thirdSettings = [
      SettingElement(
        icon: Icons.help_outline,
        title: s.helpCentre,
        onTap: () {},
      ),
      SettingElement(
        icon: Icons.policy_outlined,
        title: s.privacyPolicy,
        onTap: () {},
      ),
      SettingElement(icon: Icons.info_outline, title: s.aboutApp, onTap: () {}),
    ];

    return BlocListener<SettingsBloc, SettingsState>(
      listener: (context, state) {
        if (state.response != null) {
          ToastService.showToast(
            message: state.response!.message,
            status: state.response!.success ? .success : .error,
          );
        }
      },
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: Text(
                s.myProfile,
                style: const TextStyle(fontWeight: .bold),
              ),
              backgroundColor: AppColors.secondary,
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
