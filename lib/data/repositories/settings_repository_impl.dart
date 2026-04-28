import 'dart:async';
import 'dart:typed_data';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '/data/hive_boxes.dart';
import '/data/mappers/account_mapper.dart';
import '/data/models/account/account.dart';
import '/data/models/response/response.dart';
import '/data/service/hive_service.dart';
import '/data/service/image_picker.dart';
import '/domain/repositories/settings_repository.dart';
import '/presentation/bloc/settings/settings_bloc.dart';

final class SettingsRepositoryImpl implements SettingsRepository {
  const SettingsRepositoryImpl({
    required this.hiveService,
    required this.imagePickerService,
  });

  final HiveService hiveService;
  final ImagePickerService imagePickerService;

  @override
  Future<(Response, Account?)> savePersonInfo(AccountForm form) async {
    if (form.uid == null) {
      return await createAccount(form);
    }

    final response = await hiveService.updateData<Account>(
      form.uid!.uuid,
      form.toDomain(),
      boxKey: HiveBoxes.accounts(),
    );

    if (response.success) {
      return (
        response.changeSuccessMessage('Account data updated'),
        form.toDomain(),
      );
    }
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
    return await hiveService.getAllData<Account>(boxKey: HiveBoxes.accounts());
  }

  @override
  Future<(Response, Account?)> createAccount(AccountForm form) async {
    final uid = UuidValue.fromString(const Uuid().v4());
    final account = form.toDomain().copyWith(uid: uid);

    final response = await hiveService.putData<Account>(
      account.uid!.uuid,
      account,
      boxKey: HiveBoxes.accounts(),
    );

    if (response.success) {
      return (response.changeSuccessMessage('Account created'), account);
    }

    return (response, null);
  }

  @override
  Future<Response> deleteAccount(String id) async {
    final response = await hiveService.deleteData<Account>(
      id,
      boxKey: HiveBoxes.accounts(),
    );

    return response.changeSuccessMessage('Account deleted');
  }

  @override
  Future<Response> deleteAllAccounts() async {
    final response = await hiveService.deleteAllData<Account>(
      boxKey: HiveBoxes.accounts(),
    );

    return response.changeSuccessMessage('All accounts deleted');
  }

  @override
  Future<Uint8List?> pickImage() async {
    return await imagePickerService.pickImage();
  }

  @override
  Future<void> saveLocale(String locale) async {
    await hiveService.putData<String>('locale', locale, boxKey: 'Locale');
  }

  @override
  Future<Locale> getLocale() async {
    final saved = await hiveService.getData<String>('locale', boxKey: 'Locale');
    if (saved != null) return Locale(saved);

    final systemLocale = WidgetsBinding.instance.platformDispatcher.locale;
    return systemLocale;
  }
}
