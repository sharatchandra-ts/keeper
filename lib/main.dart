import 'package:flutter/material.dart';
import 'package:keeper/services/auth.dart';
import 'package:keeper/pages/wrapper.dart';
import 'package:keeper/themes/app_theme.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  const supabaseUrl = 'https://rhnmkyettpmcrdjndjfa.supabase.co';
  const supabaseKey =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InJobm1reWV0dHBtY3Jkam5kamZhIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjUwMTgwOTksImV4cCI6MjA4MDU5NDA5OX0.pbGB9fkbogEvDwXqMs1TsCrOgdRVCJ4oHGZ3-D5Ohow';

  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(url: supabaseUrl, anonKey: supabaseKey);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User?>(
      create: (_) => AuthenticationService().authStateChanges,
      initialData: null,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const Wrapper(),
        theme: brutalistTheme,
      ),
    );
  }
}
