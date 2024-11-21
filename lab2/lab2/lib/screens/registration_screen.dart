import 'package:flutter/material.dart';
import 'package:lab2/widgets/custom_text_field.dart';
import 'package:lab2/widgets/custom_button.dart';

class RegistrationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Registration')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextField(hintText: 'Name'),
            CustomTextField(hintText: 'Email'),
            CustomTextField(hintText: 'Password', obscureText: true),
            CustomButton(
              text: 'Register',
              onPressed: () {
                Navigator.pushNamed(context, '/home');
              },
            ),
            CustomButton(
              text: 'Back to login',
              onPressed: () {
                Navigator.pushNamed(context, '/login');
              },
            ),
          ],
        ),
      ),
    );
  }
}