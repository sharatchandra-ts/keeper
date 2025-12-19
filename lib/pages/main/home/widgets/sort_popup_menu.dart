import 'package:flutter/material.dart';

class SortPopupMenu extends StatelessWidget {
  const SortPopupMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: Icon(Icons.unfold_more),
      onSelected: (value) {
        switch (value) {
          case 0:
        }
      },
      itemBuilder: (context) => <PopupMenuEntry>[
        PopupMenuItem(
          value: 0,
          child: ListTile(title: Text('name'), leading: Icon(Icons.abc)),
        ),
        PopupMenuDivider(height: 0),
        PopupMenuItem(
          value: 1,
          child: ListTile(title: Text('date'), leading: Icon(Icons.date_range)),
        ),
      ],
    );
  }
}
