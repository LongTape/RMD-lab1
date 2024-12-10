import 'package:shared_preferences/shared_preferences.dart';

abstract class UserRepository {
  Future<bool> validateUser(String email, String password);
  Future<void> saveUser(String email, String password);
  Future<bool> hasInternetConnection();
}

class SharedPreferencesUserRepository implements UserRepository {
  final SharedPreferences prefs;

  SharedPreferencesUserRepository(this.prefs);

  @override
  Future<bool> validateUser(String email, String password) async {
    // Просте порівняння для демонстрації
    final storedEmail = prefs.getString('email');
    final storedPassword = prefs.getString('password');
    return email == storedEmail && password == storedPassword;
  }

  @override
  Future<void> saveUser(String email, String password) async {
    await prefs.setString('email', email);
    await prefs.setString('password', password);
  }

  @override
  Future<bool> hasInternetConnection() async {
    // Можна використати пакет connectivity_plus для реальної перевірки
    return true; // Для спрощення, завжди повертаємо true
  }
}
