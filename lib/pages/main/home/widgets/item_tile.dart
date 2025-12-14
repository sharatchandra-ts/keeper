import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:keeper/models/item.dart';
import 'package:keeper/models/user.dart';
import 'package:keeper/pages/main/home/widgets/item_details/item_details_dialog.dart';
import 'package:keeper/themes/app_tokens.dart';
import 'package:keeper/themes/app_typography.dart';
import 'package:keeper/widgets/app_text.dart';
import 'package:provider/provider.dart';

class ItemTile extends StatelessWidget {
  final Item item;
  const ItemTile({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final date = DateFormat('dd/MM/yy').format(item.updatedAt.toLocal());

    return ListTile(
      title: AppText(
        item.name,
        style: AppTextStyles.label.copyWith(fontSize: 18.0),
      ),
      subtitle: Column(
        crossAxisAlignment: .start,
        children: [
          AppText(
            item.description.toLowerCase(),
            style: AppTextStyles.body.copyWith(
              color: AppColors.onLight.withAlpha(180),
            ),
          ),
          AppText('::last updated on: $date'),
        ],
      ),
      isThreeLine: true,
      onTap: () => showDialog(
        context: context,
        builder: (_) => Provider.value(
          value: context.read<MyUser?>(),
          child: ItemDetailsDialog(item: item),
        ),
      ),
    );
  }
}
