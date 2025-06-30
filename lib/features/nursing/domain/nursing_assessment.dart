final class NursingAssessment {
  final String id;
  final DateTime date;
  final String originalNote;
  final String correctedNote;
  final String formattedNote;
  final String? audioFilename;

  NursingAssessment({
    required this.id,
    required this.date,
    required this.originalNote,
    this.correctedNote = "",
    this.formattedNote = "",
    this.audioFilename,
  });

  NursingAssessment copyWith({
    String? id,
    DateTime? date,
    String? originalNote,
    String? correctedNote,
    String? formattedNote,
    String? audioFilename,
  }) {
    return NursingAssessment(
      id: id ?? this.id,
      date: date ?? this.date,
      originalNote: originalNote ?? this.originalNote,
      correctedNote: correctedNote ?? this.correctedNote,
      formattedNote: formattedNote ?? this.formattedNote,
      audioFilename: audioFilename ?? this.audioFilename,
    );
  }

  String get note =>
      correctedNote.isNotEmpty
          ? correctedNote
          : formattedNote.isNotEmpty
          ? formattedNote
          : originalNote;

  @override
  String toString() {
    return '''NursingAssessment(
      id: $id,
      date: $date,
      originalNote: $originalNote,
      correctedNote: $correctedNote,
      formattedNote: $formattedNote,
      audioFilename: $audioFilename,
    )''';
  }
}
