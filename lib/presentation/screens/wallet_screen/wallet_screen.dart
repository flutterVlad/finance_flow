import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/presentation/screens/home_screen/features/settings/bloc/settings_bloc.dart';
import '/presentation/screens/wallet_screen/widgets/card_swipper.dart';
import '/presentation/screens/wallet_screen/widgets/weekly_expense.dart';
import '/utils/widgets/toast_service.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SettingsBloc, SettingsState>(
      listener: (context, state) {
        if (state.response != null) {
          ToastService.showToast(
            message: state.response?.message,
            status: state.response?.success == true ? .success : .error,
          );
        }
      },
      child: const CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.transparent,
            centerTitle: true,
            title: Text('Wallet', style: TextStyle(fontWeight: .bold)),
          ),
          SliverToBoxAdapter(child: CardSwiper()),
          SliverToBoxAdapter(
            child: SafeArea(top: false, child: WeeklyExpense()),
          ),
        ],
      ),
    );
  }
}
