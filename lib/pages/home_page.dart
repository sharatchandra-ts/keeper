import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:keeper/models/item.dart';
import 'package:keeper/models/user.dart';
import 'package:keeper/services/auth.dart';
import 'package:keeper/services/database.dart';
import 'package:keeper/themes/app_tokens.dart';
import 'package:provider/provider.dart';

/// Home screen showing the user's items stream and actions.
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final myUser = context.watch<MyUser?>();

    return Scaffold(
      appBar: AppBar(title: Text('keeper'), actions: [MyPopupMenu()]),
      body: myUser != null
          ? Padding(
              padding: const .fromLTRB(8.0, 16.0, 8.0, 0.0),
              child: Material(
                shape: RoundedRectangleBorder(
                  borderRadius: .circular(6.0),
                  side: AppBorders.thick,
                ),
                clipBehavior: .antiAliasWithSaveLayer,
                child: StreamBuilder<List<Item>>(
                  stream: DatabaseService().streamItemsForUser(myUser.uid),
                  builder: (context, asyncSnapshot) {
                    if (asyncSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (asyncSnapshot.hasError) {
                      return Center(
                        child: Text('Error: ${asyncSnapshot.error}'),
                      );
                    } else if (!asyncSnapshot.hasData ||
                        asyncSnapshot.data!.isEmpty) {
                      return const Center(child: Text('No items found.'));
                    }

                    final List<Item> list = asyncSnapshot.data!;
                    return MyListViewBuilder(list: list);
                  },
                ),
              ),
            )
          : const Center(child: CircularProgressIndicator()),
      floatingActionButton: FloatingActionButton(
        onPressed: myUser != null
            ? () async {
                Item item = Item(
                  id: '',
                  ownerId: myUser.uid,
                  name: 'Sample Item3',
                  description: 'This is a sample item description.',
                  location: 'Sample Location',
                  isLocked: false,
                  isLost: false,
                  createdAt: DateTime.now(),
                  updatedAt: DateTime.now(),
                );

                // Create the item and (optionally) use the returned item
                // to update local state optimistically.
                await DatabaseService().createItem(item);
              }
            : null,
        child: Icon(Icons.add_outlined),
      ),
    );
  }
}

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

class MyListViewBuilder extends StatelessWidget {
  const MyListViewBuilder({super.key, required this.list});

  final List<Item> list;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        return Future.value();
      },
      child: ListView.builder(
        itemBuilder: (context, index) => MyListTile(item: list[index]),
        itemCount: list.length,
      ),
    );
  }
}

class MyListTile extends StatelessWidget {
  const MyListTile({super.key, required this.item});

  final Item item;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(item.name),
          subtitle: Text(item.description),
          onTap: () {},
        ),
        Divider(),
      ],
    );
  }
}
