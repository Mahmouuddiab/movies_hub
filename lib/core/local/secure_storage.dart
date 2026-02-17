import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static const _storage = FlutterSecureStorage();

  // Keys
  static const _emailKey = 'USER_EMAIL';
  static const _tokenKey = 'USER_TOKEN';

  // Save Email
  static Future<void> saveEmail(String email) async {
    await _storage.write(key: _emailKey, value: email);
  }

  // Get Email
  static Future<String?> getEmail() async {
    return await _storage.read(key: _emailKey);
  }

  // Save Token
  static Future<void> saveToken(String token) async {
    await _storage.write(key: _tokenKey, value: token);
  }

  // Get Token
  static Future<String?> getToken() async {
    return await _storage.read(key: _tokenKey);
  }

  // Logout (Clear All)
  static Future<void> clear() async {
    await _storage.deleteAll();
  }
}
