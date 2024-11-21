import 'package:flutter/material.dart';
import 'package:lab2/widgets/custom_button.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('User Profile', style: TextStyle(fontSize: 24)),
            SizedBox(height: 20),
            CustomButton(
              text: 'Logout',
              onPressed: () {
                Navigator.popUntil(context, ModalRoute.withName('/login'));
              },
            ),
          ],
        ),
      ),
    );
  }
}