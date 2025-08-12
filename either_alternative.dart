void main() async {
  final result = await example1();

  final value = switch (result) {
    Success(value: final some) => some.toString(),
    Failure(exception: final exception) => 'Something went wrong: $exception',
  };
  print(value);
}

sealed class Either<S, E extends Exception> {
  const Either();
}

final class Success<S, E extends Exception> extends Either<S, E> {
  const Success(this.value);
  final S value;
}

final class Failure<S, E extends Exception> extends Either<S, E> {
  const Failure(this.exception);
  final E exception;
}

Future<Either<int, Exception>> example1() async {
  try {
    return Success(1);
  } on Exception catch (e) {
    return Failure(e);
  }
}
