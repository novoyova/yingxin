import 'package:yuanrung/features/nursing/domain/nursing_assessment_failure.dart';

final class NursingAssessmentTileState {
  static const String className = 'NursingAssessmentTileState';

  final String? audioPath;
  final NursingAssessmentFailure? failure;
  final bool isLoading;

  const NursingAssessmentTileState({
    this.audioPath,
    this.failure,
    this.isLoading = false,
  });

  NursingAssessmentTileState copyWith({
    String? audioPath,
    NursingAssessmentFailure? failure,
    bool? isLoading,
  }) {
    return NursingAssessmentTileState(
      audioPath: audioPath,
      failure: failure,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  String toString() {
    return '''NursingAssessmentTileState(
      audioPath: $audioPath,
      failure: $failure,
      isLoading: $isLoading,
    )''';
  }
}
