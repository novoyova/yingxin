import 'package:yuanrung/core/integrations/service_locator.dart';
import 'package:yuanrung/features/auth/application/cubits/auth_cubit.dart';
import 'package:yuanrung/features/auth/infrastructure/auth_repository.dart';

abstract final class AuthServiceLocator {
  static void init() {
    final serviceLocator = ServiceLocator.instance;

    // Cubits
    serviceLocator.registerFactory(
      () => AuthCubit(authRepository: serviceLocator()),
    );

    // Repositories
    serviceLocator.registerLazySingleton(
      () => AuthRepository(storageService: serviceLocator()),
    );
  }
}
