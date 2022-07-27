import 'dart:async';

import 'package:flutter/foundation.dart';

class AppDebouncer {
  final int milliseconds;
  VoidCallback action;
  Timer _timer;

  AppDebouncer({this.milliseconds});

  void run(VoidCallback action) {
    if (_timer != null) {
      _timer.cancel();
    }

    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}