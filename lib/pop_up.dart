import 'package:flutter/material.dart';

Future<T> showMobilePopup<T>({
  @required BuildContext context,
  bool barrierDismissible = true,
  bool mobilePush = false,
  WidgetBuilder builder,
}) {
  if (mobilePush) {
    return Navigator.of(context).push<T>(
      MaterialPageRoute(builder: builder),
    );
  }

  assert(debugCheckHasMaterialLocalizations(context));

  final theme = Theme.of(context);
  return showGeneralDialog(
    context: context,
    pageBuilder: (context, animation, secondaryAnimation) {
      final pageChild = Builder(builder: builder);
      return Builder(
        builder: (context) => theme != null
            ? Theme(
                data: theme,
                child: pageChild,
              )
            : pageChild,
      );
    },
    barrierDismissible: barrierDismissible,
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    barrierColor: Colors.black54,
    transitionDuration: const Duration(milliseconds: 150),
    transitionBuilder: _buildMaterialDialogTransitions,
  );
}

Widget _buildMaterialDialogTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child) {
  return FadeTransition(
    opacity: CurvedAnimation(
      parent: animation,
      curve: Curves.easeOut,
    ),
    child: child,
  );
}
