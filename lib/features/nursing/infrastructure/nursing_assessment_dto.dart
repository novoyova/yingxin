import 'package:yingxin/features/nursing/domain/nursing_assessment.dart';

abstract final class NursingAssessmentDTO {
  static NursingAssessment mi2sToDomain(Map<String, dynamic> data) {
    DateTime date;
    try {
      date =
          data['time'] != null ? DateTime.parse(data['time']) : DateTime.now();
    } catch (e) {
      date = DateTime.fromMillisecondsSinceEpoch(0, isUtc: true);
    }

    return NursingAssessment(
      id: data['filename'],
      date: date,
      originalNote: data['recognitionResult'],
      correctedNote:
          data['correctedRecognitionResult'] ?? data['recognitionResult'],
      formattedNote: data['nursingNote'] ?? '',
      audioFilename: data['filename'],
    );
  }

  static Map<String, dynamic> domainToMi2S(
    NursingAssessment nursingAssessment, {
    bool isUpdate = false,
  }) {
    if (isUpdate) {
      return {
        'filename': nursingAssessment.audioFilename,
        'data': {
          'recognitionResult': nursingAssessment.originalNote,
          'correctedRecognitionResult': nursingAssessment.correctedNote,
          'nursingNote': nursingAssessment.formattedNote,
          'time': nursingAssessment.date.toUtc().toIso8601String(),
        },
      };
    }

    return {
      'filename': nursingAssessment.audioFilename,
      'recognitionResult': nursingAssessment.originalNote,
      'correctedRecognitionResult': nursingAssessment.correctedNote,
      'nursingNote': nursingAssessment.formattedNote,
      'time': nursingAssessment.date.toUtc().toIso8601String(),
    };
  }
}
