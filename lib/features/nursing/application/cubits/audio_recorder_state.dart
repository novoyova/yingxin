final class AudioRecorderState {
  final bool isRecording;
  final String? path;

  const AudioRecorderState({this.isRecording = false, this.path});

  factory AudioRecorderState.initial(AudioRecorderState state) {
    return state.copyWith(isRecording: false, path: null);
  }

  AudioRecorderState copyWith({bool? isRecording, String? path}) {
    return AudioRecorderState(
      isRecording: isRecording ?? this.isRecording,
      path: path,
    );
  }

  @override
  String toString() {
    return '''AudioRecorderState(
        isRecording: $isRecording, 
        path: $path
      )''';
  }
}
