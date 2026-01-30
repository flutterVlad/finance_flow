import 'dart:async';

import '/data/models/account/account.dart';
import '/presentation/screens/home_screen/features/settings/bloc/settings_bloc.dart';

abstract class SettingsRepository {
  FutureOr<Account?> fetchAccount([List<Account>? accounts]);

  Future<List<Account>> fetchAllAccount();

  Future<void> clearCache();

  Future<Account> savePersonInfo(AccountForm form);
}
