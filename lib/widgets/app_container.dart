import 'package:flutter/material.dart';
import 'package:keeper/enums/app_enums.dart';
import 'package:keeper/themes/app_tokens.dart';

class AppContainer extends StatelessWidget {
  final ContainerType containerType;

  const AppContainer._({
    Key? key,
    required this.child,
    required this.containerType,
  });

  factory AppContainer({Key? key, required child}) => AppContainer._(
    key: key,
    child: child,
    containerType: ContainerType.normal,
  );

  factory AppContainer.list({Key? key, required child}) =>
      AppContainer._(key: key, child: child, containerType: ContainerType.list);

  final Widget child;

  BorderRadius get radius => containerType == ContainerType.list
      ? BorderRadius.vertical(top: Radius.circular(AppBorders.hardR))
      : BorderRadius.all(Radius.circular(AppBorders.hardR));

  EdgeInsets get padding => containerType == ContainerType.list
      ? .fromLTRB(8.0, 16.0, 8.0, 0.0)
      : .symmetric(horizontal: 8.0, vertical: 16.0);

  Border get border => containerType == ContainerType.list
      ? .new(
          left: AppBorders.thick,
          right: AppBorders.thick,
          top: AppBorders.thick,
        )
      : Border.fromBorderSide(AppBorders.thick);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.light,
          border: border,
          borderRadius: radius,
        ),
        child: ClipRRect(borderRadius: radius, child: child),
      ),
    );
  }
}
