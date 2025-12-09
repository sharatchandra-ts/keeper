import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:keeper/models/item.dart';
import 'package:keeper/themes/app_tokens.dart';
import 'package:keeper/themes/app_typography.dart';
import 'package:keeper/pages/item_sheet.dart';
import 'package:marquee/marquee.dart';
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
    final List<Item>? items = context.watch<List<Item>?>();

    if (items == null) {
      return Scaffold(body: LinearProgressIndicator());
    }

    return Scaffold(
      body: Column(
        mainAxisSize: .max,
        children: [
          // List of all the items
          ItemListView(items: items),

          // Bottom info marquee
          Container(
            color: Colors.black,
            width: .maxFinite,
            height: 20,
            child: Marquee(
              text:
                  'NO OF ITEMS STORED: ${items.length} :: NO OF ITEMS LOST: ${items.where((item) => item.isLost).length} :: ',
              style: AppTextStyles.label.copyWith(color: Colors.white),
            ),
          ),
        ],
      ),

      floatingActionButtonLocation: .centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FloatingActionButton(
          onPressed: () => ShowCreateSheet.itemSheetAdd(context),
          child: Icon(Icons.add_outlined),
        ),
      ),
    );
  }
}

// This is the list of all the items the home page shows
class ItemListView extends StatelessWidget {
  const ItemListView({super.key, required this.items});

  final List<Item> items;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const .fromLTRB(8.0, 16.0, 8.0, 0.0),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            border: Border(
              left: AppBorders.thick,
              right: AppBorders.thick,
              top: AppBorders.thick,
            ),
            borderRadius: .vertical(top: .circular(6.0)),
          ),
          child: Material(
            borderRadius: .vertical(top: .circular(6.0)),
            clipBehavior: .antiAliasWithSaveLayer,
            child: items.isNotEmpty
                ? RefreshIndicator(
                    onRefresh: () async {
                      return Future.value();
                    },
                    child: ListView.builder(
                      itemBuilder: (context, index) => MyListTile(
                        item: items[index],
                        onTap: () {
                          showDialog(
                            context: context,
                            useSafeArea: true,
                            builder: (dialogContext) => Dialog(
                              insetPadding: .symmetric(
                                horizontal: 16.0,
                                vertical: 56.0,
                              ),
                              child: ItemDetailsDialog(
                                item: items[index],
                                mainContext: context,
                              ),
                            ),
                          );

                          // ShowCreateSheet.itemSheetUpdate(
                          //   context,
                          //   items[index],
                          // );
                        },
                      ),
                      itemCount: items.length,
                    ),
                  )
                : Center(
                    child: Text(
                      'No items to see, try adding new items.',
                      style: AppTextStyles.label,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}

class ItemDetailsDialog extends StatelessWidget {
  const ItemDetailsDialog({
    super.key,
    required this.item,
    required this.mainContext,
  });

  final Item item;
  final BuildContext mainContext;

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),

      child: Material(
        borderRadius: AppBorders.soft,
        clipBehavior: .antiAlias,
        child: Column(
          mainAxisSize: .max,
          children: [
            AppBar(
              leading: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(Icons.close),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                    ShowCreateSheet.itemSheetUpdate(mainContext, item);
                  },
                  icon: Icon(Icons.edit_outlined),
                ),
              ],
              centerTitle: true,
              title: Text(
                'item details',
                style: AppTextStyles.label.copyWith(fontSize: 18.0),
              ),
            ),
            Divider(),
            Text('item location:: ${item.location}'),
          ],
        ),
      ),
    );
  }
}

class MyListTile extends StatelessWidget {
  const MyListTile({super.key, required this.item, required this.onTap});

  final Item item;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    final date = DateFormat('dd/MM/yy').format(item.updatedAt.toLocal());

    return Column(
      children: [
        ListTile(
          title: Text(item.name, style: .new(fontSize: 18.0)),
          subtitle: Column(
            crossAxisAlignment: .start,
            children: [
              Text(item.description.toLowerCase()),
              Text('::last updated on: $date', style: AppTextStyles.label),
            ],
          ),
          isThreeLine: true,

          onTap: onTap,
        ),
        Divider(),
      ],
    );
  }
}
