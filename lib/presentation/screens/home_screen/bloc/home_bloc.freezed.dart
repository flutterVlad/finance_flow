// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$HomeEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HomeEvent()';
}


}

/// @nodoc
class $HomeEventCopyWith<$Res>  {
$HomeEventCopyWith(HomeEvent _, $Res Function(HomeEvent) __);
}


/// Adds pattern-matching-related methods to [HomeEvent].
extension HomeEventPatterns on HomeEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( InitHomeEvent value)?  init,TResult Function( UpdateHomeEvent value)?  updateData,TResult Function( FilterMonthEvent value)?  filterMonth,TResult Function( ClearMonthFilterEvent value)?  clearFilter,TResult Function( AddExpenseEvent value)?  addExpense,TResult Function( GetAllExpensesEvent value)?  getAllExpenses,required TResult orElse(),}){
final _that = this;
switch (_that) {
case InitHomeEvent() when init != null:
return init(_that);case UpdateHomeEvent() when updateData != null:
return updateData(_that);case FilterMonthEvent() when filterMonth != null:
return filterMonth(_that);case ClearMonthFilterEvent() when clearFilter != null:
return clearFilter(_that);case AddExpenseEvent() when addExpense != null:
return addExpense(_that);case GetAllExpensesEvent() when getAllExpenses != null:
return getAllExpenses(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( InitHomeEvent value)  init,required TResult Function( UpdateHomeEvent value)  updateData,required TResult Function( FilterMonthEvent value)  filterMonth,required TResult Function( ClearMonthFilterEvent value)  clearFilter,required TResult Function( AddExpenseEvent value)  addExpense,required TResult Function( GetAllExpensesEvent value)  getAllExpenses,}){
final _that = this;
switch (_that) {
case InitHomeEvent():
return init(_that);case UpdateHomeEvent():
return updateData(_that);case FilterMonthEvent():
return filterMonth(_that);case ClearMonthFilterEvent():
return clearFilter(_that);case AddExpenseEvent():
return addExpense(_that);case GetAllExpensesEvent():
return getAllExpenses(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( InitHomeEvent value)?  init,TResult? Function( UpdateHomeEvent value)?  updateData,TResult? Function( FilterMonthEvent value)?  filterMonth,TResult? Function( ClearMonthFilterEvent value)?  clearFilter,TResult? Function( AddExpenseEvent value)?  addExpense,TResult? Function( GetAllExpensesEvent value)?  getAllExpenses,}){
final _that = this;
switch (_that) {
case InitHomeEvent() when init != null:
return init(_that);case UpdateHomeEvent() when updateData != null:
return updateData(_that);case FilterMonthEvent() when filterMonth != null:
return filterMonth(_that);case ClearMonthFilterEvent() when clearFilter != null:
return clearFilter(_that);case AddExpenseEvent() when addExpense != null:
return addExpense(_that);case GetAllExpensesEvent() when getAllExpenses != null:
return getAllExpenses(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  init,TResult Function()?  updateData,TResult Function( DateTime date)?  filterMonth,TResult Function()?  clearFilter,TResult Function( Expense expense)?  addExpense,TResult Function()?  getAllExpenses,required TResult orElse(),}) {final _that = this;
switch (_that) {
case InitHomeEvent() when init != null:
return init();case UpdateHomeEvent() when updateData != null:
return updateData();case FilterMonthEvent() when filterMonth != null:
return filterMonth(_that.date);case ClearMonthFilterEvent() when clearFilter != null:
return clearFilter();case AddExpenseEvent() when addExpense != null:
return addExpense(_that.expense);case GetAllExpensesEvent() when getAllExpenses != null:
return getAllExpenses();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  init,required TResult Function()  updateData,required TResult Function( DateTime date)  filterMonth,required TResult Function()  clearFilter,required TResult Function( Expense expense)  addExpense,required TResult Function()  getAllExpenses,}) {final _that = this;
switch (_that) {
case InitHomeEvent():
return init();case UpdateHomeEvent():
return updateData();case FilterMonthEvent():
return filterMonth(_that.date);case ClearMonthFilterEvent():
return clearFilter();case AddExpenseEvent():
return addExpense(_that.expense);case GetAllExpensesEvent():
return getAllExpenses();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  init,TResult? Function()?  updateData,TResult? Function( DateTime date)?  filterMonth,TResult? Function()?  clearFilter,TResult? Function( Expense expense)?  addExpense,TResult? Function()?  getAllExpenses,}) {final _that = this;
switch (_that) {
case InitHomeEvent() when init != null:
return init();case UpdateHomeEvent() when updateData != null:
return updateData();case FilterMonthEvent() when filterMonth != null:
return filterMonth(_that.date);case ClearMonthFilterEvent() when clearFilter != null:
return clearFilter();case AddExpenseEvent() when addExpense != null:
return addExpense(_that.expense);case GetAllExpensesEvent() when getAllExpenses != null:
return getAllExpenses();case _:
  return null;

}
}

}

/// @nodoc


class InitHomeEvent implements HomeEvent {
  const InitHomeEvent();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InitHomeEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HomeEvent.init()';
}


}




/// @nodoc


class UpdateHomeEvent implements HomeEvent {
  const UpdateHomeEvent();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UpdateHomeEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HomeEvent.updateData()';
}


}




/// @nodoc


class FilterMonthEvent implements HomeEvent {
  const FilterMonthEvent(this.date);
  

 final  DateTime date;

/// Create a copy of HomeEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FilterMonthEventCopyWith<FilterMonthEvent> get copyWith => _$FilterMonthEventCopyWithImpl<FilterMonthEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FilterMonthEvent&&(identical(other.date, date) || other.date == date));
}


@override
int get hashCode => Object.hash(runtimeType,date);

@override
String toString() {
  return 'HomeEvent.filterMonth(date: $date)';
}


}

/// @nodoc
abstract mixin class $FilterMonthEventCopyWith<$Res> implements $HomeEventCopyWith<$Res> {
  factory $FilterMonthEventCopyWith(FilterMonthEvent value, $Res Function(FilterMonthEvent) _then) = _$FilterMonthEventCopyWithImpl;
@useResult
$Res call({
 DateTime date
});




}
/// @nodoc
class _$FilterMonthEventCopyWithImpl<$Res>
    implements $FilterMonthEventCopyWith<$Res> {
  _$FilterMonthEventCopyWithImpl(this._self, this._then);

  final FilterMonthEvent _self;
  final $Res Function(FilterMonthEvent) _then;

/// Create a copy of HomeEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? date = null,}) {
  return _then(FilterMonthEvent(
null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

/// @nodoc


class ClearMonthFilterEvent implements HomeEvent {
  const ClearMonthFilterEvent();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ClearMonthFilterEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HomeEvent.clearFilter()';
}


}




/// @nodoc


class AddExpenseEvent implements HomeEvent {
  const AddExpenseEvent(this.expense);
  

 final  Expense expense;

/// Create a copy of HomeEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AddExpenseEventCopyWith<AddExpenseEvent> get copyWith => _$AddExpenseEventCopyWithImpl<AddExpenseEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AddExpenseEvent&&(identical(other.expense, expense) || other.expense == expense));
}


@override
int get hashCode => Object.hash(runtimeType,expense);

@override
String toString() {
  return 'HomeEvent.addExpense(expense: $expense)';
}


}

/// @nodoc
abstract mixin class $AddExpenseEventCopyWith<$Res> implements $HomeEventCopyWith<$Res> {
  factory $AddExpenseEventCopyWith(AddExpenseEvent value, $Res Function(AddExpenseEvent) _then) = _$AddExpenseEventCopyWithImpl;
@useResult
$Res call({
 Expense expense
});


$ExpenseCopyWith<$Res> get expense;

}
/// @nodoc
class _$AddExpenseEventCopyWithImpl<$Res>
    implements $AddExpenseEventCopyWith<$Res> {
  _$AddExpenseEventCopyWithImpl(this._self, this._then);

  final AddExpenseEvent _self;
  final $Res Function(AddExpenseEvent) _then;

/// Create a copy of HomeEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? expense = null,}) {
  return _then(AddExpenseEvent(
null == expense ? _self.expense : expense // ignore: cast_nullable_to_non_nullable
as Expense,
  ));
}

/// Create a copy of HomeEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ExpenseCopyWith<$Res> get expense {
  
  return $ExpenseCopyWith<$Res>(_self.expense, (value) {
    return _then(_self.copyWith(expense: value));
  });
}
}

/// @nodoc


class GetAllExpensesEvent implements HomeEvent {
  const GetAllExpensesEvent();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GetAllExpensesEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HomeEvent.getAllExpenses()';
}


}




/// @nodoc
mixin _$HomeState {

 List<DayExpense> get dayExpenses; List<Expense> get allExpenses; List<Expense> get incomes; DateTime get monthFilter;
/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HomeStateCopyWith<HomeState> get copyWith => _$HomeStateCopyWithImpl<HomeState>(this as HomeState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeState&&const DeepCollectionEquality().equals(other.dayExpenses, dayExpenses)&&const DeepCollectionEquality().equals(other.allExpenses, allExpenses)&&const DeepCollectionEquality().equals(other.incomes, incomes)&&(identical(other.monthFilter, monthFilter) || other.monthFilter == monthFilter));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(dayExpenses),const DeepCollectionEquality().hash(allExpenses),const DeepCollectionEquality().hash(incomes),monthFilter);

@override
String toString() {
  return 'HomeState(dayExpenses: $dayExpenses, allExpenses: $allExpenses, incomes: $incomes, monthFilter: $monthFilter)';
}


}

/// @nodoc
abstract mixin class $HomeStateCopyWith<$Res>  {
  factory $HomeStateCopyWith(HomeState value, $Res Function(HomeState) _then) = _$HomeStateCopyWithImpl;
@useResult
$Res call({
 List<DayExpense> dayExpenses, List<Expense> allExpenses, List<Expense> incomes, DateTime monthFilter
});




}
/// @nodoc
class _$HomeStateCopyWithImpl<$Res>
    implements $HomeStateCopyWith<$Res> {
  _$HomeStateCopyWithImpl(this._self, this._then);

  final HomeState _self;
  final $Res Function(HomeState) _then;

/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? dayExpenses = null,Object? allExpenses = null,Object? incomes = null,Object? monthFilter = null,}) {
  return _then(_self.copyWith(
dayExpenses: null == dayExpenses ? _self.dayExpenses : dayExpenses // ignore: cast_nullable_to_non_nullable
as List<DayExpense>,allExpenses: null == allExpenses ? _self.allExpenses : allExpenses // ignore: cast_nullable_to_non_nullable
as List<Expense>,incomes: null == incomes ? _self.incomes : incomes // ignore: cast_nullable_to_non_nullable
as List<Expense>,monthFilter: null == monthFilter ? _self.monthFilter : monthFilter // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [HomeState].
extension HomeStatePatterns on HomeState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HomeState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HomeState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HomeState value)  $default,){
final _that = this;
switch (_that) {
case _HomeState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HomeState value)?  $default,){
final _that = this;
switch (_that) {
case _HomeState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<DayExpense> dayExpenses,  List<Expense> allExpenses,  List<Expense> incomes,  DateTime monthFilter)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HomeState() when $default != null:
return $default(_that.dayExpenses,_that.allExpenses,_that.incomes,_that.monthFilter);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<DayExpense> dayExpenses,  List<Expense> allExpenses,  List<Expense> incomes,  DateTime monthFilter)  $default,) {final _that = this;
switch (_that) {
case _HomeState():
return $default(_that.dayExpenses,_that.allExpenses,_that.incomes,_that.monthFilter);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<DayExpense> dayExpenses,  List<Expense> allExpenses,  List<Expense> incomes,  DateTime monthFilter)?  $default,) {final _that = this;
switch (_that) {
case _HomeState() when $default != null:
return $default(_that.dayExpenses,_that.allExpenses,_that.incomes,_that.monthFilter);case _:
  return null;

}
}

}

/// @nodoc


class _HomeState extends HomeState {
  const _HomeState({final  List<DayExpense> dayExpenses = const [], final  List<Expense> allExpenses = const [], final  List<Expense> incomes = const [], required this.monthFilter}): _dayExpenses = dayExpenses,_allExpenses = allExpenses,_incomes = incomes,super._();
  

 final  List<DayExpense> _dayExpenses;
@override@JsonKey() List<DayExpense> get dayExpenses {
  if (_dayExpenses is EqualUnmodifiableListView) return _dayExpenses;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_dayExpenses);
}

 final  List<Expense> _allExpenses;
@override@JsonKey() List<Expense> get allExpenses {
  if (_allExpenses is EqualUnmodifiableListView) return _allExpenses;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_allExpenses);
}

 final  List<Expense> _incomes;
@override@JsonKey() List<Expense> get incomes {
  if (_incomes is EqualUnmodifiableListView) return _incomes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_incomes);
}

@override final  DateTime monthFilter;

/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HomeStateCopyWith<_HomeState> get copyWith => __$HomeStateCopyWithImpl<_HomeState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HomeState&&const DeepCollectionEquality().equals(other._dayExpenses, _dayExpenses)&&const DeepCollectionEquality().equals(other._allExpenses, _allExpenses)&&const DeepCollectionEquality().equals(other._incomes, _incomes)&&(identical(other.monthFilter, monthFilter) || other.monthFilter == monthFilter));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_dayExpenses),const DeepCollectionEquality().hash(_allExpenses),const DeepCollectionEquality().hash(_incomes),monthFilter);

@override
String toString() {
  return 'HomeState(dayExpenses: $dayExpenses, allExpenses: $allExpenses, incomes: $incomes, monthFilter: $monthFilter)';
}


}

/// @nodoc
abstract mixin class _$HomeStateCopyWith<$Res> implements $HomeStateCopyWith<$Res> {
  factory _$HomeStateCopyWith(_HomeState value, $Res Function(_HomeState) _then) = __$HomeStateCopyWithImpl;
@override @useResult
$Res call({
 List<DayExpense> dayExpenses, List<Expense> allExpenses, List<Expense> incomes, DateTime monthFilter
});




}
/// @nodoc
class __$HomeStateCopyWithImpl<$Res>
    implements _$HomeStateCopyWith<$Res> {
  __$HomeStateCopyWithImpl(this._self, this._then);

  final _HomeState _self;
  final $Res Function(_HomeState) _then;

/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? dayExpenses = null,Object? allExpenses = null,Object? incomes = null,Object? monthFilter = null,}) {
  return _then(_HomeState(
dayExpenses: null == dayExpenses ? _self._dayExpenses : dayExpenses // ignore: cast_nullable_to_non_nullable
as List<DayExpense>,allExpenses: null == allExpenses ? _self._allExpenses : allExpenses // ignore: cast_nullable_to_non_nullable
as List<Expense>,incomes: null == incomes ? _self._incomes : incomes // ignore: cast_nullable_to_non_nullable
as List<Expense>,monthFilter: null == monthFilter ? _self.monthFilter : monthFilter // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
