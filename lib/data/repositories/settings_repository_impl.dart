import 'dart:async';

import 'package:collection/collection.dart';
import 'package:uuid/uuid.dart';

import '/data/mappers/account_mapper.dart';
import '/data/models/account/account.dart';
import '/data/models/expense/expense.dart';
import '/data/service/hive_service.dart';
import '/domain/repositories/settings_repository.dart';
import '/presentation/screens/home_screen/features/settings/bloc/settings_bloc.dart';

final class SettingsRepositoryImpl implements SettingsRepository {
  final HiveService hiveService;

  const SettingsRepositoryImpl({required this.hiveService});

  @override
  Future<void> clearCache() async {
    await hiveService.deleteAllData<Expense>();
  }

  @override
  Future<Account> savePersonInfo(AccountForm form) async {
    Account account = form.toDomain();
    if (form.uid != null) {
      final uid = UuidValue.fromString(const Uuid().v4());
      account = account.copyWith(uid: uid);
      await hiveService.putData<Account>(uid, account);
    } else {
      await hiveService.putData<Account>(account.uid, account);
    }

    return account;
  }

  @override
  FutureOr<Account?> fetchAccount([List<Account>? existAccounts]) async {
    final accounts = existAccounts ?? await fetchAllAccount();
    final account = accounts.firstWhereOrNull((e) => e.isPrimary);

    return account;
  }

  @override
  Future<List<Account>> fetchAllAccount() async {
    return await hiveService.getAllData<Account>();
  }
}
