import 'package:flutter/material.dart';
import 'package:keeper/models/item.dart';
import 'package:keeper/models/user.dart';
import 'package:keeper/services/auth.dart';
import 'package:keeper/services/database.dart';
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
      appBar: AppBar(
        title: Text('keeper'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await AuthenticationService().signOut();
            },
          ),
        ],
      ),
      body: myUser != null
          ? StreamBuilder<List<Item>>(
              stream: DatabaseService().streamItemsForUser(myUser.uid),
              builder: (context, asyncSnapshot) {
                if (asyncSnapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (asyncSnapshot.hasError) {
                  return Center(child: Text('Error: ${asyncSnapshot.error}'));
                } else if (!asyncSnapshot.hasData ||
                    asyncSnapshot.data!.isEmpty) {
                  return const Center(child: Text('No items found.'));
                }

                final List<Item> list = asyncSnapshot.data!;
                return ListView.builder(
                  itemBuilder: (context, index) =>
                      ListTile(title: Text(list[index].name)),
                  itemCount: list.length,
                );
              },
            )
          : const Center(child: CircularProgressIndicator()),
      floatingActionButton: FloatingActionButton.extended(
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
        label: Text('add.'),
      ),
    );
  }
}
