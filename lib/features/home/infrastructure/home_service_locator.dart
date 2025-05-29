import 'package:yuanrung/core/integrations/service_locator.dart';
import 'package:yuanrung/features/home/application/cubits/home_cubit.dart';

abstract final class HomeServiceLocator {
  static void init() {
    final serviceLocator = ServiceLocator.instance;

    // Cubits
    serviceLocator.registerFactory(
      () => HomeCubit(authRepository: serviceLocator()),
    );
  }
}
