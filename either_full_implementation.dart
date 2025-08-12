//definitions of the success and failure callbacks used for pattern matching

// ignore_for_file: unintended_html_in_doc_comment, document_ignores

import 'dart:async';

typedef SuccessCallback<S extends Object?, E extends Exception, ReturnType> =
    ReturnType Function(S value);
typedef FailureCallback<S extends Object?, E extends Exception, ReturnType> =
    ReturnType Function(E error);

/// This abstract class defines the success and failure states.
/// in a Either<Success, Failure> manner. Use in cases where
/// it is necessary to handle errors more explicitly. This is done
/// by implemeting the when method as a pattern matching method.
/// Where the success callback is called if the result is a success, and
/// the failure callback is called if the result is a failure.
sealed class Either<S extends Object?, E extends Exception>
    implements _ResultPatternMatching<S, E> {
  Either();
}

/// the private interface class that defines pattern matching for the results class.
abstract interface class _ResultPatternMatching<
  S extends Object?,
  E extends Exception
> {
  /// the pattern matching method that takes two callbacks
  /// one for success and one for failure. The success callback
  /// is called if the result is a success, and the failure
  /// callback is called if the result is a failure.
  /// The return type of the callbacks is a generic [ReturnType].
  ReturnType when<ReturnType>(
    SuccessCallback<S, E, ReturnType> onSuccess,
    FailureCallback<S, E, ReturnType> onFailure,
  );

  /// returns the success value if the result is a success, otherwise returns null.
  S? successOrNull();

  /// returns the failure value if the result is a failure, otherwise returns null.
  E? failureOrNull();

  /// returns true if the result is a success, otherwise returns false.
  bool get isSuccess;

  /// returns true if the result is a failure, otherwise returns false.
  bool get isFailure;

  /// maps the success and failure values to new types.
  Either<NewS, NewE> map<NewS extends Object?, NewE extends Exception>(
    NewS Function(S value) transformSuccess,
    NewE Function(E error) transformFailure,
  );

  /// maps the success value to a new type and returns the same failure value.
  Either<NewS, E> mapSuccess<NewS extends Object?>(
    NewS Function(S value) transform,
  );

  /// maps the failure value to a new type and returns the same success value.
  Either<S, NewE> mapFailure<NewE extends Exception>(
    NewE Function(E error) transform,
  );

  /// maps the success and failure values to new types asynchronously.
  Future<Either<NewS, NewE>>
  mapAsync<NewS extends Object?, NewE extends Exception>(
    FutureOr<NewS> Function(S value) transformSuccess,
    FutureOr<NewE> Function(E error) transformFailure,
  );

  /// maps the success value to a new type and returns the same failure value asynchronously.
  Future<Either<NewS, E>> mapSuccessAsync<NewS extends Object?>(
    FutureOr<NewS> Function(S value) transform,
  );

  /// maps the failure value to a new type and returns the same success value asynchronously.
  Future<Either<S, NewE>> mapFailureAsync<NewE extends Exception>(
    FutureOr<NewE> Function(E error) transform,
  );

  /// returns the success value if the result is a success, otherwise returns
  /// the value returned by the orElse function.
  S getSuccess(S Function() orElse);

  /// returns the failure value if the result is a failure, otherwise returns
  /// the value returned by the orElse function.
  E getFailure(E Function() orElse);

  /// returns the success value if the result is a success, otherwise throws
  S getSuccessOrThrow();

  /// returns the failure value if the result is a failure, otherwise throws
  E getFailureOrThrow();

  /// If success, compares the success value with the given value using the
  /// predicate function. Function returns true if the success value
  /// matches the predicate, otherwise false. If failure then
  /// gives false.
  bool successMatches(bool Function(S value) predicate);

  /// If failure, compares the failure value with the given value using the
  /// predicate function. Function returns true if the failure value
  /// matches the predicate, otherwise false. If success then
  /// gives false.
  bool failureMatches(bool Function(E error) predicate);

  /// does a side effect without changing the value of the success state.
  Either<S, E> doOnSuccess(void Function(S value) sideEffect);

  /// does a side effect without changing the value of the failure state.
  Either<S, E> doOnFailure(void Function(E error) sideEffect);
}

/// the success class of the [Either] class that contains the value
/// of the success state.
final class Success<S extends Object?, E extends Exception>
    extends Either<S, E> {
  Success(this.value);

  final S value;

  @override
  ReturnType when<ReturnType>(
    SuccessCallback<S, E, ReturnType> onSuccess,
    FailureCallback<S, E, ReturnType> onFailure,
  ) => onSuccess(value);

  @override
  Either<S, E> doOnFailure(void Function(E error) sideEffect) => this;

  @override
  Either<S, E> doOnSuccess(void Function(S value) sideEffect) {
    sideEffect(value);
    return this;
  }

  @override
  bool failureMatches(bool Function(E error) predicate) => false;

  @override
  E? failureOrNull() => null;

  @override
  E getFailure(E Function() orElse) => orElse();

  @override
  E getFailureOrThrow() => throw EitherException('No failure value');

  @override
  S getSuccess(S Function() orElse) => value;

  @override
  S getSuccessOrThrow() => value;

  @override
  Either<NewS, NewE> map<NewS extends Object?, NewE extends Exception>(
    NewS Function(S value) transformSuccess,
    NewE Function(E error) transformFailure,
  ) => Success<NewS, NewE>(transformSuccess(value));

  @override
  Future<Either<NewS, NewE>>
  mapAsync<NewS extends Object?, NewE extends Exception>(
    FutureOr<NewS> Function(S value) transformSuccess,
    FutureOr<NewE> Function(E error) transformFailure,
  ) async {
    final newValue = await transformSuccess(value);
    return Success<NewS, NewE>(newValue);
  }

  @override
  Either<S, NewE> mapFailure<NewE extends Exception>(
    NewE Function(E error) transform,
  ) => Success<S, NewE>(value);

  @override
  Future<Either<S, NewE>> mapFailureAsync<NewE extends Exception>(
    FutureOr<NewE> Function(E error) transform,
  ) async => Success<S, NewE>(value);

  @override
  Either<NewS, E> mapSuccess<NewS extends Object?>(
    NewS Function(S value) transform,
  ) => Success<NewS, E>(transform(value));

  @override
  Future<Either<NewS, E>> mapSuccessAsync<NewS extends Object?>(
    FutureOr<NewS> Function(S value) transform,
  ) async {
    final newValue = await transform(value);
    return Success<NewS, E>(newValue);
  }

  @override
  bool successMatches(bool Function(S value) predicate) => predicate(value);

  @override
  S? successOrNull() => value;

  @override
  bool get isSuccess => true;

  @override
  bool get isFailure => false;

  @override
  String toString() {
    return 'Success: $value';
  }
}

/// the failure branch of the [Either] class that contains the error
/// of the failure state. The value is of type [Exception].
final class Failure<S extends Object?, E extends Exception>
    extends Either<S, E> {
  Failure(this.error);

  final E error;

  @override
  ReturnType when<ReturnType>(
    SuccessCallback<S, E, ReturnType> onSuccess,
    FailureCallback<S, E, ReturnType> onFailure,
  ) => onFailure(error);

  @override
  bool get isSuccess => false;

  @override
  bool get isFailure => true;

  @override
  String toString() {
    return 'Failure: $error';
  }

  @override
  Either<S, E> doOnFailure(void Function(E error) sideEffect) {
    sideEffect(error);
    return this;
  }

  @override
  Either<S, E> doOnSuccess(void Function(S value) sideEffect) => this;

  @override
  bool failureMatches(bool Function(E error) predicate) => predicate(error);

  @override
  E? failureOrNull() => error;

  @override
  E getFailure(E Function() orElse) => error;

  @override
  E getFailureOrThrow() => error;

  @override
  S getSuccess(S Function() orElse) => orElse();

  @override
  S getSuccessOrThrow() => throw EitherException('No success value');

  @override
  Either<NewS, NewE> map<NewS extends Object?, NewE extends Exception>(
    NewS Function(S value) transformSuccess,
    NewE Function(E error) transformFailure,
  ) => Failure<NewS, NewE>(transformFailure(error));

  @override
  Future<Either<NewS, NewE>>
  mapAsync<NewS extends Object?, NewE extends Exception>(
    FutureOr<NewS> Function(S value) transformSuccess,
    FutureOr<NewE> Function(E error) transformFailure,
  ) async {
    final newError = await transformFailure(error);
    return Failure<NewS, NewE>(newError);
  }

  @override
  Either<S, NewE> mapFailure<NewE extends Exception>(
    NewE Function(E error) transform,
  ) => Failure<S, NewE>(transform(error));

  @override
  Future<Either<S, NewE>> mapFailureAsync<NewE extends Exception>(
    FutureOr<NewE> Function(E error) transform,
  ) async => Failure<S, NewE>(await transform(error));

  @override
  Either<NewS, E> mapSuccess<NewS extends Object?>(
    NewS Function(S value) transform,
  ) => Failure<NewS, E>(error);

  @override
  Future<Either<NewS, E>> mapSuccessAsync<NewS extends Object?>(
    FutureOr<NewS> Function(S value) transform,
  ) async => Failure<NewS, E>(error);

  @override
  bool successMatches(bool Function(S value) predicate) => false;

  @override
  S? successOrNull() => null;
}

class EitherException implements Exception {
  EitherException(this.message);

  final String message;

  @override
  String toString() {
    return 'EitherException: $message';
  }
}
