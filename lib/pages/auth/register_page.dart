import 'package:flutter/material.dart';
import 'package:keeper/pages/auth/widgets/auth_social_buttons.dart';
import 'package:keeper/services/auth.dart';
import 'package:keeper/services/database.dart';
import 'package:keeper/themes/app_typography.dart';
import 'package:keeper/widgets/app_text.dart';
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

  void moveFocusToNext(BuildContext context) {
    FocusScope.of(context).unfocus();
    FocusScope.of(context).nextFocus();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 150.0,
              flexibleSpace: Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const .symmetric(horizontal: 16.0),
                  child: AppText(
                    'create user',
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate([
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
                      children: [
                        const SizedBox(height: 16.0),
                        // Name Text Input
                        TextFormField(
                          autofocus: true,
                          enabled: !_loading,
                          decoration: InputDecoration(
                            label: AppText('full name*'),
                          ),
                          validator: (value) => value == null || value.isEmpty
                              ? 'please enter a name'
                              : null,
                          onChanged: (value) => setState(() => _name = value),
                          keyboardType: TextInputType.name,
                          textInputAction: TextInputAction.next,
                        ),

                        const SizedBox(height: 16.0),

                        // Email Text Input
                        TextFormField(
                          enabled: !_loading,
                          decoration: InputDecoration(label: AppText('email*')),
                          validator: (value) => value == null || value.isEmpty
                              ? 'please enter a email'
                              : null,
                          onChanged: (value) => setState(() => _email = value),
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                        ),

                        const SizedBox(height: 12.0),

                        // Phone Text Input
                        TextFormField(
                          enabled: !_loading,
                          decoration: InputDecoration(
                            label: AppText('phone no'),
                            counterText: '',
                          ),
                          onChanged: (value) => setState(() => _phone = value),
                          keyboardType: TextInputType.number,
                          maxLength: 10,
                          textInputAction: TextInputAction.next,
                        ),

                        const SizedBox(height: 12.0),

                        // Password Text Input
                        TextFormField(
                          enabled: !_loading,
                          decoration: InputDecoration(
                            label: AppText('password*'),
                          ),
                          validator: (value) =>
                              value!.length < 8 || value.isEmpty
                              ? 'password must be at least 8 characters long'
                              : null,
                          onChanged: (value) =>
                              setState(() => _password = value),
                          obscureText: !_showPassowrd,
                          textInputAction: TextInputAction.next,
                        ),

                        const SizedBox(height: 12.0),

                        TextFormField(
                          scrollPadding: EdgeInsets.only(bottom: 30),
                          enabled: !_loading,
                          decoration: InputDecoration(
                            label: AppText('confirm password*'),
                            suffixIcon: UtilityWidgets().visibilityIconButton(
                              _showPassowrd,
                              () => setState(
                                () => _showPassowrd = !_showPassowrd,
                              ),
                            ),
                          ),
                          validator: (value) => value != _password
                              ? 'please enter a matching password'
                              : null,
                          textInputAction: TextInputAction.done,
                          obscureText: !_showPassowrd,
                        ),

                        const SizedBox(height: 32.0),

                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          onPressed: _loading
                              ? null
                              : () async {
                                  if (_formKey.currentState!.validate()) {
                                    await handleSignUp();
                                  }
                                },

                          child: SizedBox(
                            height: 64,
                            child: Center(child: Text('register')),
                          ),
                        ),

                        const SizedBox(height: 3.0),

                        AuthSocialButtons.google(disabled: _loading),

                        const SizedBox(height: 3.0),

                        AuthSocialButtons.github(disabled: _loading),

                        const SizedBox(height: 8.0),

                        TextButton(
                          onPressed: _loading
                              ? null
                              : () => widget.toggleView(),
                          child: AppText(
                            'login to existing account',

                            style: AppTextStyles.labelLarge,
                          ),
                        ),

                        const SizedBox(height: 16.0),

                        _registerSuccess
                            ? Container()
                            : AppText(
                                _errorMessage.toUpperCase(),
                                style: TextStyle(color: Colors.red.shade700),
                              ),
                      ],
                    ),
                  ),
                ),
              ]),
            ),
          ],
        ),
      ),
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
