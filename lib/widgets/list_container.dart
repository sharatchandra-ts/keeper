import 'package:flutter/material.dart';
import 'package:keeper/themes/app_tokens.dart';

class ListContainer extends StatelessWidget {
  const ListContainer({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const .fromLTRB(8.0, 16.0, 8.0, 0.0),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.light,
          border: Border(
            left: AppBorders.thick,
            right: AppBorders.thick,
            top: AppBorders.thick,
          ),
          borderRadius: .vertical(top: .circular(AppBorders.hardR)),
        ),
        child: Material(
          borderRadius: .vertical(top: .circular(AppBorders.hardR)),
          clipBehavior: .antiAlias,
          child: child,
        ),
      ),
    );
  }
}
