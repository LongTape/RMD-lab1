import 'package:flutter/material.dart';
import 'package:lab2/data/repositories/user_repoisitory.dart';

class LoginScreen extends StatefulWidget {
  final UserRepository userRepository;

  LoginScreen({required this.userRepository});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String? _errorMessage;

 void _login() async {
  final isValid = await widget.userRepository.validateUser(
    _emailController.text,
    _passwordController.text,
  );
  if (mounted) {  // Перевірка, чи віджет ще знаходиться в дереві
    if (isValid) {
      Navigator.pushNamed(context, '/home');
    } else {
      setState(() {
        _errorMessage = 'Invalid email or password';
      });
    }
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 8),
            if (_errorMessage != null)
              Text(
                _errorMessage!,
                style: const TextStyle(color: Colors.red),
              ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _login,
              child: const Text('Login'),
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/register');
              },
              child: const Text('Don’t have an account? Register'),
            ),
          ],
        ),
      ),
    );
  }
}