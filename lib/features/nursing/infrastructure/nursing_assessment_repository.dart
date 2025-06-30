import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:yuanrung/core/integrations/storage_service.dart';
import 'package:yuanrung/core/utils/result.dart';
import 'package:yuanrung/features/nursing/domain/nursing_assessment.dart';
import 'package:yuanrung/features/nursing/domain/nursing_assessment_failure.dart';
import 'package:yuanrung/features/nursing/infrastructure/nursing_assessment_dto.dart';
import 'package:yuanrung/features/nursing/infrastructure/services/nursing_assessment_service.dart';
import 'package:yuanrung/features/nursing/infrastructure/services/speech_to_text_service.dart';

final class NursingAssessmentRepository {
  static const String className = 'NursingAssessmentRepository';

  final SpeechToTextService _speechToTextService;
  final NursingAssessmentService _nursingAssessmentService;
  final StorageService _storageService;

  const NursingAssessmentRepository({
    required SpeechToTextService speechToTextService,
    required NursingAssessmentService nursingAssessmentService,
    required StorageService storageService,
  }) : _speechToTextService = speechToTextService,
       _nursingAssessmentService = nursingAssessmentService,
       _storageService = storageService;

  Future<Result<NursingAssessment, NursingAssessmentFailure>> transcribeAudio({
    required String audioPath,
  }) async {
    // Set up audio file
    final audioFile = File(audioPath);
    log('transcribeAudio => audioFile: $audioFile', name: className);
    final audioBytes = await audioFile.readAsBytes();
    final base64Audio = base64Encode(audioBytes.buffer.asUint8List());

    final data = await _speechToTextService.transcribeAudio(base64Audio);
    if (data != null) {
      final nursingNote = await _nursingAssessmentService.formatNursingNote(
        note: data['recognitionResult'],
      );
      data['nursingNote'] = nursingNote;
      final nursingAssessment = NursingAssessmentDTO.mi2sToDomain(data);
      return Result.success(nursingAssessment);
    }

    return Result.error(
      NursingAssessmentFailure(
        type: NursingAssessmentFailureType.transcribeAudioFailed,
      ),
    );
  }

  Future<Result<String, NursingAssessmentFailure>> downloadAudio({
    required NursingAssessment nursingAssessment,
  }) async {
    log(
      'downloadAudio => nursingAssessment: $nursingAssessment',
      name: className,
    );

    if (nursingAssessment.audioFilename == null) {
      return Result.error(
        NursingAssessmentFailure(
          type: NursingAssessmentFailureType.downloadAudioFailed,
        ),
      );
    }

    final path = await _speechToTextService.downloadAudio(
      nursingAssessment.audioFilename!,
    );

    if (path == null) {
      return Result.error(
        NursingAssessmentFailure(
          type: NursingAssessmentFailureType.downloadAudioFailed,
        ),
      );
    }

    return Result.success(path);
  }

  Future<Result<void, NursingAssessmentFailure>> createNursingAssessment({
    required NursingAssessment nursingAssessment,
  }) async {
    final userId = await _storageService.read(StorageKey.userId);
    if (userId == null) {
      return Result.error(
        NursingAssessmentFailure(
          type: NursingAssessmentFailureType.userNotFound,
        ),
      );
    }

    final nursingAssessmentData = NursingAssessmentDTO.domainToMi2S(
      nursingAssessment,
    );

    final result = await _nursingAssessmentService.createNursingAssessment(
      userId: userId,
      nursingAssessmentData: nursingAssessmentData,
    );

    log('createNursingAssessment => result: $result', name: className);

    return result
        ? Result.success(null)
        : Result.error(
          NursingAssessmentFailure(
            type: NursingAssessmentFailureType.createFailed,
          ),
        );
  }

  Future<Result<List<NursingAssessment>, NursingAssessmentFailure>>
  readNursingAssessments() async {
    final userId = await _storageService.read(StorageKey.userId);
    if (userId == null) {
      return Result.error(
        NursingAssessmentFailure(
          type: NursingAssessmentFailureType.userNotFound,
        ),
      );
    }

    final nursingAssessmentList = await _nursingAssessmentService
        .readNursingAssessments(userId: userId);

    log(
      'readNursingAssessments => nursingAssessmentList: $nursingAssessmentList',
      name: className,
    );

    final nursingAssessments =
        nursingAssessmentList
            .map(
              (nursingAssessment) =>
                  NursingAssessmentDTO.mi2sToDomain(nursingAssessment),
            )
            .toList();
    nursingAssessments.sort((a, b) => b.date.compareTo(a.date));

    return Result.success(nursingAssessments);
  }

  Future<Result<void, NursingAssessmentFailure>> updateNursingAssessment({
    required NursingAssessment nursingAssessment,
  }) async {
    final userId = await _storageService.read(StorageKey.userId);
    if (userId == null) {
      return Result.error(
        NursingAssessmentFailure(
          type: NursingAssessmentFailureType.userNotFound,
        ),
      );
    }

    final nursingAssessmentData = NursingAssessmentDTO.domainToMi2S(
      nursingAssessment,
      isUpdate: true,
    );

    final result = await _nursingAssessmentService.updateNursingAssessment(
      userId: userId,
      nursingAssessmentData: nursingAssessmentData,
    );

    log('updateNursingAssessment => result: $result', name: className);

    return result
        ? Result.success(null)
        : Result.error(
          NursingAssessmentFailure(
            type: NursingAssessmentFailureType.updateFailed,
          ),
        );
  }

  Future<Result<void, NursingAssessmentFailure>> deleteNursingAssessment({
    required String nursingAssessmentId,
  }) async {
    final userId = await _storageService.read(StorageKey.userId);
    if (userId == null) {
      return Result.error(
        NursingAssessmentFailure(
          type: NursingAssessmentFailureType.userNotFound,
        ),
      );
    }

    final result = await _nursingAssessmentService.deleteNursingAssessment(
      userId: userId,
      nursingAssessmentId: nursingAssessmentId,
    );

    log('deleteNursingAssessment => result: $result', name: className);

    return result
        ? Result.success(null)
        : Result.error(
          NursingAssessmentFailure(
            type: NursingAssessmentFailureType.deleteFailed,
          ),
        );
  }
}
