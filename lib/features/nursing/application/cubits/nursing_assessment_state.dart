import 'package:yingxin/features/nursing/domain/nursing_assessment.dart';
import 'package:yingxin/features/nursing/domain/nursing_assessment_failure.dart';

final class NursingAssessmentState {
  final List<NursingAssessment> nursingAssessments;
  final NursingAssessment? currentNursingAssessment;

  /// Determine wether create, update or delete is success
  final bool isSuccess;
  final NursingAssessmentFailure? failure;
  final bool isLoading;

  const NursingAssessmentState({
    this.nursingAssessments = const [],
    this.currentNursingAssessment,
    this.isSuccess = false,
    this.failure,
    this.isLoading = false,
  });

  factory NursingAssessmentState.loading(NursingAssessmentState state) {
    return state.copyWith(
      currentNursingAssessment: state.currentNursingAssessment,
      isSuccess: false,
      failure: null,
      isLoading: true,
    );
  }

  NursingAssessmentState copyWith({
    List<NursingAssessment>? nursingAssessments,
    NursingAssessment? currentNursingAssessment,
    bool? isSuccess,
    NursingAssessmentFailure? failure,
    bool? isLoading,
  }) {
    return NursingAssessmentState(
      nursingAssessments: nursingAssessments ?? this.nursingAssessments,
      currentNursingAssessment: currentNursingAssessment,
      isSuccess: isSuccess ?? this.isSuccess,
      failure: failure,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  String toString() {
    return '''NursingAssessmentState(
      nursingAssessments: $nursingAssessments,
      currentNursingAssessment: $currentNursingAssessment,
      isSuccess: $isSuccess,
      failure: $failure,
      isLoading: $isLoading,
    )''';
  }
}
