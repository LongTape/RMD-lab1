import 'package:shared_preferences/shared_preferences.dart';

abstract class UserRepository {
  Future<void> saveUser(String email, String password);
  Future<bool> validateUser(String email, String password);
  Future<String?> getUserDetail(String key);
  Future<void> updateUserDetail(String key, String value);
}

class SharedPreferencesUserRepository implements UserRepository {
  final SharedPreferences prefs;

  SharedPreferencesUserRepository(this.prefs);

  @override
  Future<void> saveUser(String email, String password) async {
    await prefs.setString('email', email);
    await prefs.setString('password', password);
  }

  @override
  Future<bool> validateUser(String email, String password) async {
    final storedEmail = prefs.getString('email');
    final storedPassword = prefs.getString('password');
    return email == storedEmail && password == storedPassword;
  }

  @override
  Future<String?> getUserDetail(String key) async {
    return prefs.getString(key);
  }

  @override
  Future<void> updateUserDetail(String key, String value) async {
    await prefs.setString(key, value);
  }
}