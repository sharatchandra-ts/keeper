import 'package:flutter/material.dart';
import 'package:keeper/pages/main/home/widgets/item_crud/create_sheet.dart';

class HomeFab extends StatelessWidget {
  final Function() onSearch;

  const HomeFab({super.key, required this.onSearch});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [_addFab(context), const SizedBox(width: 4), _searchFab()],
    );
  }

  // FABs

  Widget _addFab(BuildContext context) {
    return FloatingActionButton(
      heroTag: 'addFab',
      onPressed: () => ShowCreateSheet.add(context),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.horizontal(
          left: Radius.circular(16),
          right: Radius.circular(6),
        ),
      ),
      child: const Icon(Icons.add),
    );
  }

  Widget _searchFab() {
    return FloatingActionButton(
      heroTag: 'searchFab',
      onPressed: onSearch,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.horizontal(
          left: Radius.circular(6),
          right: Radius.circular(16),
        ),
      ),
      child: const Icon(Icons.search),
    );
  }
}
