import 'package:freezed_annotation/freezed_annotation.dart';

part 'either_freezed.freezed.dart';

@freezed
class Either<S extends Object?, E extends Exception> with _$Either<S, E> {
  const factory Either.success(S value) = Success<S, E>;
  const factory Either.failure(E error) = Failure<S, E>;
}
