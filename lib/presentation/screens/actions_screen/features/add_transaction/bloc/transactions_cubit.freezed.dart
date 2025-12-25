// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transactions_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TransactionsState {

 TransactionNameInput get nameInput; TransactionAmountInput get amountInput; TransactionCategoryInput get categoryInput; TransactionDateTimeInput get datetimeInput; bool get isIncome;
/// Create a copy of TransactionsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TransactionsStateCopyWith<TransactionsState> get copyWith => _$TransactionsStateCopyWithImpl<TransactionsState>(this as TransactionsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TransactionsState&&(identical(other.nameInput, nameInput) || other.nameInput == nameInput)&&(identical(other.amountInput, amountInput) || other.amountInput == amountInput)&&(identical(other.categoryInput, categoryInput) || other.categoryInput == categoryInput)&&(identical(other.datetimeInput, datetimeInput) || other.datetimeInput == datetimeInput)&&(identical(other.isIncome, isIncome) || other.isIncome == isIncome));
}


@override
int get hashCode => Object.hash(runtimeType,nameInput,amountInput,categoryInput,datetimeInput,isIncome);

@override
String toString() {
  return 'TransactionsState(nameInput: $nameInput, amountInput: $amountInput, categoryInput: $categoryInput, datetimeInput: $datetimeInput, isIncome: $isIncome)';
}


}

/// @nodoc
abstract mixin class $TransactionsStateCopyWith<$Res>  {
  factory $TransactionsStateCopyWith(TransactionsState value, $Res Function(TransactionsState) _then) = _$TransactionsStateCopyWithImpl;
@useResult
$Res call({
 TransactionNameInput nameInput, TransactionAmountInput amountInput, TransactionCategoryInput categoryInput, TransactionDateTimeInput datetimeInput, bool isIncome
});




}
/// @nodoc
class _$TransactionsStateCopyWithImpl<$Res>
    implements $TransactionsStateCopyWith<$Res> {
  _$TransactionsStateCopyWithImpl(this._self, this._then);

  final TransactionsState _self;
  final $Res Function(TransactionsState) _then;

/// Create a copy of TransactionsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? nameInput = null,Object? amountInput = null,Object? categoryInput = null,Object? datetimeInput = null,Object? isIncome = null,}) {
  return _then(_self.copyWith(
nameInput: null == nameInput ? _self.nameInput : nameInput // ignore: cast_nullable_to_non_nullable
as TransactionNameInput,amountInput: null == amountInput ? _self.amountInput : amountInput // ignore: cast_nullable_to_non_nullable
as TransactionAmountInput,categoryInput: null == categoryInput ? _self.categoryInput : categoryInput // ignore: cast_nullable_to_non_nullable
as TransactionCategoryInput,datetimeInput: null == datetimeInput ? _self.datetimeInput : datetimeInput // ignore: cast_nullable_to_non_nullable
as TransactionDateTimeInput,isIncome: null == isIncome ? _self.isIncome : isIncome // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [TransactionsState].
extension TransactionsStatePatterns on TransactionsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TransactionsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TransactionsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TransactionsState value)  $default,){
final _that = this;
switch (_that) {
case _TransactionsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TransactionsState value)?  $default,){
final _that = this;
switch (_that) {
case _TransactionsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( TransactionNameInput nameInput,  TransactionAmountInput amountInput,  TransactionCategoryInput categoryInput,  TransactionDateTimeInput datetimeInput,  bool isIncome)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TransactionsState() when $default != null:
return $default(_that.nameInput,_that.amountInput,_that.categoryInput,_that.datetimeInput,_that.isIncome);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( TransactionNameInput nameInput,  TransactionAmountInput amountInput,  TransactionCategoryInput categoryInput,  TransactionDateTimeInput datetimeInput,  bool isIncome)  $default,) {final _that = this;
switch (_that) {
case _TransactionsState():
return $default(_that.nameInput,_that.amountInput,_that.categoryInput,_that.datetimeInput,_that.isIncome);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( TransactionNameInput nameInput,  TransactionAmountInput amountInput,  TransactionCategoryInput categoryInput,  TransactionDateTimeInput datetimeInput,  bool isIncome)?  $default,) {final _that = this;
switch (_that) {
case _TransactionsState() when $default != null:
return $default(_that.nameInput,_that.amountInput,_that.categoryInput,_that.datetimeInput,_that.isIncome);case _:
  return null;

}
}

}

/// @nodoc


class _TransactionsState extends TransactionsState {
  const _TransactionsState({this.nameInput = const TransactionNameInput.pure(), this.amountInput = const TransactionAmountInput.pure(), this.categoryInput = const TransactionCategoryInput.pure(), required this.datetimeInput, this.isIncome = false}): super._();
  

@override@JsonKey() final  TransactionNameInput nameInput;
@override@JsonKey() final  TransactionAmountInput amountInput;
@override@JsonKey() final  TransactionCategoryInput categoryInput;
@override final  TransactionDateTimeInput datetimeInput;
@override@JsonKey() final  bool isIncome;

/// Create a copy of TransactionsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TransactionsStateCopyWith<_TransactionsState> get copyWith => __$TransactionsStateCopyWithImpl<_TransactionsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TransactionsState&&(identical(other.nameInput, nameInput) || other.nameInput == nameInput)&&(identical(other.amountInput, amountInput) || other.amountInput == amountInput)&&(identical(other.categoryInput, categoryInput) || other.categoryInput == categoryInput)&&(identical(other.datetimeInput, datetimeInput) || other.datetimeInput == datetimeInput)&&(identical(other.isIncome, isIncome) || other.isIncome == isIncome));
}


@override
int get hashCode => Object.hash(runtimeType,nameInput,amountInput,categoryInput,datetimeInput,isIncome);

@override
String toString() {
  return 'TransactionsState(nameInput: $nameInput, amountInput: $amountInput, categoryInput: $categoryInput, datetimeInput: $datetimeInput, isIncome: $isIncome)';
}


}

/// @nodoc
abstract mixin class _$TransactionsStateCopyWith<$Res> implements $TransactionsStateCopyWith<$Res> {
  factory _$TransactionsStateCopyWith(_TransactionsState value, $Res Function(_TransactionsState) _then) = __$TransactionsStateCopyWithImpl;
@override @useResult
$Res call({
 TransactionNameInput nameInput, TransactionAmountInput amountInput, TransactionCategoryInput categoryInput, TransactionDateTimeInput datetimeInput, bool isIncome
});




}
/// @nodoc
class __$TransactionsStateCopyWithImpl<$Res>
    implements _$TransactionsStateCopyWith<$Res> {
  __$TransactionsStateCopyWithImpl(this._self, this._then);

  final _TransactionsState _self;
  final $Res Function(_TransactionsState) _then;

/// Create a copy of TransactionsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? nameInput = null,Object? amountInput = null,Object? categoryInput = null,Object? datetimeInput = null,Object? isIncome = null,}) {
  return _then(_TransactionsState(
nameInput: null == nameInput ? _self.nameInput : nameInput // ignore: cast_nullable_to_non_nullable
as TransactionNameInput,amountInput: null == amountInput ? _self.amountInput : amountInput // ignore: cast_nullable_to_non_nullable
as TransactionAmountInput,categoryInput: null == categoryInput ? _self.categoryInput : categoryInput // ignore: cast_nullable_to_non_nullable
as TransactionCategoryInput,datetimeInput: null == datetimeInput ? _self.datetimeInput : datetimeInput // ignore: cast_nullable_to_non_nullable
as TransactionDateTimeInput,isIncome: null == isIncome ? _self.isIncome : isIncome // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
