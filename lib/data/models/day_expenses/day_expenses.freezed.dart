// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'day_expenses.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DayExpense {

 int get dayName; List<Expense> get dayExpenses; DateTime get date;
/// Create a copy of DayExpense
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DayExpenseCopyWith<DayExpense> get copyWith => _$DayExpenseCopyWithImpl<DayExpense>(this as DayExpense, _$identity);

  /// Serializes this DayExpense to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DayExpense&&(identical(other.dayName, dayName) || other.dayName == dayName)&&const DeepCollectionEquality().equals(other.dayExpenses, dayExpenses)&&(identical(other.date, date) || other.date == date));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,dayName,const DeepCollectionEquality().hash(dayExpenses),date);

@override
String toString() {
  return 'DayExpense(dayName: $dayName, dayExpenses: $dayExpenses, date: $date)';
}


}

/// @nodoc
abstract mixin class $DayExpenseCopyWith<$Res>  {
  factory $DayExpenseCopyWith(DayExpense value, $Res Function(DayExpense) _then) = _$DayExpenseCopyWithImpl;
@useResult
$Res call({
 int dayName, List<Expense> dayExpenses, DateTime date
});




}
/// @nodoc
class _$DayExpenseCopyWithImpl<$Res>
    implements $DayExpenseCopyWith<$Res> {
  _$DayExpenseCopyWithImpl(this._self, this._then);

  final DayExpense _self;
  final $Res Function(DayExpense) _then;

/// Create a copy of DayExpense
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? dayName = null,Object? dayExpenses = null,Object? date = null,}) {
  return _then(_self.copyWith(
dayName: null == dayName ? _self.dayName : dayName // ignore: cast_nullable_to_non_nullable
as int,dayExpenses: null == dayExpenses ? _self.dayExpenses : dayExpenses // ignore: cast_nullable_to_non_nullable
as List<Expense>,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [DayExpense].
extension DayExpensePatterns on DayExpense {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DayExpense value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DayExpense() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DayExpense value)  $default,){
final _that = this;
switch (_that) {
case _DayExpense():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DayExpense value)?  $default,){
final _that = this;
switch (_that) {
case _DayExpense() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int dayName,  List<Expense> dayExpenses,  DateTime date)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DayExpense() when $default != null:
return $default(_that.dayName,_that.dayExpenses,_that.date);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int dayName,  List<Expense> dayExpenses,  DateTime date)  $default,) {final _that = this;
switch (_that) {
case _DayExpense():
return $default(_that.dayName,_that.dayExpenses,_that.date);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int dayName,  List<Expense> dayExpenses,  DateTime date)?  $default,) {final _that = this;
switch (_that) {
case _DayExpense() when $default != null:
return $default(_that.dayName,_that.dayExpenses,_that.date);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DayExpense extends DayExpense {
  const _DayExpense({this.dayName = 0, final  List<Expense> dayExpenses = const [], required this.date}): _dayExpenses = dayExpenses,super._();
  factory _DayExpense.fromJson(Map<String, dynamic> json) => _$DayExpenseFromJson(json);

@override@JsonKey() final  int dayName;
 final  List<Expense> _dayExpenses;
@override@JsonKey() List<Expense> get dayExpenses {
  if (_dayExpenses is EqualUnmodifiableListView) return _dayExpenses;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_dayExpenses);
}

@override final  DateTime date;

/// Create a copy of DayExpense
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DayExpenseCopyWith<_DayExpense> get copyWith => __$DayExpenseCopyWithImpl<_DayExpense>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DayExpenseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DayExpense&&(identical(other.dayName, dayName) || other.dayName == dayName)&&const DeepCollectionEquality().equals(other._dayExpenses, _dayExpenses)&&(identical(other.date, date) || other.date == date));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,dayName,const DeepCollectionEquality().hash(_dayExpenses),date);

@override
String toString() {
  return 'DayExpense(dayName: $dayName, dayExpenses: $dayExpenses, date: $date)';
}


}

/// @nodoc
abstract mixin class _$DayExpenseCopyWith<$Res> implements $DayExpenseCopyWith<$Res> {
  factory _$DayExpenseCopyWith(_DayExpense value, $Res Function(_DayExpense) _then) = __$DayExpenseCopyWithImpl;
@override @useResult
$Res call({
 int dayName, List<Expense> dayExpenses, DateTime date
});




}
/// @nodoc
class __$DayExpenseCopyWithImpl<$Res>
    implements _$DayExpenseCopyWith<$Res> {
  __$DayExpenseCopyWithImpl(this._self, this._then);

  final _DayExpense _self;
  final $Res Function(_DayExpense) _then;

/// Create a copy of DayExpense
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? dayName = null,Object? dayExpenses = null,Object? date = null,}) {
  return _then(_DayExpense(
dayName: null == dayName ? _self.dayName : dayName // ignore: cast_nullable_to_non_nullable
as int,dayExpenses: null == dayExpenses ? _self._dayExpenses : dayExpenses // ignore: cast_nullable_to_non_nullable
as List<Expense>,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
