import 'package:flutter/material.dart';
import 'package:keeper/pages/auth/authenticate.dart';
import 'package:keeper/pages/main/navigation_wrapper.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Top-level router that shows authentication screens when the user
/// is not signed in and the app content when signed in.
class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<User?>();

    return user == null ? const AuthenticatePage() : const HomeNavigation();
  }
}
