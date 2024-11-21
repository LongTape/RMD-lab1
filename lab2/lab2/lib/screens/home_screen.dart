import 'package:flutter/material.dart';
import 'package:lab2/widgets/custom_button.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: Center(
        child: CustomButton(
              text: 'profile',
              onPressed: () {
                Navigator.pushNamed(context, '/profile');
              },
        
        ),
      ),
    );
  }
}