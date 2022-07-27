import 'dart:async';

import 'package:flutter/material.dart';

import '../utils/staarm_toast.dart';

/// Allows the user to close the app by double tapping the back-button.
///
/// You must specify a [SnackBar], so it can be shown when the user taps the
/// back-button. Notice that the value you set for [SnackBar.duration] is going
/// to be considered to decide whether the snack-bar is currently visible or
/// not.
///
/// Since the back-button is an Android feature, this Widget is going to be
/// nothing but the own [child] if the current platform is anything but Android.
class ConfirmBackTap extends StatefulWidget {
  /// The [SnackBar] shown when the user taps the back-button.
  final String message;

  /// The widget below this widget in the tree.
  final Widget child;

  /// Creates a widget that allows the user to close the app by double tapping
  /// the back-button.
  const ConfirmBackTap({
    Key key,
    @required this.message,
    @required this.child,
  }) : super(key: key);

  @override
  _ConfirmBackTapState createState() => _ConfirmBackTapState();
}

class _ConfirmBackTapState extends State<ConfirmBackTap> {
  /// The last time the user tapped Android's back-button.
  DateTime _lastTimeBackButtonWasTapped;

  /// Returns whether the current platform is Android.
  bool get _isAndroid => Theme.of(context).platform == TargetPlatform.android;

  /// Returns whether the [ConfirmBackTap.snackBar] is currently visible.
  ///
  /// The snack-bar is going to be considered visible if the duration of the
  /// snack-bar is greater than the difference from now to the
  /// [_lastTimeBackButtonWasTapped].
  ///
  /// This is not quite accurate since the snack-bar could've been dismissed by
  /// the user, so this algorithm needs to be improved, as described in #2.
  // bool get _isSnackBarVisible {
  //   final lastTimeBackButtonWasTapped = _lastTimeBackButtonWasTapped;
  //   return (lastTimeBackButtonWasTapped != null) &&
  //       (widget.snackBar.duration >
  //           DateTime.now().difference(lastTimeBackButtonWasTapped));
  // }

  /// Returns whether the next back navigation of this route will be handled
  /// internally.
  ///
  /// Returns true when there's a widget that inserted an entry into the
  /// local-history of the current route, in order to handle pop. This is done
  /// by [Drawer], for example, so it can close on pop.
  bool get _willHandlePopInternally =>
      ModalRoute.of(context)?.willHandlePopInternally ?? false;

  @override
  Widget build(BuildContext context) {
    assert(() {
      _ensureThatContextContainsScaffold();
      return true;
    }());

    if (_isAndroid) {
      return WillPopScope(
        onWillPop: _handleWillPop,
        child: widget.child,
      );
    } else {
      return widget.child;
    }
  }

  /// Handles [WillPopScope.onWillPop].
  Future<bool> _handleWillPop() async {
    // if (_isSnackBarVisible || _willHandlePopInternally) {
    if (_willHandlePopInternally) {
      return true;
    } else {
      _lastTimeBackButtonWasTapped = DateTime.now();
      // final scaffoldMessenger = ScaffoldMessenger.of(context);
      // scaffoldMessenger.hideCurrentSnackBar();
      // scaffoldMessenger.showSnackBar(widget.snackBar);
      StaarmToast.success(message: widget.message ?? 'Press again to go back');
      return false;
    }
  }

  /// Throws a [FlutterError] if this widget was not wrapped in a [Scaffold].
  void _ensureThatContextContainsScaffold() {
    if (Scaffold.maybeOf(context) == null) {
      throw FlutterError(
        '`ConfirmBackTap` must be wrapped in a `Scaffold`.',
      );
    }
  }
}
