import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:yuanrung/core/integrations/app_crashlytics.dart';

final class NursingAssessmentService {
  static const String className = 'NursingAssessmentService';

  final Dio _dio;

  const NursingAssessmentService({required Dio dio}) : _dio = dio;

  final _baseUrl = 'http://140.116.245.147:9000';

  /// Returns [true] if success, [false] otherwise
  Future<bool> createNursingAssessment({
    required String userId,
    required Map<String, dynamic> nursingAssessmentData,
  }) async {
    final url = '$_baseUrl/api/upload_YRH_app';
    nursingAssessmentData['staffId'] = userId;

    log(
      'createNursingAssessment => nursingAssessmentData: $nursingAssessmentData',
      name: className,
    );

    try {
      final response = await _dio.post(
        url,
        options: Options(
          method: 'POST',
          headers: {'Content-Type': 'application/json'},
        ),
        data: nursingAssessmentData,
      );

      final data = response.data;
      log('createNursingAssessment => data: $data', name: className);
      if (data['success'] != null && data['success']) {
        return true;
      }
      return false;
    } on DioException catch (e, stack) {
      log('createNursingAssessment => error: $e', name: className);
      AppCrashlytics.recordError(e, stack);
      return false;
    }
  }

  /// Returns list of maps if success, empty otherwise
  Future<List<Map<String, dynamic>>> readNursingAssessments({
    required String userId,
  }) async {
    final url = '$_baseUrl/api/getCorrection_YRH_app';

    try {
      final response = await _dio.get(
        url,
        options: Options(
          method: 'GET',
          headers: {'Content-Type': 'application/json'},
        ),
        queryParameters: {'staffId': userId},
      );

      final data = response.data;
      log('readNursingAssessments => data: $data', name: className);
      if (data != null) {
        return data.cast<Map<String, dynamic>>();
      }
      return [];
    } on DioException catch (e, stack) {
      log('readNursingAssessments => error: $e', name: className);
      AppCrashlytics.recordError(e, stack);
      return [];
    }
  }

  /// Returns [true] if success, [false] otherwise
  Future<bool> updateNursingAssessment({
    required String userId,
    required Map<String, dynamic> nursingAssessmentData,
  }) async {
    final url = '$_baseUrl/api/edit_YRH_app';
    nursingAssessmentData['staffId'] = userId;

    try {
      final response = await _dio.patch(
        url,
        options: Options(
          method: 'PATCH',
          headers: {'Content-Type': 'application/json'},
        ),
        data: nursingAssessmentData,
      );

      final data = response.data;
      log('updateNursingAssessment => data: $data', name: className);
      if (data['success'] != null && data['success']) {
        return true;
      }
      return false;
    } on DioException catch (e, stack) {
      log('updateNursingAssessment => error: $e', name: className);
      AppCrashlytics.recordError(e, stack);
      return false;
    }
  }

  /// Returns [true] if success, [false] otherwise
  Future<bool> deleteNursingAssessment({
    required String userId,
    required String nursingAssessmentId,
  }) async {
    final url = '$_baseUrl/api/delete_YRH_app';

    try {
      final response = await _dio.delete(
        url,
        options: Options(
          method: 'DELETE',
          headers: {'Content-Type': 'application/json'},
        ),
        data: {'filename': nursingAssessmentId, 'staffId': userId},
      );

      final data = response.data;
      log('deleteNursingAssessment => data: $data', name: className);
      if (data['success'] != null && data['success']) {
        return true;
      }
      return false;
    } on DioException catch (e, stack) {
      log('deleteNursingAssessment => error: $e', name: className);
      AppCrashlytics.recordError(e, stack);
      return false;
    }
  }

  Future<String> formatNursingNote({required String note}) async {
    final url = '$_baseUrl/note';

    try {
      final response = await _dio.post(
        url,
        options: Options(
          method: 'POST',
          headers: {'Content-Type': 'application/json'},
        ),
        data: {'note': note},
      );

      final data = response.data;
      log('formatNursingNote => data: $data', name: className);
      if (data['status'] == 'success' && data['transformed_note'] != null) {
        return data['transformed_note'];
      }
      return "";
    } on DioException catch (e, stack) {
      log('createNursingAssessment => error: $e', name: className);
      AppCrashlytics.recordError(e, stack);
      return "";
    }
  }
}
