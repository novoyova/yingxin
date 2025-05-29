import 'package:yuanrung/core/contracts/failure.dart';

enum HomeFailureType { userNotFound }

final class HomeFailure extends Failure {
  final HomeFailureType type;

  HomeFailure({required this.type});

  @override
  String toString() {
    return '''HomeFailure(
      type: $type
    )''';
  }
}
