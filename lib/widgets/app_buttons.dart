import 'package:flutter/material.dart';
import 'package:keeper/enums/app_enums.dart';

class AppButton extends StatelessWidget {
  final ButtonType type;
  final VoidCallback? onPressed;
  final Widget child;

  const AppButton._({
    Key? key,
    required this.type,
    required this.onPressed,
    required this.child,
  });

  factory AppButton({
    Key? key,
    required VoidCallback? onPressed,
    required Widget child,
  }) => AppButton._(
    key: key,
    type: ButtonType.normal,
    onPressed: onPressed,
    child: child,
  );

  factory AppButton.large({
    Key? key,
    required VoidCallback? onPressed,
    required Widget child,
  }) => AppButton._(
    key: key,
    type: ButtonType.large,
    onPressed: onPressed,
    child: child,
  );

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case ButtonType.large:
        return _largeButton();
      default:
        return ElevatedButton(onPressed: onPressed, child: child);
    }
  }

  Widget _largeButton() => ElevatedButton(
    onPressed: onPressed,
    child: SizedBox(height: 64, child: Center(child: child)),
  );
}
