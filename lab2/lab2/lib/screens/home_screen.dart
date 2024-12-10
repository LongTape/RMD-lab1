import 'package:flutter/material.dart';
import 'package:lab2/data/repositories/user_repoisitory.dart';

class HomeScreen extends StatelessWidget {
  final UserRepository userRepository;

  HomeScreen({required this.userRepository});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await userRepository.updateUserDetail('email', '');
              await userRepository.updateUserDetail('password', '');
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/weather');
              },
              child: Text('Перейти до погоди'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/profile');
              },
              child: Text('Перейти до профілю'),
            ),
          ],
        ),
      ),
    );
  }
}

