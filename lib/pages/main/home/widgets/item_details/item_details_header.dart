import 'package:flutter/material.dart';
import 'package:keeper/models/item.dart';
import 'package:keeper/pages/main/home/controller/home_controller.dart';
import 'package:keeper/pages/main/home/widgets/item_crud/create_sheet.dart';
import 'package:keeper/themes/app_tokens.dart';
import 'package:keeper/themes/app_typography.dart';
import 'package:keeper/widgets/app_text.dart';
import 'package:provider/provider.dart';

class ItemDetailsHeader extends StatelessWidget {
  final Item item;

  const ItemDetailsHeader({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      leading: IconButton(
        icon: const Icon(Icons.close),
        onPressed: () => Navigator.pop(context),
      ),
      title: AppText(
        'item details',
        style: AppTextStyles.label.copyWith(fontSize: 18),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.edit_outlined),
          onPressed: () {
            Navigator.pop(context);
            ShowCreateSheet.update(context, item);
          },
        ),
        PopupMenuButton<int>(
          icon: const Icon(Icons.delete_outline_rounded),
          onSelected: (value) {
            if (value == 1) {
              context.read<HomeController>().deleteItem(item);
              Navigator.pop(context);
            }
          },
          itemBuilder: (_) => [
            const PopupMenuItem(value: 0, child: AppText('archive')),
            const PopupMenuDivider(height: 0),
            PopupMenuItem(
              value: 1,
              child: AppText(
                'confirm delete',
                style: AppTextStyles.label.copyWith(color: AppColors.error),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
