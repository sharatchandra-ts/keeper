import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:keeper/models/item.dart';
import 'package:keeper/models/item_snapshot.dart';
import 'package:keeper/pages/main/home/widgets/item_details/item_log_list.dart';
import 'package:keeper/themes/app_typography.dart';
import 'package:keeper/widgets/app_text.dart';

class ItemDetailsBody extends StatelessWidget {
  final Item item;
  final List<ItemSnapshot>? logs;

  const ItemDetailsBody({super.key, required this.item, required this.logs});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _section('++ item name ::', item.name),
          _section('++ location stored ::', item.location),
          _section('++ description ::', item.description),
          _section(
            '++ last updated ::',
            DateFormat(
              'dd MMMM yyyy, hh:mm a',
            ).format(item.updatedAt.toLocal()),
          ),
          AppText(
            'created on :: ${DateFormat('dd/MM/yyyy').format(item.createdAt!.toLocal())}',
          ),
          AppText('item locked :: ${item.isLocked}'),
          AppText('item lost :: ${item.isLost}'),
          AppText('no of updates :: ${logs?.length ?? 0}'),
          const Divider(height: 32),
          AppText('log;;'),
          ItemLogList(logs: logs),
        ],
      ),
    );
  }

  Widget _section(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          '$title\n${value.toLowerCase()}',
          style: AppTextStyles.titleSmall,
        ),
        const Divider(height: 32),
      ],
    );
  }
}
