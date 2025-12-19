import 'package:flutter/material.dart';
import 'package:keeper/pages/auth/login/login_fields.dart';
import 'package:keeper/pages/auth/widgets/auth_social_buttons.dart';
import 'package:keeper/services/auth.dart';
import 'package:keeper/themes/app_typography.dart';
import 'package:keeper/widgets/app_buttons.dart';
import 'package:keeper/widgets/app_text.dart';

class LoginForm extends StatefulWidget {
  final bool loading;
  final VoidCallback toggleView;
  final ValueChanged<bool> onLoadingChange;

  const LoginForm({
    super.key,
    required this.loading,
    required this.toggleView,
    required this.onLoadingChange,
  });

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();

  bool showPassword = false;
  bool success = true;

  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          LoginEmailField(
            enabled: !widget.loading,
            onChanged: (v) => email = v,
          ),

          const SizedBox(height: 12),

          LoginPasswordField(
            enabled: !widget.loading,
            obscure: !showPassword,
            onToggle: () => setState(() => showPassword = !showPassword),
            onChanged: (v) => password = v,
          ),

          SizedBox(height: 8.0),

          forgotPasswordButton(),

          const SizedBox(height: 32),

          AppButton.large(
            onPressed: widget.loading ? null : _login,
            child: AppText('login'),
          ),

          const SizedBox(height: 3),

          AuthSocialButtons.google(disabled: widget.loading),

          const SizedBox(height: 3),

          AuthSocialButtons.github(disabled: widget.loading),

          const SizedBox(height: 8.0),

          TextButton(
            onPressed: widget.toggleView,
            child: AppText(
              'create new account',
              style: AppTextStyles.labelLarge,
            ),
          ),

          if (!success)
            AppText(
              'INVALID CREDENTIALS',
              style: TextStyle(color: Colors.red.shade700),
            ),
        ],
      ),
    );
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;

    widget.onLoadingChange(true);
    await AuthenticationService().signIn(email, password);
    widget.onLoadingChange(false);
    setState(() => success = false);
  }

  Widget forgotPasswordButton() => Align(
    alignment: .centerRight,
    child: InkWell(
      onTap: () {},
      child: Padding(
        padding: const .symmetric(horizontal: 8.0),
        child: Text(
          'forgot password?',
          style: Theme.of(
            context,
          ).textTheme.labelLarge!.copyWith(decoration: .underline),
        ),
      ),
    ),
  );
}
