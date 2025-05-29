import 'package:yuanrung/core/contracts/failure.dart';

enum NursingAssessmentFailureType {
  transcribeAudioFailed,
  downloadAudioFailed,
  userNotFound,
  createFailed,
  updateFailed,
  deleteFailed,
}

final class NursingAssessmentFailure extends Failure {
  final NursingAssessmentFailureType type;

  NursingAssessmentFailure({required this.type});

  @override
  String toString() {
    return '''NursingAssessmentFailure(
      type: $type
    )''';
  }
}
