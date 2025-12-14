import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:keeper/models/item_snapshot.dart';
import 'package:keeper/widgets/app_text.dart';

class ItemLogList extends StatelessWidget {
  final List<ItemSnapshot>? logs;

  const ItemLogList({super.key, required this.logs});

  @override
  Widget build(BuildContext context) {
    if (logs == null) {
      return const AppText('loading...');
    }

    if (logs!.isEmpty) {
      return const AppText('no logs yet');
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(
        logs!.length,
        (i) => AppText(
          '{$i:${DateFormat('dd/MM/yyyy').format(logs![i].timestamp!.toLocal())}'
          ': location::${logs![i].location}}',
        ),
      ),
    );
  }
}
