import 'package:finance_flow/utils/svgs/svg.dart';
import 'package:finance_flow/utils/svgs/svgs.dart';
import 'package:finance_flow/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ActionsScreen extends StatelessWidget {
  const ActionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const SliverAppBar(
          backgroundColor: Colors.transparent,
          title: Text('Actions', style: TextStyle(fontWeight: .bold)),
        ),
        SliverToBoxAdapter(
          child: ActionCard(
            title: 'Add transaction',
            icon: Svgs.addRounded,
            onPressed: () {
              context.pushNamed('add_transaction');
            },
          ),
        ),
        SliverToBoxAdapter(
          child: ActionCard(
            title: 'Add category',
            icon: Svgs.category,
            onPressed: () {},
          ),
        ),
      ],
    );
  }
}

class ActionCard extends StatelessWidget {
  final void Function()? onPressed;
  final String title;
  final SvgData icon;

  const ActionCard({
    super.key,
    this.onPressed,
    required this.title,
    this.icon = Svgs.home,
  });

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
