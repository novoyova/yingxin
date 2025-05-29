import 'package:yuanrung/core/contracts/failure.dart';

/// Utility class that simplifies handling errors.
///
/// Return a [Result] from a function to indicate success or failure.
///
/// A [Result] is either a [Success] with a value of type [T]
/// or a [Failure] with a value of type [F].
///
/// Use [Result.success] to create a successful result with a value of type [T].
/// Use [Result.error] to create an error result with a value of type [F].
///
/// Evaluate the result using a switch statement:
/// ```dart
/// switch (result) {
///   case Success(): {
///     print(result.data);
///   }
///   case Error(): {
///     print(result.failure);
///   }
/// }
/// ```
sealed class Result<T, F extends Failure> {
  const Result();

  /// Creates a successful [Result], completed with the specified [data].
  const factory Result.success(T data) = Success._;

  /// Creates a failure [Result], completed with the specified [failure].
  const factory Result.error(F failure) = Error._;

  /// Checks if the result is a success.
  bool get isSuccess => this is Success<T, F>;

  /// Checks if the result is a failure.
  bool get isError => this is Error<T, F>;

  Success<T, F> get asSuccess => this as Success<T, F>;

  Error<T, F> get asError => this as Error<T, F>;

  R fold<R>({
    required R Function(Success<T, F> success) onSuccess,
    required R Function(Error<T, F> error) onError,
  }) {
    if (this is Success<T, F>) {
      return onSuccess(this as Success<T, F>);
    } else if (this is Error<T, F>) {
      return onError(this as Error<T, F>);
    }
    throw Exception('Unsupported result type');
  }
}

/// A successful [Result] with a returned [data].
final class Success<T, F extends Failure> extends Result<T, F> {
  const Success._(this.data);

  /// The returned data of this result.
  final T data;

  @override
  String toString() => 'Result<$T, $F>.success($data)';
}

/// An error [Result] with a resulting [failure].
final class Error<T, F extends Failure> extends Result<T, F> {
  const Error._(this.failure);

  /// The resulting error of this result.
  final F failure;

  @override
  String toString() => 'Result<$T, $F>.error($failure)';
}
