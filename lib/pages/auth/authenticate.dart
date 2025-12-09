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
    return _showSignIn
        ? LoginPage(toggleView: _toggleView)
        : RegisterPage(toggleView: _toggleView);

    /* Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: .center,
            children: [
              ElevatedButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                ),
                child: Text('login'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RegisterPage(toggleView: _toggleView),
                  ),
                ),
                child: Text('register'),
              ),
            ],
          ),
        ),
      ), 
    );*/
  }
}
