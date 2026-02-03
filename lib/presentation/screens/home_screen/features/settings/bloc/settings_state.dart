part of 'settings_bloc.dart';

enum Language {
  ru('ru_RU'),
  us('us_US');

  final String value;

  const Language(this.value);
}

@freezed
abstract class SettingsState with _$SettingsState {
  const SettingsState._();

  const factory SettingsState({
    Account? selectedAccount,
    @Default([]) List<Account> allAccounts,
    @Default(Language.us) Language language,
    Response? response,
  }) = _SettingsState;

  bool get isAccountEmpty => selectedAccount == null;
}

@freezed
abstract class AccountForm with FormzMixin, _$AccountForm {
  const AccountForm._();

  const factory AccountForm({
    UuidValue? uid,
    Uint8List? image,
    @Default(Email.pure()) Email email,
    @Default(FirstName.pure()) FirstName firstName,
    @Default(LastName.pure()) LastName lastName,
    @Default(true) bool isPrimary,
  }) = _AccountForm;

  @override
  List<FormzInput> get inputs => [email, firstName, lastName];
}
