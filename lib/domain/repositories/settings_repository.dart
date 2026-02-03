import 'dart:async';
import 'dart:typed_data';

import '/data/models/account/account.dart';
import '/data/models/response/response.dart';
import '/presentation/screens/home_screen/features/settings/bloc/settings_bloc.dart';

abstract class SettingsRepository {
  FutureOr<Account?> fetchAccount([List<Account>? accounts]);

  Future<List<Account>> fetchAllAccount();

  Future<Response> clearCache();

  Future<(Response, Account?)> savePersonInfo(AccountForm form);

  Future<(Response, Account?)> createAccount(AccountForm form);

  Future<Response> deleteAccount(String uid);

  Future<Response> deleteAllAccounts();

  Future<Uint8List?> pickImage();
}
