import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:keeper/enums/app_enums.dart';
import 'package:keeper/models/item.dart';
import 'package:keeper/pages/main/home/widgets/item_crud/item_form.dart';
import 'package:keeper/themes/app_tokens.dart';

class ShowCreateSheet {
  static void add(BuildContext context) {
    _open(context, mode: ItemFormMode.add);
  }

  static void update(BuildContext context, Item item) {
    _open(context, item: item, mode: ItemFormMode.update);
  }

  static void _open(
    BuildContext context, {
    Item? item,
    required ItemFormMode mode,
  }) {
    final barrierColor = AppColors.primary.withAlpha(200);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      barrierColor: barrierColor,
      builder: (_) => BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
        child: DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.65,
          builder: (_, controller) =>
              ItemForm(scrollController: controller, item: item, mode: mode),
        ),
      ),
    );
  }
}
