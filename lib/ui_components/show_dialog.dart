import "package:flutter/material.dart";

Future<T?> showDialog<T>({
  required BuildContext context,
  required WidgetBuilder builder,
  bool barrierDismissible = true,
  Color? barrierColor = Colors.black54,
  String? barrierLabel,
  bool useSafeArea = true,
  bool useRootNavigator = true,
  RouteSettings? routeSettings,
  Offset? anchorPoint,
}) {
  return showDialog(
    //This is the only setting that we modify:
    useRootNavigator: false,
    //These all just pass through
    context: context,
    builder: (_) {
      return builder(context);
    },
    barrierDismissible: barrierDismissible,
    barrierColor: barrierColor, barrierLabel: barrierLabel,
    useSafeArea: useSafeArea,
    routeSettings: routeSettings,
    anchorPoint: anchorPoint,
  );
}
