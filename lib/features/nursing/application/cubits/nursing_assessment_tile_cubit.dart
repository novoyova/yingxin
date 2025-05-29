import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yuanrung/features/nursing/application/cubits/nursing_assessment_tile_state.dart';
import 'package:yuanrung/features/nursing/domain/nursing_assessment.dart';
import 'package:yuanrung/features/nursing/infrastructure/nursing_assessment_repository.dart';

class NursingAssessmentTileCubit extends Cubit<NursingAssessmentTileState> {
  static const String className = 'NursingAssessmentTileCubit';

  final NursingAssessmentRepository _nursingAssessmentRepository;

  NursingAssessmentTileCubit({
    required NursingAssessmentRepository nursingAssessmentRepository,
  }) : _nursingAssessmentRepository = nursingAssessmentRepository,
       super(NursingAssessmentTileState());

  Future<void> downloadAudio({
    required NursingAssessment nursingAssessment,
  }) async {
    emit(state.copyWith(isLoading: true));

    final result = await _nursingAssessmentRepository.downloadAudio(
      nursingAssessment: nursingAssessment,
    );

    if (result.isError) {
      return emit(
        state.copyWith(isLoading: false, failure: result.asError.failure),
      );
    }

    return emit(
      state.copyWith(audioPath: result.asSuccess.data, isLoading: false),
    );
  }
}
