class UserValidator {
  static String? validateEmail(String email) {
    if (!email.contains('@')) return 'Invalid email format';
    return null;
  }

  static String? validatePassword(String password) {
    if (password.length < 6) return 'Password too short';
    return null;
  }

  static String? validateName(String name) {
    if (RegExp(r'[0-9]').hasMatch(name)) return 'Name cannot contain numbers';
    return null;
  }
}