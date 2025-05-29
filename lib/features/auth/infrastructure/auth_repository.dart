import 'package:yuanrung/core/integrations/app_crashlytics.dart';
import 'package:yuanrung/core/integrations/storage_service.dart';

final class AuthRepository {
  static const String className = 'AuthRepository';

  final StorageService _storageService;

  const AuthRepository({required StorageService storageService})
    : _storageService = storageService;

  Future<String?> getUserId() async {
    return await _storageService.read(StorageKey.userId);
  }

  Future<bool> isSignedIn() async {
    final userId = await _storageService.read(StorageKey.userId);
    AppCrashlytics.setUserId(userId ?? '');
    return userId != null;
  }

  Future<void> signIn(String userId) async {
    AppCrashlytics.setUserId(userId);
    return await _storageService.write(StorageKey.userId, userId);
  }

  Future<void> signOut() async {
    return await _storageService.remove(StorageKey.userId);
  }
}
