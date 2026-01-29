import 'package:flutter/material.dart';

import '/presentation/screens/wallet_screen/widgets/card_swipper.dart';
import '/presentation/screens/wallet_screen/widgets/weekly_expense.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomScrollView(
      slivers: [
        SliverAppBar(
          backgroundColor: Colors.transparent,
          title: Text('Wallet', style: TextStyle(fontWeight: .bold)),
        ),
        SliverToBoxAdapter(child: CardSwiper()),
        SliverToBoxAdapter(child: SafeArea(top: false, child: WeeklyExpense())),
      ],
    );
  }
}
