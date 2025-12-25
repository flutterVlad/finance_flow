// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Category _$CategoryFromJson(Map<String, dynamic> json) => _Category(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  isIncome: json['isIncome'] as bool? ?? false,
  parentId: json['parentId'] as String?,
  budget: (json['budget'] as num?)?.toDouble(),
  color: json['color'] == null
      ? Colors.grey
      : ColorHelper.colorFromJson(json['color'] as Map),
  iconAsset: json['iconAsset'] == null
      ? Svgs.home
      : SvgDataHelper.svgDataFromJson(json['iconAsset'] as Map),
);

Map<String, dynamic> _$CategoryToJson(_Category instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'isIncome': instance.isIncome,
  'parentId': instance.parentId,
  'budget': instance.budget,
  'color': ColorHelper.colorToJson(instance.color),
  'iconAsset': SvgDataHelper.svgDataToJson(instance.iconAsset),
};
