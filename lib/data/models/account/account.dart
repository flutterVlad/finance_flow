import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_serializable_uuid_converter/json_serializable_uuid_converter.dart';
import 'package:uuid/uuid.dart';

part 'account.freezed.dart';
part 'account.g.dart';

@freezed
abstract class Account with _$Account {
  const Account._();

  const factory Account({
    @UuidValueConverter() required UuidValue uid,
    required String login,
    required String email,
    required String firstName,
    required String lastName,
  }) = _Account;

  static const Account empty = Account(
    uid: UuidValue.fromNamespace(.url),
    login: 'empty',
    email: 'empty',
    firstName: 'empty',
    lastName: 'empty',
  );

  bool get isEmpty =>
      login == 'empty' &&
      email == 'empty' &&
      firstName == 'empty' &&
      lastName == 'empty';

  factory Account.fromJson(Map<String, dynamic> json) =>
      _$AccountFromJson(json);
}
