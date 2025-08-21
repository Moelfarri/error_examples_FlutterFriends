// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'either_freezed.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Either<S extends Object?,E extends Exception> {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Either<S, E>);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'Either<$S, $E>()';
}


}

/// @nodoc
class $EitherCopyWith<S extends Object?,E extends Exception,$Res>  {
$EitherCopyWith(Either<S, E> _, $Res Function(Either<S, E>) __);
}


/// Adds pattern-matching-related methods to [Either].
extension EitherPatterns<S extends Object?,E extends Exception> on Either<S, E> {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( Success<S, E> value)?  success,TResult Function( Failure<S, E> value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case Success() when success != null:
return success(_that);case Failure() when failure != null:
return failure(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( Success<S, E> value)  success,required TResult Function( Failure<S, E> value)  failure,}){
final _that = this;
switch (_that) {
case Success():
return success(_that);case Failure():
return failure(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( Success<S, E> value)?  success,TResult? Function( Failure<S, E> value)?  failure,}){
final _that = this;
switch (_that) {
case Success() when success != null:
return success(_that);case Failure() when failure != null:
return failure(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( S value)?  success,TResult Function( E error)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case Success() when success != null:
return success(_that.value);case Failure() when failure != null:
return failure(_that.error);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( S value)  success,required TResult Function( E error)  failure,}) {final _that = this;
switch (_that) {
case Success():
return success(_that.value);case Failure():
return failure(_that.error);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( S value)?  success,TResult? Function( E error)?  failure,}) {final _that = this;
switch (_that) {
case Success() when success != null:
return success(_that.value);case Failure() when failure != null:
return failure(_that.error);case _:
  return null;

}
}

}

/// @nodoc


class Success<S extends Object?,E extends Exception> implements Either<S, E> {
  const Success(this.value);
  

 final  S value;

/// Create a copy of Either
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SuccessCopyWith<S, E, Success<S, E>> get copyWith => _$SuccessCopyWithImpl<S, E, Success<S, E>>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Success<S, E>&&const DeepCollectionEquality().equals(other.value, value));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(value));

@override
String toString() {
  return 'Either<$S, $E>.success(value: $value)';
}


}

/// @nodoc
abstract mixin class $SuccessCopyWith<S extends Object?,E extends Exception,$Res> implements $EitherCopyWith<S, E, $Res> {
  factory $SuccessCopyWith(Success<S, E> value, $Res Function(Success<S, E>) _then) = _$SuccessCopyWithImpl;
@useResult
$Res call({
 S value
});




}
/// @nodoc
class _$SuccessCopyWithImpl<S extends Object?,E extends Exception,$Res>
    implements $SuccessCopyWith<S, E, $Res> {
  _$SuccessCopyWithImpl(this._self, this._then);

  final Success<S, E> _self;
  final $Res Function(Success<S, E>) _then;

/// Create a copy of Either
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? value = freezed,}) {
  return _then(Success<S, E>(
freezed == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as S,
  ));
}


}

/// @nodoc


class Failure<S extends Object?,E extends Exception> implements Either<S, E> {
  const Failure(this.error);
  

 final  E error;

/// Create a copy of Either
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FailureCopyWith<S, E, Failure<S, E>> get copyWith => _$FailureCopyWithImpl<S, E, Failure<S, E>>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Failure<S, E>&&const DeepCollectionEquality().equals(other.error, error));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(error));

@override
String toString() {
  return 'Either<$S, $E>.failure(error: $error)';
}


}

/// @nodoc
abstract mixin class $FailureCopyWith<S extends Object?,E extends Exception,$Res> implements $EitherCopyWith<S, E, $Res> {
  factory $FailureCopyWith(Failure<S, E> value, $Res Function(Failure<S, E>) _then) = _$FailureCopyWithImpl;
@useResult
$Res call({
 E error
});




}
/// @nodoc
class _$FailureCopyWithImpl<S extends Object?,E extends Exception,$Res>
    implements $FailureCopyWith<S, E, $Res> {
  _$FailureCopyWithImpl(this._self, this._then);

  final Failure<S, E> _self;
  final $Res Function(Failure<S, E>) _then;

/// Create a copy of Either
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? error = null,}) {
  return _then(Failure<S, E>(
null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as E,
  ));
}


}

// dart format on
