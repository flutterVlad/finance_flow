// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Account _$AccountFromJson(Map<String, dynamic> json) => Account(
  uid: const UuidValueConverter().fromJson(json['uid'] as String),
  login: json['login'] as String,
  email: json['email'] as String,
  firstName: json['firstName'] as String,
  lastName: json['lastName'] as String,
);

Map<String, dynamic> _$AccountToJson(Account instance) => <String, dynamic>{
  'uid': const UuidValueConverter().toJson(instance.uid),
  'login': instance.login,
  'firstName': instance.firstName,
  'lastName': instance.lastName,
  'email': instance.email,
};
