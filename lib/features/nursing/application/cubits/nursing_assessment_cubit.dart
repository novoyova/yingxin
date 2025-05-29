import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yuanrung/core/utils/result.dart';
import 'package:yuanrung/features/nursing/application/cubits/nursing_assessment_state.dart';
import 'package:yuanrung/features/nursing/domain/nursing_assessment.dart';
import 'package:yuanrung/features/nursing/domain/nursing_assessment_failure.dart';
import 'package:yuanrung/features/nursing/infrastructure/nursing_assessment_repository.dart';

class NursingAssessmentCubit extends Cubit<NursingAssessmentState> {
  static const String className = "NursingAssessmentCubit";

  final NursingAssessmentRepository _nursingAssessmentRepository;

  NursingAssessmentCubit({
    required NursingAssessmentRepository nursingAssessmentRepository,
  }) : _nursingAssessmentRepository = nursingAssessmentRepository,
       super(NursingAssessmentState()) {
    getNursingAssessments();
  }

  void emitState(NursingAssessmentState state) {
    return emit(state);
  }

  Future<void> transcribeAudio(String audioPath) async {
    emit(NursingAssessmentState.loading(state));

    final result = await _nursingAssessmentRepository.transcribeAudio(
      audioPath: audioPath,
    );

    if (result.isSuccess) {
      return emit(
        state.copyWith(
          isLoading: false,
          currentNursingAssessment: result.asSuccess.data,
        ),
      );
    }

    emit(state.copyWith(isLoading: false, failure: result.asError.failure));
  }

  Future<void> getNursingAssessments() async {
    emit(NursingAssessmentState.loading(state));

    final result = await _nursingAssessmentRepository.readNursingAssessments();

    if (result.isError) {
      return emit(
        state.copyWith(isLoading: false, failure: result.asError.failure),
      );
    }

    return emit(
      state.copyWith(
        nursingAssessments: result.asSuccess.data,
        isLoading: false,
      ),
    );
  }

  Future<void> saveNursingAssessment({
    required NursingAssessment nursingAssessment,
    required bool isUpdate,
  }) async {
    emit(
      NursingAssessmentState.loading(
        state.copyWith(currentNursingAssessment: nursingAssessment),
      ),
    );

    Result<void, NursingAssessmentFailure> result;
    if (isUpdate) {
      result = await _nursingAssessmentRepository.updateNursingAssessment(
        nursingAssessment: nursingAssessment,
      );
    } else {
      result = await _nursingAssessmentRepository.createNursingAssessment(
        nursingAssessment: nursingAssessment,
      );
    }

    log(
      'saveNursingAssessment => result: $result, isUpdate: $isUpdate',
      name: className,
    );

    if (result.isError) {
      return emit(
        state.copyWith(
          currentNursingAssessment: state.currentNursingAssessment,
          isLoading: false,
          failure: result.asError.failure,
        ),
      );
    }

    // Get updated nursing assessment
    final nursingAssessmentsResult =
        await _nursingAssessmentRepository.readNursingAssessments();

    return emit(
      state.copyWith(
        nursingAssessments:
            nursingAssessmentsResult.isError
                ? state.nursingAssessments
                : nursingAssessmentsResult.asSuccess.data,
        currentNursingAssessment: state.currentNursingAssessment,
        isSuccess: true,
        isLoading: false,
      ),
    );
  }

  Future<void> deleteNursingAssessment({
    required NursingAssessment nursingAssessment,
  }) async {
    emit(NursingAssessmentState.loading(state));

    final result = await _nursingAssessmentRepository.deleteNursingAssessment(
      nursingAssessmentId: nursingAssessment.id,
    );

    log('deleteNursingAssessment => result: $result', name: className);

    if (result.isError) {
      return emit(
        state.copyWith(isLoading: false, failure: result.asError.failure),
      );
    }

    // Get updated nursing assessment
    final nursingAssessmentsResult =
        await _nursingAssessmentRepository.readNursingAssessments();

    return emit(
      state.copyWith(
        nursingAssessments:
            nursingAssessmentsResult.isError
                ? state.nursingAssessments
                : nursingAssessmentsResult.asSuccess.data,
        currentNursingAssessment: state.currentNursingAssessment,
        isSuccess: true,
        isLoading: false,
      ),
    );
  }

  @override
  Future<void> close() {
    log('close', name: className);
    return super.close();
  }
}
