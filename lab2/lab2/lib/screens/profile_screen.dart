import 'package:flutter/material.dart';
import 'package:lab2/data/repositories/user_repoisitory.dart';

class ProfileScreen extends StatefulWidget {
  final UserRepository userRepository;

  ProfileScreen({required this.userRepository});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final email = await widget.userRepository.getUserDetail('email') ?? 'No Email';
    final name = await widget.userRepository.getUserDetail('name') ?? 'No Name';
    final password =
        await widget.userRepository.getUserDetail('password') ?? 'No Password';

    setState(() {
      _emailController.text = email;
      _nameController.text = name;
      _passwordController.text = password;
    });
  }

  Future<void> _saveChanges() async {
    await widget.userRepository.updateUserDetail('name', _nameController.text);
    await widget.userRepository.updateUserDetail(
        'password', _passwordController.text);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Changes saved successfully!')),
    );
  }

  void _logout() {
    Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _logout,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
              readOnly: true, // Робимо поле доступним лише для читання
            ),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _saveChanges,
              child: const Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}