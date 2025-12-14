import 'package:flutter/material.dart';
import 'package:keeper/models/user.dart';
import 'package:keeper/themes/app_tokens.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final MyUser? myUser = context.watch<MyUser?>();

    if (myUser == null) {
      return LinearProgressIndicator();
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
        child: Material(
          shape: RoundedRectangleBorder(
            side: AppBorders.thick,
            borderRadius: AppBorders.hard,
          ),
          child: Column(
            mainAxisSize: .max,
            children: [
              Text('name: ${myUser.name}'),
              Text('email: ${myUser.email}'),
              Text('phone: ${myUser.phone ?? 'not there'}'),
              Text('uid: ${myUser.uid}'),
              SizedBox(width: .maxFinite),
            ],
          ),
        ),
      ),
    );
  }
}
