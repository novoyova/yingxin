import 'package:just_audio/just_audio.dart';
import 'package:record/record.dart';
import 'package:yuanrung/core/integrations/service_locator.dart';
import 'package:yuanrung/features/nursing/application/cubits/audio_player_cubit.dart';
import 'package:yuanrung/features/nursing/application/cubits/audio_recorder_cubit.dart';
import 'package:yuanrung/features/nursing/application/cubits/nursing_assessment_cubit.dart';
import 'package:yuanrung/features/nursing/application/cubits/nursing_assessment_tile_cubit.dart';
import 'package:yuanrung/features/nursing/infrastructure/nursing_assessment_repository.dart';
import 'package:yuanrung/features/nursing/infrastructure/services/nursing_assessment_service.dart';
import 'package:yuanrung/features/nursing/infrastructure/services/speech_to_text_service.dart';

abstract final class NursingServiceLocator {
  static void init() {
    final serviceLocator = ServiceLocator.instance;

    // Cubits
    serviceLocator.registerFactory(
      () => AudioRecorderCubit(audioRecorder: AudioRecorder()),
    );
    serviceLocator.registerFactory(
      () => AudioPlayerCubit(audioPlayer: AudioPlayer()),
    );
    serviceLocator.registerFactory(
      () =>
          NursingAssessmentCubit(nursingAssessmentRepository: serviceLocator()),
    );
    serviceLocator.registerFactory(
      () => NursingAssessmentTileCubit(
        nursingAssessmentRepository: serviceLocator(),
      ),
    );

    // Repositories
    serviceLocator.registerLazySingleton(
      () => NursingAssessmentRepository(
        speechToTextService: serviceLocator(),
        nursingAssessmentService: serviceLocator(),
        storageService: serviceLocator(),
      ),
    );

    // Services
    serviceLocator.registerLazySingleton(
      () => SpeechToTextService(dio: serviceLocator()),
    );
    serviceLocator.registerLazySingleton(
      () => NursingAssessmentService(dio: serviceLocator()),
    );
  }
}
