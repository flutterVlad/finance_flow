import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '/l10n/app_localizations.dart';
import '/utils/svgs/svg.dart';
import '/utils/theme.dart';

class ActionsScreen extends StatelessWidget {
  const ActionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return CustomScrollView(
      slivers: [
        SliverAppBar(
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: Text(s.actions, style: const TextStyle(fontWeight: .bold)),
        ),
        SliverToBoxAdapter(
          child: ActionCard(
            title: s.addTransaction,
            icon: Svgs.addRounded,
            onPressed: () {
              context.pushNamed('add_transaction');
            },
          ),
        ),
      ],
    );
  }
}

class ActionCard extends StatelessWidget {
  const ActionCard({
    super.key,
    this.onPressed,
    required this.title,
    this.icon = Svgs.home,
  });

  final void Function()? onPressed;
  final String title;
  final SvgData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const .symmetric(horizontal: 16, vertical: 4),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: .circular(16)),
        color: AppColors.onPrimary,
        elevation: 0,
        child: InkWell(
          onTap: onPressed,
          borderRadius: .circular(16),
          splashColor: AppColors.secondary,
          child: Padding(
            padding: const .symmetric(horizontal: 16, vertical: 12),
            child: Row(
              spacing: 8,
              children: [
                Svg(icon, size: 20),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(fontSize: 16, fontWeight: .bold),
                  ),
                ),
                const Icon(Icons.keyboard_arrow_right_outlined),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
