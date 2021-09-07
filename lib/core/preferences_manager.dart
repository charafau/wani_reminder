import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const _keyToken = 'key-token';

class PreferencesManager {
  final FlutterSecureStorage flutterSecureStorage;

  PreferencesManager(this.flutterSecureStorage);

  Future<void> saveToken(String token) async {
    await flutterSecureStorage.write(key: _keyToken, value: token);
  }

  Future<String?> loadToken() async =>
      await flutterSecureStorage.read(key: _keyToken);

  Future<bool> hasToken() async {
    final token = await loadToken();

    return token != null && token.isNotEmpty;
  }
}
