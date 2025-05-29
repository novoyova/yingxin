import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:record/record.dart';
import 'package:yuanrung/core/constants/app_assets.dart';
import 'package:yuanrung/features/nursing/application/cubits/audio_recorder_state.dart';

class AudioRecorderCubit extends Cubit<AudioRecorderState> {
  static const String className = 'AudioRecorderCubit';

  final AudioRecorder _audioRecorder;

  AudioRecorderCubit({required AudioRecorder audioRecorder})
    : _audioRecorder = audioRecorder,
      super(AudioRecorderState());

  void startRecording() async {
    if (await _audioRecorder.hasPermission()) {
      final path = await AppAssets.getRecordingPath();

      await _audioRecorder.start(
        RecordConfig(
          encoder: AudioEncoder.wav,
          sampleRate: 16000,
          numChannels: 1,
        ),
        path: path,
      );
      final isRecording = await _audioRecorder.isRecording();
      emit(state.copyWith(isRecording: isRecording));
    }
  }

  void stopRecording() async {
    if (await _audioRecorder.isRecording()) {
      final path = await _audioRecorder.stop();
      emit(state.copyWith(isRecording: false, path: path));
    }
  }

  @override
  Future<void> close() async {
    await _audioRecorder.stop();
    await _audioRecorder.dispose();
    return super.close();
  }
}
