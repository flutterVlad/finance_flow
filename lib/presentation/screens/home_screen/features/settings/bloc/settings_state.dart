part of 'settings_bloc.dart';

enum Language {
  ru('ru_RU'),
  us('us_US');

  final String value;

  const Language(this.value);
}

@freezed
abstract class SettingsState with _$SettingsState {
  const factory SettingsState({
    Account? account,
    @Default(Language.us) Language language,
  }) = _SettingsState;
}

@freezed
abstract class AccountForm with FormzMixin, _$AccountForm {
  const AccountForm._();

  const factory AccountForm({
    UuidValue? uid,
    @Default(Email.pure()) Email email,
    @Default(FirstName.pure()) FirstName firstName,
    @Default(LastName.pure()) LastName lastName,
  }) = _AccountForm;

  @override
  List<FormzInput> get inputs => [email, firstName, lastName];
}
