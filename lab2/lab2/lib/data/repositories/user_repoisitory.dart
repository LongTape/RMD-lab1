import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

abstract class UserRepository {
  Future<void> saveUser(String email, String password);
  Future<bool> validateUser(String email, String password);
  Future<String?> getUserDetail(String key);
  Future<void> updateUserDetail(String key, dynamic value);
  Future<bool> hasInternetConnection();
}

class SharedPreferencesUserRepository implements UserRepository {
  final SharedPreferences _prefs;

  SharedPreferencesUserRepository(this._prefs);

  @override
  Future<void> saveUser(String email, String password) async {
    await _prefs.setString('email', email);
    await _prefs.setString('password', password);
  }

  @override
  Future<bool> validateUser(String email, String password) async {
    final storedEmail = _prefs.getString('email');
    final storedPassword = _prefs.getString('password');
    if (storedEmail == null || storedPassword == null) {
      return false;
    }
    return email == storedEmail && password == storedPassword;
  }

  @override
  Future<String?> getUserDetail(String key) async {
    return _prefs.getString(key);
  }

  @override
  Future<void> updateUserDetail(String key, dynamic value) async {
    if (value is String) {
      await _prefs.setString(key, value);
    } else if (value is int) {
      await _prefs.setInt(key, value);
    } else if (value is bool) {
      await _prefs.setBool(key, value);
    } else {
      throw Exception('Unsupported value type');
    }
  }

  @override
  Future<bool> hasInternetConnection() async {
    try {
      final connectivityResult = await Connectivity().checkConnectivity();
      return connectivityResult != ConnectivityResult.none;
    } catch (e) {
      return false;
    }
  }
}
