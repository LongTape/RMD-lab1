import 'package:flutter/material.dart';
import 'profile_screen.dart';
import 'package:lab2/data/repositories/user_repoisitory.dart';

class HomeScreen extends StatefulWidget {
  final UserRepository userRepository;

  HomeScreen({required this.userRepository});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    ProfileScreen(userRepository: widget.userRepository),
              ),
            );
          },
          child: Text('Go to Profile'),
        ),
      ),
    );
  }
}