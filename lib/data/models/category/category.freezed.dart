// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'category.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Category {

 int get id; String get name; bool get isIncome; String? get parentId; double? get budget;@JsonKey(fromJson: ColorHelper.colorFromJson, toJson: ColorHelper.colorToJson) Color get color;@JsonKey(fromJson: SvgDataHelper.svgDataFromJson, toJson: SvgDataHelper.svgDataToJson) SvgData get iconAsset;
/// Create a copy of Category
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CategoryCopyWith<Category> get copyWith => _$CategoryCopyWithImpl<Category>(this as Category, _$identity);

  /// Serializes this Category to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Category&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.isIncome, isIncome) || other.isIncome == isIncome)&&(identical(other.parentId, parentId) || other.parentId == parentId)&&(identical(other.budget, budget) || other.budget == budget)&&(identical(other.color, color) || other.color == color)&&(identical(other.iconAsset, iconAsset) || other.iconAsset == iconAsset));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,isIncome,parentId,budget,color,iconAsset);

@override
String toString() {
  return 'Category(id: $id, name: $name, isIncome: $isIncome, parentId: $parentId, budget: $budget, color: $color, iconAsset: $iconAsset)';
}


}

/// @nodoc
abstract mixin class $CategoryCopyWith<$Res>  {
  factory $CategoryCopyWith(Category value, $Res Function(Category) _then) = _$CategoryCopyWithImpl;
@useResult
$Res call({
 int id, String name, bool isIncome, String? parentId, double? budget,@JsonKey(fromJson: ColorHelper.colorFromJson, toJson: ColorHelper.colorToJson) Color color,@JsonKey(fromJson: SvgDataHelper.svgDataFromJson, toJson: SvgDataHelper.svgDataToJson) SvgData iconAsset
});


$SvgDataCopyWith<$Res> get iconAsset;

}
/// @nodoc
class _$CategoryCopyWithImpl<$Res>
    implements $CategoryCopyWith<$Res> {
  _$CategoryCopyWithImpl(this._self, this._then);

  final Category _self;
  final $Res Function(Category) _then;

/// Create a copy of Category
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? isIncome = null,Object? parentId = freezed,Object? budget = freezed,Object? color = null,Object? iconAsset = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,isIncome: null == isIncome ? _self.isIncome : isIncome // ignore: cast_nullable_to_non_nullable
as bool,parentId: freezed == parentId ? _self.parentId : parentId // ignore: cast_nullable_to_non_nullable
as String?,budget: freezed == budget ? _self.budget : budget // ignore: cast_nullable_to_non_nullable
as double?,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as Color,iconAsset: null == iconAsset ? _self.iconAsset : iconAsset // ignore: cast_nullable_to_non_nullable
as SvgData,
  ));
}
/// Create a copy of Category
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SvgDataCopyWith<$Res> get iconAsset {
  
  return $SvgDataCopyWith<$Res>(_self.iconAsset, (value) {
    return _then(_self.copyWith(iconAsset: value));
  });
}
}


/// Adds pattern-matching-related methods to [Category].
extension CategoryPatterns on Category {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Category value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Category() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Category value)  $default,){
final _that = this;
switch (_that) {
case _Category():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Category value)?  $default,){
final _that = this;
switch (_that) {
case _Category() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  bool isIncome,  String? parentId,  double? budget, @JsonKey(fromJson: ColorHelper.colorFromJson, toJson: ColorHelper.colorToJson)  Color color, @JsonKey(fromJson: SvgDataHelper.svgDataFromJson, toJson: SvgDataHelper.svgDataToJson)  SvgData iconAsset)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Category() when $default != null:
return $default(_that.id,_that.name,_that.isIncome,_that.parentId,_that.budget,_that.color,_that.iconAsset);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  bool isIncome,  String? parentId,  double? budget, @JsonKey(fromJson: ColorHelper.colorFromJson, toJson: ColorHelper.colorToJson)  Color color, @JsonKey(fromJson: SvgDataHelper.svgDataFromJson, toJson: SvgDataHelper.svgDataToJson)  SvgData iconAsset)  $default,) {final _that = this;
switch (_that) {
case _Category():
return $default(_that.id,_that.name,_that.isIncome,_that.parentId,_that.budget,_that.color,_that.iconAsset);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  bool isIncome,  String? parentId,  double? budget, @JsonKey(fromJson: ColorHelper.colorFromJson, toJson: ColorHelper.colorToJson)  Color color, @JsonKey(fromJson: SvgDataHelper.svgDataFromJson, toJson: SvgDataHelper.svgDataToJson)  SvgData iconAsset)?  $default,) {final _that = this;
switch (_that) {
case _Category() when $default != null:
return $default(_that.id,_that.name,_that.isIncome,_that.parentId,_that.budget,_that.color,_that.iconAsset);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Category extends Category {
  const _Category({required this.id, required this.name, this.isIncome = false, this.parentId, this.budget, @JsonKey(fromJson: ColorHelper.colorFromJson, toJson: ColorHelper.colorToJson) this.color = Colors.grey, @JsonKey(fromJson: SvgDataHelper.svgDataFromJson, toJson: SvgDataHelper.svgDataToJson) this.iconAsset = Svgs.home}): super._();
  factory _Category.fromJson(Map<String, dynamic> json) => _$CategoryFromJson(json);

@override final  int id;
@override final  String name;
@override@JsonKey() final  bool isIncome;
@override final  String? parentId;
@override final  double? budget;
@override@JsonKey(fromJson: ColorHelper.colorFromJson, toJson: ColorHelper.colorToJson) final  Color color;
@override@JsonKey(fromJson: SvgDataHelper.svgDataFromJson, toJson: SvgDataHelper.svgDataToJson) final  SvgData iconAsset;

/// Create a copy of Category
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CategoryCopyWith<_Category> get copyWith => __$CategoryCopyWithImpl<_Category>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CategoryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Category&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.isIncome, isIncome) || other.isIncome == isIncome)&&(identical(other.parentId, parentId) || other.parentId == parentId)&&(identical(other.budget, budget) || other.budget == budget)&&(identical(other.color, color) || other.color == color)&&(identical(other.iconAsset, iconAsset) || other.iconAsset == iconAsset));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,isIncome,parentId,budget,color,iconAsset);

@override
String toString() {
  return 'Category(id: $id, name: $name, isIncome: $isIncome, parentId: $parentId, budget: $budget, color: $color, iconAsset: $iconAsset)';
}


}

/// @nodoc
abstract mixin class _$CategoryCopyWith<$Res> implements $CategoryCopyWith<$Res> {
  factory _$CategoryCopyWith(_Category value, $Res Function(_Category) _then) = __$CategoryCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, bool isIncome, String? parentId, double? budget,@JsonKey(fromJson: ColorHelper.colorFromJson, toJson: ColorHelper.colorToJson) Color color,@JsonKey(fromJson: SvgDataHelper.svgDataFromJson, toJson: SvgDataHelper.svgDataToJson) SvgData iconAsset
});


@override $SvgDataCopyWith<$Res> get iconAsset;

}
/// @nodoc
class __$CategoryCopyWithImpl<$Res>
    implements _$CategoryCopyWith<$Res> {
  __$CategoryCopyWithImpl(this._self, this._then);

  final _Category _self;
  final $Res Function(_Category) _then;

/// Create a copy of Category
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? isIncome = null,Object? parentId = freezed,Object? budget = freezed,Object? color = null,Object? iconAsset = null,}) {
  return _then(_Category(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,isIncome: null == isIncome ? _self.isIncome : isIncome // ignore: cast_nullable_to_non_nullable
as bool,parentId: freezed == parentId ? _self.parentId : parentId // ignore: cast_nullable_to_non_nullable
as String?,budget: freezed == budget ? _self.budget : budget // ignore: cast_nullable_to_non_nullable
as double?,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as Color,iconAsset: null == iconAsset ? _self.iconAsset : iconAsset // ignore: cast_nullable_to_non_nullable
as SvgData,
  ));
}

/// Create a copy of Category
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SvgDataCopyWith<$Res> get iconAsset {
  
  return $SvgDataCopyWith<$Res>(_self.iconAsset, (value) {
    return _then(_self.copyWith(iconAsset: value));
  });
}
}

// dart format on
