import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:keeper/services/auth.dart';
import 'package:keeper/themes/app_tokens.dart';

class MyPopupMenu extends StatelessWidget {
  const MyPopupMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: Icon(Icons.more_vert_outlined),
      onSelected: (value) {
        switch (value) {
          case 0:
            _showMyDialog(context);
        }
      },
      itemBuilder: (context) => <PopupMenuEntry>[
        PopupMenuItem(
          value: 0,
          child: ListTile(
            title: Text('logout'),
            leading: Icon(Icons.logout_outlined),
          ),
        ),
        PopupMenuDivider(height: 0),
        PopupMenuItem(
          enabled: false,
          onTap: null,
          value: 1,
          child: ListTile(
            title: Text('settings'),
            leading: Icon(Icons.settings_outlined),
          ),
        ),
      ],
    );
  }

  Future<void> _showMyDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      useSafeArea: false,
      builder: (BuildContext context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
          child: AlertDialog(
            title: Row(
              spacing: 12.0,
              children: [
                Icon(Icons.logout, fontWeight: .w900),
                const Text('logout'),
              ],
            ),
            content: Text(
              'Are you sure you want to logout? You will need to sign in again to access your items.',
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('CANCEL'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text(
                  'LOGOUT',
                  style: .new(color: AppColors.error),
                ),
                onPressed: () async {
                  Navigator.of(context).pop();
                  await AuthenticationService().signOut();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
