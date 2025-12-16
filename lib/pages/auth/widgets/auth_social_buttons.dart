import 'package:flutter/material.dart';
import 'package:keeper/enums/app_enums.dart';
import 'package:keeper/widgets/app_buttons.dart';

class AuthSocialButtons extends StatelessWidget {
  final _googleLogoUrl =
      'https://upload.wikimedia.org/wikipedia/commons/thumb/3/3c/Google_Favicon_2025.svg/960px-Google_Favicon_2025.svg.png';
  final _githubLogoUrl = 'https://img.icons8.com/ios11/512/FFFFFF/github.png';

  final bool disabled;
  final SocialType type;

  const AuthSocialButtons._({
    Key? key,
    required this.type,
    required this.disabled,
  });

  factory AuthSocialButtons.google({Key? key, required disabled}) =>
      AuthSocialButtons._(
        key: key,
        disabled: disabled,
        type: SocialType.google,
      );

  factory AuthSocialButtons.github({Key? key, required disabled}) =>
      AuthSocialButtons._(
        key: key,
        disabled: disabled,
        type: SocialType.github,
      );

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case SocialType.google:
        return _button(iconUrl: _googleLogoUrl, label: 'sign in with google');
      case .github:
        return _button(iconUrl: _githubLogoUrl, label: 'sign in with github');
    }
  }

  Widget _button({
    required String iconUrl,
    required String label,
    VoidCallback? onTap,
  }) {
    return AppButton(
      onPressed: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(width: 18, height: 18, child: Image.network(iconUrl)),
          const SizedBox(width: 12),
          Text(label),
        ],
      ),
    );
  }
}
