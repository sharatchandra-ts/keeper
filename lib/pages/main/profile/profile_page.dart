import 'package:flutter/material.dart';
import 'package:keeper/models/user.dart';
import 'package:keeper/pages/main/profile/profile_info.dart';
import 'package:keeper/widgets/app_container.dart';
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
        padding: const EdgeInsets.all(8.0),
        child: AppContainer(child: ProfileInfo(myUser: myUser)),
      ),
    );
  }
}
