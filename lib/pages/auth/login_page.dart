import 'package:flutter/material.dart';
import 'package:keeper/services/auth.dart';
import 'package:keeper/widgets/utils.dart';

class LoginPage extends StatefulWidget {
  final Function toggleView;
  const LoginPage({super.key, required this.toggleView});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _googleLogoUrl =
      'https://upload.wikimedia.org/wikipedia/commons/thumb/3/3c/Google_Favicon_2025.svg/960px-Google_Favicon_2025.svg.png';

  final _formKey = GlobalKey<FormState>();

  bool _showPassowrd = false;
  bool _loading = false;
  bool _loginSuccess = true;

  String _email = '';
  String _password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton.outlined(
          onPressed: () {},
          icon: Icon(Icons.arrow_back),
        ),
        toolbarHeight: 250,
        flexibleSpace: Align(
          alignment: Alignment.bottomLeft,
          child: Padding(
            padding: const .symmetric(horizontal: 16.0),
            child: Text(
              'user login',
              style: Theme.of(context).textTheme.displayLarge,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Visibility(
            visible: _loading,
            maintainSize: true,
            maintainAnimation: true,
            maintainState: true,
            child: LinearProgressIndicator(),
          ),
          Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                spacing: 16.0,
                children: [
                  const SizedBox(height: 16.0),
                  // Email Text Input
                  TextFormField(
                    enabled: !_loading,
                    decoration: InputDecoration(label: Text('email')),
                    validator: (value) => value == null || value.isEmpty
                        ? 'please enter a email'
                        : null,
                    onChanged: (value) => setState(() => _email = value),
                  ),

                  // Password Text Input
                  TextFormField(
                    enabled: !_loading,
                    decoration: InputDecoration(
                      label: Text('password'),
                      suffixIcon: UtilityWidgets().visibilityIconButton(
                        _showPassowrd,
                        () => setState(() => _showPassowrd = !_showPassowrd),
                      ),
                    ),
                    validator: (value) => value == null || value.isEmpty
                        ? 'please enter a password'
                        : null,
                    onChanged: (value) => setState(() => _password = value),
                    obscureText: !_showPassowrd,
                  ),

                  // Sign in with Google Button
                  ElevatedButton(
                    onPressed: _loading ? null : () => _googleSignIn(),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          SizedBox(
                            width: 18.0,
                            height: 18.0,
                            child: FittedBox(
                              fit: BoxFit.contain,
                              child: Image.network(_googleLogoUrl),
                            ),
                          ),
                          const SizedBox(width: 12.0),
                          const Text('sign in with google'),
                        ],
                      ),
                    ),
                  ),

                  TextButton(
                    onPressed: _loading ? null : () => widget.toggleView(),
                    child: const Text('create new account'),
                  ),

                  if (!_loginSuccess)
                    Text(
                      'Invalid Credentials'.toUpperCase(),
                      style: TextStyle(color: Colors.red.shade700),
                    ),

                  const SizedBox(height: 8.0),
                ],
              ),
            ),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: _loading
            ? null
            : () async {
                if (_formKey.currentState!.validate()) {
                  setState(() => _loading = true);

                  await AuthenticationService()
                      .signIn(_email, _password)
                      .whenComplete(
                        () => setState(() {
                          _loading = false;
                          _loginSuccess = false;
                        }),
                      );
                }
              },
        label: Text('.login'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  void _googleSignIn() async {}
}
