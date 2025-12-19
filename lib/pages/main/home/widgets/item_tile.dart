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
  final String searchQuery;

  const ItemTile({super.key, required this.item, required this.searchQuery});

  @override
  Widget build(BuildContext context) {
    final date = DateFormat('dd/MM/yy').format(item.updatedAt.toLocal());
    final isOutdated =
        DateTime.now().difference(item.updatedAt) > const Duration(days: 50);

    return IntrinsicHeight(
      child: Row(
        children: [
          Expanded(
            child: _MyListTile(
              item: item,
              searchQuery: searchQuery,
              date: date,
            ),
          ),

          item.isLost
              ? Container(width: 5, color: AppColors.error)
              : Container(),

          isOutdated
              ? Container(width: 5, color: Colors.yellowAccent)
              : Container(),

          item.isLocked
              ? Container(width: 5, color: AppColors.accent)
              : Container(),
        ],
      ),
    );
  }
}

class _MyListTile extends StatelessWidget {
  const _MyListTile({
    required this.item,
    required this.searchQuery,
    required this.date,
  });

  final Item item;
  final String searchQuery;
  final String date;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.background,
      child: InkWell(
        onTap: () => showDialog(
          context: context,
          builder: (_) => Provider.value(
            value: context.read<MyUser?>(),
            child: ItemDetailsDialog(item: item),
          ),
        ),
        child: Padding(
          padding: const .symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText.highlighted(
                item.name,
                searchQuery,
                style: AppTextStyles.titleMedium,
                highlightedStyle: AppTextStyles.titleMedium.copyWith(
                  backgroundColor: AppColors.secondary,
                ),
              ),
              const SizedBox(height: 4),
              AppText(item.description.toLowerCase()),
              const SizedBox(height: 4),
              AppText(
                '::last updated on: $date',
                style: AppTextStyles.labelLarge,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
