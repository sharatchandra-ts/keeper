import 'package:flutter/material.dart';

class UtilityWidgets {
  Widget visibilityIconButton(
    bool showPassword,
    VoidCallback toggleVisibility,
  ) {
    return IconButton(
      icon: showPassword
          ? Icon(Icons.visibility_outlined)
          : Icon(Icons.visibility_off_outlined),
      onPressed: toggleVisibility,
    );
  }
}
