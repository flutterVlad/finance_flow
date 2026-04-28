import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/l10n/app_localizations.dart';
import '/presentation/bloc/settings/settings_bloc.dart';
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
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.transparent,
            centerTitle: true,
            title: Text(
              S.of(context).wallet,
              style: const TextStyle(fontWeight: .bold),
            ),
          ),
          const SliverToBoxAdapter(child: CardSwiper()),
          const SliverToBoxAdapter(
            child: SafeArea(top: false, child: WeeklyExpense()),
          ),
        ],
      ),
    );
  }
}
