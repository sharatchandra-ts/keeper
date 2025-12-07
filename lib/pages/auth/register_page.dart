import 'package:flutter/material.dart';
import 'package:keeper/services/auth.dart';
import 'package:keeper/services/database.dart';
import 'package:keeper/widgets/utils.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RegisterPage extends StatefulWidget {
  final Function toggleView;
  const RegisterPage({super.key, required this.toggleView});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _googleLogoUrl =
      'https://upload.wikimedia.org/wikipedia/commons/thumb/3/3c/Google_Favicon_2025.svg/960px-Google_Favicon_2025.svg.png';

  final _formKey = GlobalKey<FormState>();

  bool _showPassowrd = false;
  bool _loading = false;
  bool _registerSuccess = true;

  String _errorMessage = 'Invalid Credentials';

  String _name = '';
  String _email = '';
  String? _phone;
  String _password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('create user')),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            spacing: 16.0,
            children: [
              const SizedBox(height: 12.0),
              // Name Text Input
              TextFormField(
                enabled: !_loading,
                decoration: InputDecoration(label: Text('full name*')),
                validator: (value) => value == null || value.isEmpty
                    ? 'please enter a name'
                    : null,
                onChanged: (value) => setState(() => _name = value),
                keyboardType: TextInputType.name,
              ),

              // Email Text Input
              TextFormField(
                enabled: !_loading,
                decoration: InputDecoration(label: Text('email*')),
                validator: (value) => value == null || value.isEmpty
                    ? 'please enter a email'
                    : null,
                onChanged: (value) => setState(() => _email = value),
                keyboardType: TextInputType.emailAddress,
              ),

              // Phone Text Input
              TextFormField(
                enabled: !_loading,
                decoration: InputDecoration(
                  label: Text('phone no'),
                  counterText: '',
                ),
                onChanged: (value) => setState(() => _phone = value),
                keyboardType: TextInputType.number,
                maxLength: 10,
              ),

              // Password Text Input
              TextFormField(
                enabled: !_loading,
                decoration: InputDecoration(
                  label: Text('password*'),
                  suffixIcon: UtilityWidgets().visibilityIconButton(
                    _showPassowrd,
                    () => setState(() => _showPassowrd = !_showPassowrd),
                  ),
                ),
                validator: (value) => value!.length < 8 || value.isEmpty
                    ? 'password must be at least 8 characters long'
                    : null,
                onChanged: (value) => setState(() => _password = value),
                obscureText: !_showPassowrd,
              ),
              TextFormField(
                enabled: !_loading,
                decoration: InputDecoration(label: Text('confirm password*')),
                validator: (value) => value != _password
                    ? 'please enter a matching password'
                    : null,
                obscureText: !_showPassowrd,
              ),

              // Sign in with Google Button
              OutlinedButton(
                onPressed: _loading
                    ? null
                    : () {
                        // implement google sign-in logic here
                      },
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
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
                child: const Text('login to existing account'),
              ),

              _registerSuccess
                  ? Container()
                  : Text(
                      _errorMessage.toUpperCase(),
                      style: TextStyle(color: Colors.red.shade700),
                    ),

              const SizedBox(height: 8.0),
              if (_loading)
                const SizedBox(height: 4.0, child: LinearProgressIndicator()),
            ],
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: _loading
            ? null
            : () async {
                if (_formKey.currentState!.validate()) await handleSignUp();
              },
        label: Text('.create-account'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Future<void> handleSignUp() async {
    setState(() => _loading = true);

    try {
      final response = await AuthenticationService().signUp(_email, _password);
      if (response is User) {
        await DatabaseService()
            .createUser(response, _name, _phone)
            .whenComplete(() => setState(() => _loading = false));
      } else {
        setState(() {
          _loading = false;
          _registerSuccess = false;
        });
        setState(() => _errorMessage = response.toString());
      }
    } catch (e) {
      setState(() => _loading = false);

      debugPrint('Error during sign-up process in register: $e');
    }
  }
}
