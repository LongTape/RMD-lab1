import 'package:flutter/material.dart';
import 'package:lab2/widgets/custom_text_field.dart';
import 'package:lab2/widgets/custom_button.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextField(hintText: 'Email'),
            CustomTextField(hintText: 'Password', obscureText: true),
            CustomButton(
              text: 'Login',
              onPressed: () {
                Navigator.pushNamed(context, '/home');
              },
            ),
            CustomButton(
              text: 'Register',
              onPressed: () {
                Navigator.pushNamed(context, '/register');
              },
            )
          ],
        ),
      ),
    );
  }
}