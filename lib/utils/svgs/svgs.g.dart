// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'svgs.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SvgData _$SvgDataFromJson(Map<String, dynamic> json) => _SvgData(
  json['asset'] as String,
  color: json['color'] == null
      ? Colors.grey
      : ColorHelper.colorFromJson(json['color'] as Map),
  size: (json['size'] as num?)?.toDouble() ?? 20,
);

Map<String, dynamic> _$SvgDataToJson(_SvgData instance) => <String, dynamic>{
  'asset': instance.asset,
  'color': ColorHelper.colorToJson(instance.color),
  'size': instance.size,
};
