import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:yuanrung/features/nursing/application/cubits/audio_player_state.dart';

class AudioPlayerCubit extends Cubit<AudioPlayerState> {
  static const String className = 'AudioPlayerCubit';

  final AudioPlayer _audioPlayer;

  AudioPlayerCubit({required AudioPlayer audioPlayer})
    : _audioPlayer = audioPlayer,
      super(AudioPlayerState());

  Future<void> play(String audioPath) async {
    emit(state.copyWith(isPlaying: true));
    await _audioPlayer.setFilePath(audioPath);
    await _audioPlayer.play();
    await _audioPlayer.stop();
    emit(state.copyWith(isPlaying: false));
  }

  @override
  Future<void> close() {
    _audioPlayer.dispose();
    return super.close();
  }
}
