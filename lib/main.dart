import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'di.dart';
import 'l10n/app_localizations.dart';
import 'presentation/screens/home_screen/bloc/home_bloc.dart';
import 'presentation/screens/home_screen/features/settings/bloc/settings_bloc.dart';
import 'utils/navigation/router.dart';
import 'utils/theme.dart';

class FinanceFlowApp extends StatelessWidget {
  const FinanceFlowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => GetIt.I<SettingsBloc>()),
        BlocProvider(create: (_) => GetIt.I<HomeBloc>()),
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
