import 'package:flutter/material.dart';
import 'package:keeper/pages/auth/login_page.dart';
import 'package:keeper/pages/auth/register_page.dart';

class AuthenticatePage extends StatefulWidget {
  const AuthenticatePage({super.key});

  @override
  State<AuthenticatePage> createState() => _AuthenticatePageState();
}

class _AuthenticatePageState extends State<AuthenticatePage> {
  bool _showSignIn = true;
  void _toggleView() {
    //print(showSignIn.toString());
    setState(() => _showSignIn = !_showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        switchInCurve: Curves.easeIn,
        switchOutCurve: Curves.easeOut,
        transitionBuilder: (Widget child, Animation<double> animation) =>
            SizeTransition(sizeFactor: animation, child: child),
        child: _showSignIn
            ? LoginPage(toggleView: _toggleView)
            : RegisterPage(toggleView: _toggleView),
      ),
    );
  }
}
