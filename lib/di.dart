import 'package:finance_flow/data/repositories/expense_repository_impl.dart';
import 'package:finance_flow/domain/repositories/expense_repository.dart';
import 'package:finance_flow/domain/use_cases/add_expense_use_case.dart';
import 'package:finance_flow/domain/use_cases/get_all_expenses_use_case.dart';
import 'package:get_it/get_it.dart';

import 'data/data_sources/local_datasource.dart';
import 'data/service/hive_service.dart';
import 'domain/use_cases/get_day_expenses_use_case.dart';
import 'presentation/screens/actions_screen/features/add_transaction/bloc/transactions_cubit.dart';
import 'presentation/screens/home_screen/bloc/home_bloc.dart';
import 'presentation/screens/wallet_screen/bloc/wallet_bloc.dart';

class DI {
  Future<void> initDI() async {
    await _initServices();
    _initRepositories();
    _initUseCases();
    _initBloc();
  }

  void _initBloc() {
    GetIt.I.registerLazySingleton<HomeBloc>(
      () => HomeBloc(
        getDayExpensesUseCase: GetIt.I<GetDayExpensesUseCase>(),
        // getMockExpensesUseCase: GetIt.I<GetMockExpensesUseCase>(),
        // updateDataUseCase: GetIt.I<UpdateDataUseCase>(),
        getAllExpensesUseCase: GetIt.I<GetAllExpensesUseCase>(),
        addExpenseUseCase: GetIt.I<AddExpenseUseCase>(),
      ),
    );
    GetIt.I.registerLazySingleton<WalletBloc>(() => WalletBloc());
    GetIt.I.registerLazySingleton(() => TransactionsCubit());
  }

  void _initRepositories() {
    GetIt.I.registerLazySingleton<ExpenseRepository>(
      () => ExpenseRepositoryImpl(hiveService: GetIt.I<HiveService>()),
    );
  }

  Future<void> _initServices() async {
    GetIt.I.registerLazySingleton(() => const MockLocalService());
    GetIt.I.registerLazySingleton(() => HiveService());
    await GetIt.I<HiveService>().init();
  }

  void _initUseCases() {
    GetIt.I.registerLazySingleton(
      () => GetDayExpensesUseCase(localService: GetIt.I<MockLocalService>()),
    );
    GetIt.I.registerLazySingleton(
      () => GetAllExpensesUseCase(
        expenseRepository: GetIt.I<ExpenseRepository>(),
      ),
    );
    GetIt.I.registerLazySingleton(
      () => AddExpenseUseCase(expenseRepository: GetIt.I<ExpenseRepository>()),
    );
  }
}
