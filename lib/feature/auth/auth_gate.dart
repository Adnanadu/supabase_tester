/*
AUTH GATE - This will continuosly listen for auth state changes.

---------------------------------------------------------------

unauthentication  ->  Login Page
authenticated    ->  Profile Page

*/

import 'package:flutter/material.dart';
import 'package:supa_base_tester/feature/auth/pages/login_page.dart';
import 'package:supa_base_tester/feature/notePage/view/pages/profile_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart'
    show AuthState, Supabase;
class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AuthState>(
      stream: Supabase.instance.client.auth.onAuthStateChange,
      builder: (context, snapshot) {
        //loading...
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        // check if user is authenticated
        final AuthState? authState = snapshot.data;
        final session = authState?.session;

        if (session != null) {
          return const ProfilePage();
        } else {
          return const LoginPage();
        }
      },
    );
  }
}
