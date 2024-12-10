import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:lab2/data/repositories/user_repoisitory.dart';
import 'package:lab2/screens/login_screen.dart';
import 'package:lab2/screens/home_screen.dart';
import 'package:lab2/screens/profile_screen.dart';
import 'package:lab2/screens/registration_screen.dart';
import 'package:lab2/screens/weather_screen.dart';
import 'package:lab2/logic/auth_cubit.dart';

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

  runApp(
    BlocProvider(
      create: (context) => AuthCubit(),
      child: MyApp(
        userRepository: userRepository,
        isLoggedIn: isLoggedIn,
        isConnected: isConnected,
      ),
    ),
  );
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
  '/login': (context) => LoginScreen(userRepository: userRepository),
  '/home': (context) => HomeScreen(userRepository: userRepository),
  '/register': (context) => RegisterScreen(userRepository: userRepository),
  '/weather': (context) => WeatherScreen(),
  '/profile': (context) => ProfileScreen(userRepository: userRepository),
},
    );
  }
}
