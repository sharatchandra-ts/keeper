import 'package:flutter/material.dart';
import 'package:keeper/models/item.dart';
import 'package:keeper/models/user.dart';
import 'package:keeper/pages/auth/authenticate.dart';
import 'package:keeper/pages/navigation_wrapper.dart';
import 'package:keeper/services/database.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Top-level router that shows authentication screens when the user
/// is not signed in and the app content when signed in.
class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<User?>();

    return user == null
        ? const AuthenticatePage()
        : StreamBuilder<MyUser?>(
            stream: DatabaseService().streamUserFromId(user.id),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Scaffold(
                  body: Center(child: CircularProgressIndicator()),
                );
              }

              // Pass the resolved MyUser (may be null) down via Provider
              return Provider<MyUser?>.value(
                value: snapshot.data,
                child: StreamProvider<List<Item>?>(
                  create: (_) =>
                      DatabaseService().streamItemsForUser(snapshot.data!.uid),
                  builder: (context, asyncSnapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Scaffold(
                        body: Center(child: CircularProgressIndicator()),
                      );
                    }
                    return HomeNavigation();
                  },
                  initialData: null,
                ),
              );
            },
          );
  }
}
