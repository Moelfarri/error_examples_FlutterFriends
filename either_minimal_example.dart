typedef SuccessCallback<S extends Object?, E extends Exception, ReturnType> =
    ReturnType Function(S value);
typedef FailureCallback<S extends Object?, E extends Exception, ReturnType> =
    ReturnType Function(E error);

sealed class Either<S extends Object?, E extends Exception> {
  Either();

  ReturnType when<ReturnType>(
    SuccessCallback<S, E, ReturnType> onSuccess,
    FailureCallback<S, E, ReturnType> onFailure,
  );
}

final class Success<S extends Object?, E extends Exception>
    extends Either<S, E> {
  Success(this.value);

  final S value;

  @override
  ReturnType when<ReturnType>(
    SuccessCallback<S, E, ReturnType> onSuccess,
    FailureCallback<S, E, ReturnType> onFailure,
  ) => onSuccess(value);
}

final class Failure<S extends Object?, E extends Exception>
    extends Either<S, E> {
  Failure(this.error);

  final E error;

  @override
  ReturnType when<ReturnType>(
    SuccessCallback<S, E, ReturnType> onSuccess,
    FailureCallback<S, E, ReturnType> onFailure,
  ) => onFailure(error);
}
