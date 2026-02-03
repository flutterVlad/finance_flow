import 'dart:async';
import 'dart:typed_data';

import 'package:collection/collection.dart';
import 'package:uuid/uuid.dart';

import '/data/mappers/account_mapper.dart';
import '/data/models/account/account.dart';
import '/data/models/expense/expense.dart';
import '/data/models/response/response.dart';
import '/data/service/hive_service.dart';
import '/data/service/image_picker.dart';
import '/domain/repositories/settings_repository.dart';
import '/presentation/screens/home_screen/features/settings/bloc/settings_bloc.dart';

final class SettingsRepositoryImpl implements SettingsRepository {
  final HiveService hiveService;
  final ImagePickerService imagePickerService;

  const SettingsRepositoryImpl({
    required this.hiveService,
    required this.imagePickerService,
  });

  @override
  Future<Response> clearCache() async {
    return await hiveService.deleteAllData<Expense>();
  }

  @override
  Future<(Response, Account?)> savePersonInfo(AccountForm form) async {
    if (form.uid == null) {
      return await createAccount(form);
    }

    final response = await hiveService.updateData<Account>(
      form.uid!.uuid,
      form.toDomain(),
    );

    if (response.success) return (response, form.toDomain());
    return (response, null);
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

  @override
  Future<(Response, Account?)> createAccount(AccountForm form) async {
    final uid = UuidValue.fromString(const Uuid().v4());
    final account = form.toDomain().copyWith(uid: uid);

    final response = await hiveService.putData<Account>(
      account.uid!.uuid,
      account,
    );

    if (response.success) return (response, account);

    return (response, null);
  }

  @override
  Future<Response> deleteAccount(String uid) async {
    return await hiveService.deleteData<Account>(uid);
  }

  @override
  Future<Response> deleteAllAccounts() async {
    return await hiveService.deleteAllData<Account>();
  }

  @override
  Future<Uint8List?> pickImage() async {
    return await imagePickerService.pickImage();
  }
}
