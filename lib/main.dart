import 'package:flutter/material.dart';
import 'package:supa_base_tester/core/secret/secret.dart';
import 'package:supa_base_tester/core/utils/constants.dart';
import 'package:supa_base_tester/feature/auth/auth_gate.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //initialize the supabase
  await Supabase.initialize(url: supabaseUrl, anonKey: Secret.apiKey);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: AuthGate());
  }
}
