import 'package:flutter/material.dart';
import 'package:keeper/models/item.dart';
import 'package:keeper/pages/main/home/widgets/item_tile.dart';
import 'package:keeper/widgets/app_text.dart';

class ItemListView extends StatelessWidget {
  final List<Item> items;
  final String searchQuery;
  const ItemListView({
    super.key,
    required this.items,
    required this.searchQuery,
  });

  @override
  Widget build(BuildContext context) {
    List<Item> searchResult = searchQuery.isNotEmpty
        ? items
              .where((item) => item.name.toLowerCase().contains(searchQuery))
              .toList()
        : items;

    if (items.isEmpty) {
      return Center(child: AppText('No items to see'));
    }

    return ListView.builder(
      itemCount: searchResult.length,
      itemBuilder: (_, index) => Column(
        children: [
          ItemTile(item: searchResult[index], searchQuery: searchQuery),
          Divider(),
        ],
      ),
    );
  }
}
