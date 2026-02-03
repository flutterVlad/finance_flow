import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/date_symbol_data_local.dart';

import '/presentation/screens/home_screen/bloc/home_bloc.dart';
import '/presentation/screens/home_screen/features/settings/bloc/settings_bloc.dart';
import '/presentation/screens/wallet_screen/bloc/wallet_bloc.dart';
import '/utils/navigation/router.dart';
import '/utils/theme.dart';
import 'di.dart';

class FinanceFlowApp extends StatelessWidget {
  const FinanceFlowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => GetIt.I<SettingsBloc>()),
        BlocProvider(create: (_) => GetIt.I<HomeBloc>()),
        BlocProvider(create: (_) => GetIt.I<WalletBloc>()),
      ],
      child: MaterialApp.router(
        restorationScopeId: 'app',
        routerConfig: router,
        theme: AppTheme.lightTheme,
        themeMode: .light,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('ru_RU', null);
  await DI().initDI();
  runApp(const FinanceFlowApp());
}
