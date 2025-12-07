import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// A small wrapper around Supabase auth APIs used by the app.
class AuthenticationService {
  final _supabase = Supabase.instance.client;

  /// Stream of authentication state changes, mapping to the current user
  /// when a session is active or `null` when signed out.
  Stream<User?> get authStateChanges =>
      _supabase.auth.onAuthStateChange.map((data) => data.session?.user);

  Future signUp(String email, String password) async {
    try {
      final AuthResponse response = await _supabase.auth.signUp(
        email: email,
        password: password,
      );
      final user = response.user;
      final session = response.session;

      if (session != null && user != null) {
        return user;
      } else {
        // This case is unlikely with a successful response, but good practice
        debugPrint('Sign-in completed but no session found.');
      }
    } on AuthException catch (e) {
      return handleAuthError(e);
    } on Exception catch (e) {
      debugPrint('Unexpected error: $e');
    }
  }

  Future signIn(String email, String password) async {
    try {
      final response = await _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      final user = response.user;
      final session = response.session;

      if (session != null && user != null) {
        return user;
      } else {
        // This case is unlikely with a successful response, but good practice
        debugPrint('Sign-in completed but no session found.');
      }
    } on AuthException catch (e) {
      debugPrint('Error signing in: $e');
    } on Exception catch (e) {
      debugPrint('Unexpected error: $e');
    }
  }

  /// Signs the current user out.
  Future<void> signOut() async {
    await _supabase.auth.signOut();
  }

  String handleAuthError(AuthException error) {
    // Use the error properties to show a user-friendly message
    debugPrint('Auth Error Code: ${error.statusCode}');
    debugPrint('Auth Error Message: ${error.message}');

    switch (error.statusCode) {
      case '400':
        if (error.message.contains('already registered')) {
          return 'This user already exists.';
        } else {
          return ('Invalid email or password format.');
        }
      case '429':
        return ('Too many attempts. Please try again later.');

      case '500':
        return ('Internal server problem. Contact support.');

      default:
        return (error.message);
    }
  }
}
