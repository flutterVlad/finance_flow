import 'dart:convert';
import 'dart:typed_data';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_serializable_uuid_converter/json_serializable_uuid_converter.dart';
import 'package:uuid/uuid.dart';

part 'account.freezed.dart';
part 'account.g.dart';

@freezed
abstract class Account with _$Account {
  const Account._();

  const factory Account({
    @UuidValueConverter() UuidValue? uid,
    String? login,
    String? email,
    String? firstName,
    String? lastName,
    @Uint8ListConverter() Uint8List? image,
    @Default(true) bool isPrimary,
  }) = _Account;

  bool get isEmpty =>
      login == null && email == null && firstName == null && lastName == null;

  factory Account.fromJson(Map<String, dynamic> json) =>
      _$AccountFromJson(json);
}

class Uint8ListConverter implements JsonConverter<Uint8List?, String?> {
  const Uint8ListConverter();

  @override
  Uint8List? fromJson(String? json) {
    if (json == null) return null;
    return base64.decode(json);
  }

  @override
  String? toJson(Uint8List? object) {
    if (object == null) return null;
    return base64.encode(object);
  }
}
