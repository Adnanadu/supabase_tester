
import 'package:flutter/material.dart';
import 'package:supa_base_tester/feature/auth/auth_services.dart';
import 'package:supa_base_tester/feature/auth/pages/register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //get auth services
  final authServices = AuthServices();

  //text controllers

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  //login button Function
  void login() async {
    final email = _emailController.text;
    final password = _passwordController.text;

    //sign in with email and password

    try {
      await authServices.signInWithEmailAndPassword(email, password);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Failed to sign in!')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 48),
        children: [
          TextField(
            controller: _emailController,
            decoration: const InputDecoration(labelText: 'Email'),
          ),
          SizedBox(height: 16),
          TextField(
            controller: _passwordController,
            decoration: const InputDecoration(labelText: 'Password'),
          ),
          SizedBox(height: 16),
          ElevatedButton(onPressed: login, child: const Text('Login')),
          SizedBox(height: 16),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RegisterPage()),
              );
            },
            child: Center(child: const Text("Don't have an account? Sign up")),
          ),
        ],
      ),
    );
  }
}
