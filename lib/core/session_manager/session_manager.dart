import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  static const _userIdKey = "user_id";
  static const _userNameKey = "user_name";
  static const _tokenKey = "token";
  static const _clientRecordIdKey = "client_record_id";

  static Future<void> saveSession({
    required String userId,
    required String token,
    required String clientRecordId,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userIdKey, userId);
    await prefs.setString(_tokenKey, token);
    await prefs.setString(_clientRecordIdKey, clientRecordId);
  }

  static Future<void> saveUserName({required String userName}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userNameKey, userName);
  }

  static Future<String?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userIdKey);
  }

  static Future<String?> getUserName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userNameKey);
  }

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  static Future<String?> getClientRecordId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_clientRecordIdKey);
  }

  static Future<bool> isLoggedIn() async {
    final userId = await getUserId();
    return userId != null && userId.isNotEmpty;
  }

  static Future<void> clearSession() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
