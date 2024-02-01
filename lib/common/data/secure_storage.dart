import 'package:flutter_secure_storage/flutter_secure_storage.dart';

enum SecureStorageKeys {
  authToken;
}

class SecureStorage {
  final _storage = const FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
  );

  Future<void> writeSecureData({
    required SecureStorageKeys key,
    required String data,
  }) async {
    await _storage.write(key: key.name, value: data);
  }

  Future<void> deleteSecureData({required SecureStorageKeys key}) async {
    await _storage.delete(key: key.name);
  }

  Future<String?> readSecureData({required SecureStorageKeys key}) async {
    return _storage.read(key: key.name);
  }
}