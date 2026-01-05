import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '/presentation/screens/actions_screen/actions_screen.dart';
import '/presentation/screens/actions_screen/features/add_transaction/add_transaction_screen.dart';
import '/presentation/screens/home_screen/features/view_all_expenses/view_all_expenses_screen.dart';
import '/presentation/screens/home_screen/home_screen.dart';
import '/presentation/screens/statistics_screen/statistics_screen.dart';
import '/presentation/screens/wallet_screen/wallet_screen.dart';
import 'main_scaffold.dart';

final router = GoRouter(
  restorationScopeId: 'router',
  initialLocation: '/home',
  observers: [HeroController()],
  routes: [
    StatefulShellRoute.indexedStack(
      restorationScopeId: 'appShell',
      pageBuilder: (context, state, navigationShell) {
        return MaterialPage(
          restorationId: 'appShellPage',
          child: MainScaffold(navigationShell: navigationShell),
        );
      },
      branches: [
        StatefulShellBranch(
          restorationScopeId: 'homeBranch',
          routes: [
            GoRoute(
              path: '/home',
              name: 'home',
              pageBuilder: (context, state) {
                return MaterialPage(
                  key: state.pageKey,
                  child: const HomeScreen(),
                );
              },
            ),
            GoRoute(
              path: '/home/detail',
              name: 'detail',
              pageBuilder: (context, state) {
                return MaterialPage(
                  key: state.pageKey,
                  child: const Placeholder(),
                );
              },
            ),
          ],
        ),
        StatefulShellBranch(
          restorationScopeId: 'walletBranch',
          routes: [
            GoRoute(
              path: '/wallet',
              name: 'wallet',
              pageBuilder: (context, state) {
                return MaterialPage(
                  key: state.pageKey,
                  child: const WalletScreen(),
                );
              },
            ),
          ],
        ),
        StatefulShellBranch(
          restorationScopeId: 'transactionBranch',
          routes: [
            GoRoute(
              path: '/actions',
              name: 'actions',
              pageBuilder: (context, state) {
                return MaterialPage(
                  key: state.pageKey,
                  child: const ActionsScreen(),
                );
              },
            ),
          ],
        ),
        StatefulShellBranch(
          restorationScopeId: 'statisticsBranch',
          routes: [
            GoRoute(
              path: '/statistics',
              name: 'statistics',
              pageBuilder: (context, state) {
                return MaterialPage(
                  key: state.pageKey,
                  child: const StatisticsScreen(),
                );
              },
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      path: '/add_transaction',
      name: 'add_transaction',
      pageBuilder: (context, state) {
        return MaterialPage(
          key: state.pageKey,
          child: AddTransactionScreen(onInit: state.extra as Function()?),
        );
      },
    ),
    GoRoute(
      path: '/view_all_expenses',
      name: 'view_all_expenses',
      pageBuilder: (context, state) {
        return MaterialPage(
          key: state.pageKey,
          child: const ViewAllExpensesScreen(),
        );
      },
    ),
  ],
);
