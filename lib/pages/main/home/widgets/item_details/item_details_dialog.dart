import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:keeper/models/item.dart';
import 'package:keeper/models/item_snapshot.dart';
import 'package:keeper/pages/main/home/widgets/item_details/item_details_body.dart';
import 'package:keeper/pages/main/home/widgets/item_details/item_details_header.dart';
import 'package:keeper/services/database.dart';
import 'package:keeper/themes/app_tokens.dart';

class ItemDetailsDialog extends StatelessWidget {
  final Item item;

  const ItemDetailsDialog({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
      child: StreamBuilder<List<ItemSnapshot>>(
        stream: DatabaseService().streamItemSnapshotForItem(item.id!),
        builder: (context, snapshot) {
          final logs = snapshot.data;

          return Dialog(
            insetPadding: .symmetric(horizontal: 16.0, vertical: 56.0),
            shape: RoundedRectangleBorder(
              borderRadius: AppBorders.soft,
              side: AppBorders.thick,
            ),
            clipBehavior: .antiAlias,

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ItemDetailsHeader(item: item),
                const Divider(height: 0),
                Expanded(
                  child: ItemDetailsBody(item: item, logs: logs),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
