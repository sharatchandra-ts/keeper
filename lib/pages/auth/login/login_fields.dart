import 'package:flutter/material.dart';
import 'package:keeper/widgets/utils.dart';

class LoginEmailField extends StatelessWidget {
  final bool enabled;
  final ValueChanged<String> onChanged;

  const LoginEmailField({
    super.key,
    required this.enabled,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enabled,
      decoration: const InputDecoration(labelText: 'email'),
      validator: (v) => v!.isEmpty ? 'enter email' : null,
      keyboardType: TextInputType.emailAddress,
      onChanged: onChanged,
    );
  }
}

class LoginPasswordField extends StatelessWidget {
  final bool enabled;
  final bool obscure;
  final VoidCallback onToggle;
  final ValueChanged<String> onChanged;

  const LoginPasswordField({
    super.key,
    required this.enabled,
    required this.obscure,
    required this.onToggle,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enabled,
      obscureText: obscure,
      validator: (v) => v!.isEmpty ? 'enter password' : null,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: 'password',
        suffixIcon: UtilityWidgets().visibilityIconButton(obscure, onToggle),
      ),
    );
  }
}
