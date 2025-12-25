import 'package:flutter/material.dart';

import 'widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverPersistentHeader(
          pinned: true,
          floating: true,
          delegate: BlurAppBarDelegate(
            minHeight: 60 + MediaQuery.paddingOf(context).top,
            maxHeight: 100 + MediaQuery.paddingOf(context).top,
          ),
        ),
        const SliverToBoxAdapter(child: WalletBalance()),
        const SliverToBoxAdapter(child: ExpenseAnalytics()),
        const SliverToBoxAdapter(
          child: SafeArea(top: false, child: TodayExpenses()),
        ),
      ],
    );
  }
}
