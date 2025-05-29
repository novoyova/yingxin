import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';

abstract final class AppCrashlytics {
  static const String className = 'AppCrashlytics';

  static void init() {
    // Pass all uncaught "fatal" errors from Flutter framework to Crashlytics
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

    // Pass all uncaught asynchronous errors that aren't handled by Flutter framework to Crashlytics
    PlatformDispatcher.instance.onError = (exception, stackTrace) {
      FirebaseCrashlytics.instance.recordError(
        exception,
        stackTrace,
        fatal: true,
      );
      return true;
    };
  }

  static void setUserId(String userId) =>
      FirebaseCrashlytics.instance.setUserIdentifier(userId);

  static void recordError(dynamic exception, StackTrace stackTrace) =>
      FirebaseCrashlytics.instance.recordError(exception, stackTrace);
}
