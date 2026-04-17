part of 'settings_bloc.dart';

@freezed
abstract class SettingsState with _$SettingsState {
  const SettingsState._();

  const factory SettingsState({
    Account? selectedAccount,
    @Default([]) List<Account> allAccounts,
    Response? response,
    @Default([]) List<BankCard> cards,
    @Default(Locale('en')) Locale locale,
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

  bool equals(AccountForm? other) {
    if (other == null) return false;

    return other.email.value == email.value &&
        other.firstName.value == firstName.value &&
        other.lastName.value == lastName.value &&
        other.image == image;
  }
}
