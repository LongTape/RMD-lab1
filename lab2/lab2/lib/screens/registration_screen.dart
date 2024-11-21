import 'package:flutter/material.dart';
import 'package:lab2/data/repositories/user_repoisitory.dart';


class RegistrationScreen extends StatefulWidget {
  final UserRepository userRepository;

  RegistrationScreen({required this.userRepository});

  @override
  RegistrationScreenState createState() => RegistrationScreenState();
}

class RegistrationScreenState extends State<RegistrationScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Future<void> _register() async {
    final isConnected = await widget.userRepository.hasInternetConnection();
    if (!isConnected) {
      _showDialog('No Internet', 'Please connect to the internet to register.');
      return;
    }

    if (_formKey.currentState!.validate()) {
      await widget.userRepository.saveUser(
        _emailController.text,
        _passwordController.text,
      );
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/login');
      }
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
      appBar: AppBar(title: Text('Register')),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFormField(
                controller: _emailController,
                validator: (value) =>
                    value != null && value.contains('@') ? null : 'Invalid email',
                decoration: InputDecoration(labelText: 'Email'),
              ),
              TextFormField(
                controller: _passwordController,
                validator: (value) =>
                    value != null && value.length >= 6 ? null : 'Password too short',
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _register,
                child: Text('Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}