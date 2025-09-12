import 'package:yingxin/core/integrations/service_locator.dart';
import 'package:yingxin/features/auth/application/cubits/auth_cubit.dart';
import 'package:yingxin/features/auth/infrastructure/auth_repository.dart';

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
