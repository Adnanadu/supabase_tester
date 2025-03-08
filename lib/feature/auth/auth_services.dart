import 'package:supabase_flutter/supabase_flutter.dart';

class AuthServices {
  final SupabaseClient _supabase = Supabase.instance.client;

  //sign in with email and password
  Future<AuthResponse> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    return await _supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  //sign up with email and password

  Future<AuthResponse> signUpWithEmailAndPassword(
    String email,
    String password,
  ) async {
    return await _supabase.auth.signUp(password: password, email: email);
  }

  //sign out

  Future<void> signOut() async {
    await _supabase.auth.signOut();
  }

  //get current user email

  String? getCurrentUserEmail() {
    final session = _supabase.auth.currentSession;
    final user = session?.user;
    return user?.email;
  }
}
