import 'package:flutter/material.dart';
import 'package:keeper/models/item.dart';
import 'package:keeper/pages/main/home/widgets/item_tile.dart';
import 'package:keeper/widgets/app_text.dart';
import 'package:keeper/widgets/list_container.dart';

class ItemListView extends StatelessWidget {
  final List<Item> items;
  const ItemListView({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return Center(child: AppText('No items to see'));
    }

    return ListContainer(
      child: ListView.builder(
        itemCount: items.length,
        itemBuilder: (_, index) => Column(
          children: [
            ItemTile(item: items[index]),
            Divider(),
          ],
        ),
      ),
    );
  }
}
