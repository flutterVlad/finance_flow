// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recurrence.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Recurrence _$RecurrenceFromJson(Map<String, dynamic> json) => _Recurrence(
  type: $enumDecode(_$RecurrenceTypeEnumMap, json['type']),
  interval: (json['interval'] as num?)?.toInt() ?? -1,
  endTime: DateTime.parse(json['endTime'] as String),
);

Map<String, dynamic> _$RecurrenceToJson(_Recurrence instance) =>
    <String, dynamic>{
      'type': _$RecurrenceTypeEnumMap[instance.type]!,
      'interval': instance.interval,
      'endTime': instance.endTime.toIso8601String(),
    };

const _$RecurrenceTypeEnumMap = {
  RecurrenceType.daily: 'daily',
  RecurrenceType.weekly: 'weekly',
  RecurrenceType.monthly: 'monthly',
  RecurrenceType.yearly: 'yearly',
};
