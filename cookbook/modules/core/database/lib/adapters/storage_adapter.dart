import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class StorageAdapter {
  static Future<void> initialize() async {}

  Future<void> setString(String key, String value);

  String? getString(String key);

  Future<bool> removeString(String key);

  Future<void> setEncryptedString(String key, String value);

  Future<String?> getEncryptedString(String key);

  Future<bool> removeEncryptedString(String key);
}

class StorageAdapterImpl implements StorageAdapter {
  final SharedPreferences? _sharedPreferences;
  final FlutterSecureStorage? _secureStorage;

  StorageAdapterImpl(this._sharedPreferences, this._secureStorage);

  @override
  String? getString(String key) {
    return _sharedPreferences?.getString(key);
  }

  @override
  Future<bool> setString(String key, String value) async {
    final result = await _sharedPreferences?.setString(key, value);

    return result ?? false;
  }

  @override
  Future<bool> removeString(String key) async {
    final result = await _sharedPreferences?.remove(key);

    return result ?? true;
  }

  @override
  Future<void> setEncryptedString(String key, String value) async {
    await _secureStorage!.write(key: key, value: value);
  }

  @override
  Future<String?> getEncryptedString(String key) async {
    final result = await _secureStorage!.read(key: key);

    return result;
  }

  @override
  Future<bool> removeEncryptedString(String key) async {
    await _secureStorage?.delete(key: key);

    final checkDelete = await getEncryptedString(key);

    return (checkDelete == null);
  }
}
