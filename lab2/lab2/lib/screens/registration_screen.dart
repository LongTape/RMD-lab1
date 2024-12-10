import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lab2/logic/auth_cubit.dart';
import 'package:lab2/widgets/custom_button.dart';
import 'package:lab2/data/repositories/user_repoisitory.dart';

class RegisterScreen extends StatelessWidget {
  final UserRepository userRepository;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  RegisterScreen({required this.userRepository});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Register')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            if (state.isLoggedIn) {
              Future.microtask(() {
                Navigator.pushReplacementNamed(context, '/home');
              });
            }

            return Column(
              children: [
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(labelText: 'Email'),
                ),
                TextField(
                  controller: passwordController,
                  decoration: InputDecoration(labelText: 'Password'),
                  obscureText: true,
                ),
                if (state.errorMessage != null)
                  Text(
                    state.errorMessage!,
                    style: TextStyle(color: Colors.red),
                  ),
                CustomButton(
                    text: state.isLoading ? 'Registering...' : 'Register',
                    onPressed: state.isLoading
                        ? null
                        : () {
                            if (emailController.text.isNotEmpty &&
                                passwordController.text.length >= 6) {
                              final email = emailController.text.trim();
                              final password = passwordController.text.trim();
                              context.read<AuthCubit>().register(email, password);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Invalid email or password!')),
                              );
                            }
                          },
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
