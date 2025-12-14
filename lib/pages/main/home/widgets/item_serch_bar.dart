import 'package:flutter/material.dart';
import 'package:keeper/themes/app_tokens.dart';

class ItemSearchBar extends StatelessWidget {
  const ItemSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController textController = TextEditingController();

    return SizedBox(
      height: 56,

      child: TextField(
        controller: textController,
        autofocus: true,
        expands: true,
        maxLines: null,
        decoration: InputDecoration(
          label: const Icon(Icons.search),
          hintText: 'Search',
          suffixIcon: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              textController.clear();
            },
          ),
          border: OutlineInputBorder(borderRadius: AppBorders.soft),
          focusedBorder: OutlineInputBorder(
            borderRadius: AppBorders.soft,
            borderSide: AppBorders.thick,
          ),
        ),
      ),
    );
  }
}
