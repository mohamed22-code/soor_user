import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageHelper {
  static const _tokenKey = 'auth_token';
  static const _tokenTypeKey = 'token_type';

  static const FlutterSecureStorage _storage = FlutterSecureStorage();

  static Future<void> saveToken(
    String token, {
    String tokenType = 'Bearer',
  }) async {
    await _storage.write(key: _tokenKey, value: token);
    await _storage.write(key: _tokenTypeKey, value: tokenType);
  }

  static Future<String?> getToken() async {
    return await _storage.read(key: _tokenKey);
  }

  static Future<String?> getTokenType() async {
    return await _storage.read(key: _tokenTypeKey);
  }

  static Future<void> deleteToken() async {
    await _storage.delete(key: _tokenKey);
    await _storage.delete(key: _tokenTypeKey);
  }

  static Future<bool> hasToken() async {
    final t = await getToken();
    return t != null && t.isNotEmpty;
  }
}
