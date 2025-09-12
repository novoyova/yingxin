import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yingxin/core/integrations/storage_service.dart';
import 'package:yingxin/features/auth/infrastructure/auth_service_locator.dart';
import 'package:yingxin/features/home/infrastructure/home_service_locator.dart';
import 'package:yingxin/features/nursing/infrastructure/nursing_service_locator.dart';
import 'package:yingxin/features/splash/infrastructure/splash_service_locator.dart';

abstract final class ServiceLocator {
  static const String className = 'ServiceLocator';

  static GetIt get instance => GetIt.instance;

  static void init() {
    // Services
    instance.registerLazySingleton(
      () => StorageService(storage: SharedPreferencesAsync()),
    );
    instance.registerLazySingleton(() => Dio());

    // Features
    SplashServiceLocator.init();
    AuthServiceLocator.init();
    HomeServiceLocator.init();
    NursingServiceLocator.init();
  }
}
