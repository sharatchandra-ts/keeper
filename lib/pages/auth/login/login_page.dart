import 'package:flutter/material.dart';
import 'package:keeper/pages/auth/login/login_forms.dart';
import 'package:keeper/pages/auth/widgets/auth_scaffold.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback toggleView;
  const LoginPage({super.key, required this.toggleView});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      title: 'user login',
      loading: loading,
      expandHeight: 250,
      child: LoginForm(
        loading: loading,
        toggleView: widget.toggleView,
        onLoadingChange: (v) => setState(() => loading = v),
      ),
    );
  }
}
