import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_serializable_uuid_converter/json_serializable_uuid_converter.dart';
import 'package:uuid/uuid.dart';

part 'account.g.dart';

@JsonSerializable(converters: [UuidValueConverter()])
class Account extends Equatable {
  final UuidValue uid;

  final String login;

  final String firstName;

  final String lastName;

  final String email;

  const Account({
    required this.uid,
    required this.login,
    required this.email,
    required this.firstName,
    required this.lastName,
  });

  @override
  List<Object?> get props => [uid, login, firstName, lastName, email];

  factory Account.fromJson(Map<String, dynamic> json) =>
      _$AccountFromJson(json);

  Map<String, dynamic> toJson() => _$AccountToJson(this);
}
