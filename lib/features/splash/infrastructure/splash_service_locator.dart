import 'package:yuanrung/core/integrations/service_locator.dart';
import 'package:yuanrung/features/splash/application/cubits/splash_cubit.dart';

abstract final class SplashServiceLocator {
  static void init() {
    final serviceLocator = ServiceLocator.instance;

    // Cubits
    serviceLocator.registerFactory(
      () => SplashCubit(authRepository: serviceLocator()),
    );
  }
}
