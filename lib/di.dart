import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:talker/talker.dart';
import 'package:talker_bloc_logger/talker_bloc_logger.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';

import '/data/repositories/currency_repository_impl.dart';
import '/domain/repositories/currency_repository.dart';
import '/domain/use_cases/delete_account_use_case.dart';
import '/presentation/bloc/expense_bloc.dart';
import 'data/data_sources/local_datasource.dart';
import 'data/repositories/card_repository_impl.dart';
import 'data/repositories/expense_repository_impl.dart';
import 'data/repositories/settings_repository_impl.dart';
import 'data/service/encryption_key_service.dart';
import 'data/service/hive_service.dart';
import 'data/service/image_picker.dart';
import 'data/service/secure_storage_service.dart';
import 'domain/repositories/card_repository.dart';
import 'domain/repositories/expense_repository.dart';
import 'domain/repositories/settings_repository.dart';
import 'presentation/screens/actions_screen/features/add_transaction/bloc/transactions_cubit.dart';
import 'presentation/screens/home_screen/features/settings/bloc/settings_bloc.dart';

class DI {
  Future<void> initDI() async {
    _initTalker();
    _initDio();
    await _initServices();
    _initRepositories();
    _initUseCases();
    _initBloc();
  }

  void _initBloc() {
    GetIt.I.registerSingleton<SettingsBloc>(
      SettingsBloc(
        settingsRepository: GetIt.I<SettingsRepository>(),
        cardRepository: GetIt.I<CardRepository>(),
        deleteAccountUseCase: GetIt.I<DeleteAccountUseCase>(),
      ),
    );
    GetIt.I.registerLazySingleton<ExpenseBloc>(
      () => ExpenseBloc(
        expenseRepository: GetIt.I<ExpenseRepository>(),
        settingsBloc: GetIt.I<SettingsBloc>(),
      ),
    );
    GetIt.I.registerFactory(
      () =>
          TransactionsCubit(currencyRepository: GetIt.I<CurrencyRepository>()),
    );
  }

  void _initTalker() {
    final talker = Talker(
      logger: TalkerLogger(output: (message) => log(message, name: 'Talker')),
    );
    GetIt.I.registerSingleton<Talker>(talker);
    Bloc.observer = TalkerBlocObserver(talker: talker);
  }

  void _initDio() {
    final dio = Dio(BaseOptions());
    GetIt.I.registerSingleton<Dio>(dio);
    final talker = GetIt.I<Talker>();
    dio.interceptors.add(TalkerDioLogger(talker: talker));
  }

  void _initRepositories() {
    GetIt.I.registerLazySingleton<ExpenseRepository>(
      () => ExpenseRepositoryImpl(hiveService: GetIt.I<HiveService>()),
    );
    GetIt.I.registerLazySingleton<SettingsRepository>(
      () => SettingsRepositoryImpl(
        hiveService: GetIt.I<HiveService>(),
        imagePickerService: GetIt.I<ImagePickerService>(),
      ),
    );
    GetIt.I.registerLazySingleton<CardRepository>(
      () => CardRepositoryImpl(
        hiveService: GetIt.I<HiveService>(),
        encryptionKeyService: GetIt.I<EncryptionKeyService>(),
      ),
    );
    GetIt.I.registerLazySingleton<CurrencyRepository>(
      () => CurrencyRepositoryImpl(dio: GetIt.I<Dio>()),
    );
  }

  Future<void> _initServices() async {
    GetIt.I.registerLazySingleton(() => const SecureStorageService());
    GetIt.I.registerLazySingleton(
      () =>
          EncryptionKeyService(secureStorage: GetIt.I<SecureStorageService>()),
    );
    GetIt.I.registerLazySingleton(() => const MockLocalService());
    GetIt.I.registerLazySingleton(() => const ImagePickerService());
    GetIt.I.registerLazySingleton(() => const HiveService());
    await GetIt.I<HiveService>().init();
  }

  void _initUseCases() {
    GetIt.I.registerLazySingleton(
      () => DeleteAccountUseCase(
        cardRepository: GetIt.I<CardRepository>(),
        expenseRepository: GetIt.I<ExpenseRepository>(),
        settingsRepository: GetIt.I<SettingsRepository>(),
      ),
    );
  }
}
