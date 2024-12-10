import 'package:flutter/material.dart';

import 'package:lab2/data/repositories/user_repoisitory.dart';

class ProfileScreen extends StatefulWidget {
  final UserRepository userRepository;

  ProfileScreen({required this.userRepository});

  @override
  ProfileScreenState createState() => ProfileScreenState();
}

void _showDialog(BuildContext context, String title, String message) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('OK'),
        ),
      ],
    ),
  );
}

class ProfileScreenState extends State<ProfileScreen> {
  String? email;
  String? password;
  final _newPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  Future<void> _loadUserInfo() async {
    email = await widget.userRepository.getUserDetail('email');
    password = await widget.userRepository.getUserDetail('password');
    setState(() {});
  }

  Future<void> _updatePassword() async {
  final isConnected = await widget.userRepository.hasInternetConnection();
  if (!isConnected) {
    _showDialog(context,'No Internet', 'Please connect to the internet to update your password.');
    return;
  }

  await widget.userRepository.updateUserDetail('password', _newPasswordController.text);
  setState(() {
    password = _newPasswordController.text;
  });
}

  Future<void> _logout() async {
    final confirmed = await _showLogoutDialog();
    if (confirmed) {
      await widget.userRepository.updateUserDetail('email', '');
      await widget.userRepository.updateUserDetail('password', '');
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/login');
      }
    }
  }

  Future<bool> _showLogoutDialog() async {
    return (await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Log Out'),
            content: Text('Are you sure you want to log out?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: Text('Log Out'),
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (email != null) Text('Email: $email'),
            TextField(
              controller: _newPasswordController,
              decoration: InputDecoration(labelText: 'New Password'),
              obscureText: true,
            ),
            ElevatedButton(
              onPressed: _updatePassword,
              child: Text('Update Password'),
            ),
            ElevatedButton(
              onPressed: _logout,
              child: Text('Log Out'),
            ),
          ],
        ),
      ),
    );
  }
}