import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yingxin/app.dart';
import 'package:yingxin/core/configs/firebase_options.dart';
import 'package:yingxin/core/integrations/app_crashlytics.dart';
import 'package:yingxin/core/integrations/service_locator.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Lock orientation to portrait only
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Initialize service locator
  ServiceLocator.init();

  // Initialize date formatting
  initializeDateFormatting('zh_TW', null);

  // Initialize firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Initialize firebase crashlytics
  AppCrashlytics.init();

  runApp(
    kDebugMode ? DevicePreview(builder: (context) => const App()) : const App(),
  );
}
