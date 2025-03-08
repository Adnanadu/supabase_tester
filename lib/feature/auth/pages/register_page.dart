import 'package:flutter/material.dart';
import 'package:supa_base_tester/feature/auth/auth_services.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //get auth services
  final authServices = AuthServices();

  //text controllers

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  //signup button Function
  void signUp() async {
    final email = _emailController.text;
    final password = _passwordController.text;
    final confirPassword = _confirmPasswordController.text;

    //sign up with email and password
    if (password != confirPassword) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Password does not match')));
    } else {
      //attempt to sign up
      try {
        await authServices.signUpWithEmailAndPassword(email, password);

        //if successful, pop the page
        if (mounted) {
          Navigator.pop(context);
        }
      }
      //catch any errors
      catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Failed to sign up!')));
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign Up')),
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
          TextField(
            controller: _confirmPasswordController,
            decoration: const InputDecoration(labelText: 'Confirm Password'),
          ),
          SizedBox(height: 16),
          ElevatedButton(onPressed: signUp, child: const Text('Login')),
        ],
      ),
    );
  }
}
