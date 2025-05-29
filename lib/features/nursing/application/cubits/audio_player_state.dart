final class AudioPlayerState {
  final bool isPlaying;

  const AudioPlayerState({this.isPlaying = false});

  AudioPlayerState copyWith({bool? isPlaying}) {
    return AudioPlayerState(isPlaying: isPlaying ?? this.isPlaying);
  }

  @override
  String toString() {
    return '''AudioPlayerState(
      isPlaying: $isPlaying
    )''';
  }
}
