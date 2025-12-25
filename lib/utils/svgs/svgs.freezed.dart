// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'svgs.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SvgData {

 String get asset;@JsonKey(fromJson: ColorHelper.colorFromJson, toJson: ColorHelper.colorToJson) Color get color; double get size;
/// Create a copy of SvgData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SvgDataCopyWith<SvgData> get copyWith => _$SvgDataCopyWithImpl<SvgData>(this as SvgData, _$identity);

  /// Serializes this SvgData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SvgData&&(identical(other.asset, asset) || other.asset == asset)&&(identical(other.color, color) || other.color == color)&&(identical(other.size, size) || other.size == size));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,asset,color,size);

@override
String toString() {
  return 'SvgData(asset: $asset, color: $color, size: $size)';
}


}

/// @nodoc
abstract mixin class $SvgDataCopyWith<$Res>  {
  factory $SvgDataCopyWith(SvgData value, $Res Function(SvgData) _then) = _$SvgDataCopyWithImpl;
@useResult
$Res call({
 String asset,@JsonKey(fromJson: ColorHelper.colorFromJson, toJson: ColorHelper.colorToJson) Color color, double size
});




}
/// @nodoc
class _$SvgDataCopyWithImpl<$Res>
    implements $SvgDataCopyWith<$Res> {
  _$SvgDataCopyWithImpl(this._self, this._then);

  final SvgData _self;
  final $Res Function(SvgData) _then;

/// Create a copy of SvgData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? asset = null,Object? color = null,Object? size = null,}) {
  return _then(_self.copyWith(
asset: null == asset ? _self.asset : asset // ignore: cast_nullable_to_non_nullable
as String,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as Color,size: null == size ? _self.size : size // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [SvgData].
extension SvgDataPatterns on SvgData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SvgData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SvgData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SvgData value)  $default,){
final _that = this;
switch (_that) {
case _SvgData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SvgData value)?  $default,){
final _that = this;
switch (_that) {
case _SvgData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String asset, @JsonKey(fromJson: ColorHelper.colorFromJson, toJson: ColorHelper.colorToJson)  Color color,  double size)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SvgData() when $default != null:
return $default(_that.asset,_that.color,_that.size);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String asset, @JsonKey(fromJson: ColorHelper.colorFromJson, toJson: ColorHelper.colorToJson)  Color color,  double size)  $default,) {final _that = this;
switch (_that) {
case _SvgData():
return $default(_that.asset,_that.color,_that.size);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String asset, @JsonKey(fromJson: ColorHelper.colorFromJson, toJson: ColorHelper.colorToJson)  Color color,  double size)?  $default,) {final _that = this;
switch (_that) {
case _SvgData() when $default != null:
return $default(_that.asset,_that.color,_that.size);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SvgData extends SvgData {
  const _SvgData(this.asset, {@JsonKey(fromJson: ColorHelper.colorFromJson, toJson: ColorHelper.colorToJson) this.color = Colors.grey, this.size = 20}): super._();
  factory _SvgData.fromJson(Map<String, dynamic> json) => _$SvgDataFromJson(json);

@override final  String asset;
@override@JsonKey(fromJson: ColorHelper.colorFromJson, toJson: ColorHelper.colorToJson) final  Color color;
@override@JsonKey() final  double size;

/// Create a copy of SvgData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SvgDataCopyWith<_SvgData> get copyWith => __$SvgDataCopyWithImpl<_SvgData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SvgDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SvgData&&(identical(other.asset, asset) || other.asset == asset)&&(identical(other.color, color) || other.color == color)&&(identical(other.size, size) || other.size == size));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,asset,color,size);

@override
String toString() {
  return 'SvgData(asset: $asset, color: $color, size: $size)';
}


}

/// @nodoc
abstract mixin class _$SvgDataCopyWith<$Res> implements $SvgDataCopyWith<$Res> {
  factory _$SvgDataCopyWith(_SvgData value, $Res Function(_SvgData) _then) = __$SvgDataCopyWithImpl;
@override @useResult
$Res call({
 String asset,@JsonKey(fromJson: ColorHelper.colorFromJson, toJson: ColorHelper.colorToJson) Color color, double size
});




}
/// @nodoc
class __$SvgDataCopyWithImpl<$Res>
    implements _$SvgDataCopyWith<$Res> {
  __$SvgDataCopyWithImpl(this._self, this._then);

  final _SvgData _self;
  final $Res Function(_SvgData) _then;

/// Create a copy of SvgData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? asset = null,Object? color = null,Object? size = null,}) {
  return _then(_SvgData(
null == asset ? _self.asset : asset // ignore: cast_nullable_to_non_nullable
as String,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as Color,size: null == size ? _self.size : size // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
