import 'package:flutter/material.dart';
import 'package:lab2/screens/login_screen.dart';
import 'package:lab2/screens/registration_screen.dart';
import 'package:lab2/screens/home_screen.dart';
import 'package:lab2/screens/profile_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:lab2/data/repositories/user_repoisitory.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final userRepository = SharedPreferencesUserRepository(prefs);

  runApp(MyApp(userRepository: userRepository));
}

class MyApp extends StatelessWidget {
  final UserRepository userRepository;

  MyApp({required this.userRepository});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginScreen(userRepository: userRepository),
        '/register': (context) => RegistrationScreen(userRepository: userRepository),
        '/home': (context) => HomeScreen(userRepository: userRepository),
        '/profile': (context) => ProfileScreen(userRepository: userRepository),
      },
    );
  }
}