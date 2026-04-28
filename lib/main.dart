import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';

import '/presentation/bloc/expense/expense_bloc.dart';
import 'di.dart';
import 'l10n/app_localizations.dart';
import 'presentation/bloc/settings/settings_bloc.dart';
import 'utils/navigation/router.dart';
import 'utils/theme.dart';

class FinanceFlowApp extends StatelessWidget {
  const FinanceFlowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<SettingsBloc>()),
        BlocProvider(create: (_) => getIt<ExpenseBloc>()),
      ],
      child: BlocSelector<SettingsBloc, SettingsState, Locale>(
        selector: (state) => state.locale,
        builder: (context, locale) {
          return MaterialApp.router(
            restorationScopeId: 'app',
            routerConfig: router,
            theme: AppTheme.lightTheme,
            themeMode: .light,
            debugShowCheckedModeBanner: false,
            localizationsDelegates: S.localizationsDelegates,
            supportedLocales: S.supportedLocales,
            locale: locale,
          );
        },
      ),
    );
  }
}

Future<void> main() async {
  // ignore: avoid_single_cascade_in_expression_statements
  final binding = WidgetsFlutterBinding.ensureInitialized()..deferFirstFrame();
  await initializeDateFormatting();
  await DI().initDI();
  binding.allowFirstFrame();
  runApp(const FinanceFlowApp());
}
