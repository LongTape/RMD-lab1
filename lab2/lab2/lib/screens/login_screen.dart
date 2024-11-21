import 'package:flutter/material.dart';
import 'package:lab2/data/repositories/user_repoisitory.dart';


class LoginScreen extends StatefulWidget {
  final UserRepository userRepository;
  final bool isConnected;

  LoginScreen({
    required this.userRepository,
    required this.isConnected,
  });

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String? _errorMessage;

  Future<void> _login() async {
  final isConnected = await widget.userRepository.hasInternetConnection();
  if (!isConnected) {
    _showDialog('No Internet', 'Please connect to the internet to log in.');
    return;
  }

  final isValid = await widget.userRepository.validateUser(
    _emailController.text,
    _passwordController.text,
  );

  if (isValid) {
    if (mounted) {
      Navigator.pushReplacementNamed(context, '/home');
    }
  } else {
    setState(() {
      _errorMessage = 'Invalid email or password';
    });
  }
}

  void _showDialog(String title, String message) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            if (_errorMessage != null)
              Text(
                _errorMessage!,
                style: TextStyle(color: Colors.red),
              ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _login,
              child: Text('Login'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/register');
              },
              child: Text('Don’t have an account? Register here'),
            ),
          ],
        ),
      ),
    );
  }
}