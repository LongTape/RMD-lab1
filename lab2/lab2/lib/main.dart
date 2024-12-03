import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:lab2/data/repositories/user_repoisitory.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'screens/registration_screen.dart';
import 'screens/profile_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  final userRepository = SharedPreferencesUserRepository(prefs);

  final email = prefs.getString('email');
  final password = prefs.getString('password');
  final isConnected = await userRepository.hasInternetConnection();

  final isLoggedIn = email != null && password != null && isConnected
      ? await userRepository.validateUser(email, password)
      : false;


  runApp(MyApp(
    userRepository: userRepository,
    isLoggedIn: isLoggedIn,
    isConnected: isConnected,
  ));
}

class MyApp extends StatelessWidget {
  final UserRepository userRepository;
  final bool isLoggedIn;
  final bool isConnected;

  MyApp({
    required this.userRepository,
    required this.isLoggedIn,
    required this.isConnected,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: isLoggedIn ? '/home' : '/login',
      routes: {
        '/login': (context) => LoginScreen(
              userRepository: userRepository,
              isConnected: isConnected,
            ),
        '/home': (context) => HomeScreen(userRepository: userRepository),
        '/register': (context) => RegistrationScreen(userRepository: userRepository),
        '/profile': (context) => ProfileScreen(userRepository: userRepository),
      },
    );
  }
}