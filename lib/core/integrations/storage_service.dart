import 'package:shared_preferences/shared_preferences.dart';

enum StorageKey { userId }

final class StorageService {
  final SharedPreferencesAsync _storage;
  final Map<String, dynamic> _cachedData = {};

  StorageService({required SharedPreferencesAsync storage})
    : _storage = storage;

  Future<String?> read(StorageKey key) async {
    if (_cachedData.containsKey(key.name)) {
      return _cachedData[key.name] as String;
    }
    return await _storage.getString(key.name);
  }

  Future<void> write(StorageKey key, String value) async {
    _cachedData[key.name] = value;
    await _storage.setString(key.name, value);
  }

  Future<void> remove(StorageKey key) async {
    _cachedData.remove(key.name);
    await _storage.remove(key.name);
  }

  Future<void> clear() async {
    _cachedData.clear();
    await _storage.clear();
  }
}
