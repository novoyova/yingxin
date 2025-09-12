import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:yingxin/core/constants/app_assets.dart';
import 'package:yingxin/core/integrations/app_crashlytics.dart';

final class SpeechToTextService {
  static const String className = 'SpeechToTextService';

  final Dio _dio;

  const SpeechToTextService({required Dio dio}) : _dio = dio;

  final _baseUrl = 'http://140.116.245.147:9000';

  /// Transcribes audio into text
  ///
  /// [audioData] is the base64 encoded audio data
  ///
  /// Returns the transcribed text or [null] when failed
  Future<Map<String, dynamic>?> transcribeAudio(String audioData) async {
    final url = '$_baseUrl/api/recognition_YRH_app';

    try {
      final response = await _dio.post(
        url,
        options: Options(
          method: 'POST',
          headers: {'Content-Type': 'application/json'},
        ),
        data: {
          "audio": audioData,
          "lang": "YRH",
          "source": "YRH",
          "return_timestamp": false,
        },
      );

      final data = response.data;
      log('transcribeAudio => data: $data', name: className);
      if (data['recognitionResult'] != null &&
          data['recognitionResult'] != 'error') {
        return data;
      }

      return null;
    } on DioException catch (e, stack) {
      log('transcribeAudio => error: $e', name: className);
      AppCrashlytics.recordError(e, stack);
      return null;
    }
  }

  /// Returns [path] if download success, [null] otherwise
  Future<String?> downloadAudio(String filename) async {
    final baseUrl = '$_baseUrl/api/downloadAudio_YRH_app';

    try {
      final response = await _dio.get(
        baseUrl,
        queryParameters: {'filename': filename},
        options: Options(responseType: ResponseType.stream),
      );

      // Ensure output directory exists
      final outputPath = await AppAssets.getRecordingPath();
      final file = File(outputPath);
      final sink = file.openWrite();

      await response.data.stream
          .listen(
            (chunk) => sink.add(chunk),
            onDone: () async {
              await sink.flush();
              await sink.close();
            },
            onError: (e) {
              throw e;
            },
            cancelOnError: true,
          )
          .asFuture();

      return outputPath;
    } on DioException catch (e, stack) {
      log('downloadAudio => error: $e', name: className);
      AppCrashlytics.recordError(e, stack);
      return null;
    }
  }
}
