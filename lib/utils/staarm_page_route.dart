import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class StaarmPageRoute {
  StaarmPageRoute._();

  static MaterialPageRoute<T> routeTo<T>({
    Widget Function(BuildContext) builder,
    RouteSettings settings,
    bool maintainState = true,
    bool fullscreenDialog = false,
  }) {
    // return MaterialPageRoute<T>(
      return MaterialWithModalsPageRoute<T>(
        builder: builder,
        fullscreenDialog: fullscreenDialog,
        maintainState: maintainState,
        settings: settings,
      );
  }
}
