import 'package:flutter/material.dart';

import '../extension/app_x.dart';

abstract interface class DialogHelper {
  void show(BuildContext context,
      {required Widget child, Function(dynamic value)? callback});
}

final class DialogHelperImpl implements DialogHelper {
  @override
  void show(BuildContext context,
      {required Widget child,
      bool barrierDismissible = true,
      Function(dynamic value)? callback}) {
    showDialog(
            context: context,
            barrierDismissible: barrierDismissible,
            builder: (context) => child,
            barrierColor: Colors.black.withValues(alpha: 0.7)
            )
        .whenComplete(() => unfocusKeyboard())
        .then((value) => callback?.call(value));
  }
}

final dialogHelpers = DialogHelperImpl();
