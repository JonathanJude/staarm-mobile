import 'package:another_flushbar/flushbar.dart';
// import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:staarm_mobile/app/locator.dart';
import 'package:staarm_mobile/core/api/service_state.dart';
import 'package:staarm_mobile/core/services/navigator_service.dart';
import 'package:staarm_mobile/styles/colors.dart';
import 'package:staarm_mobile/widgets/staarm_alert.dart';

import 'error_helper.dart';

class StaarmAppNotification {
  StaarmAppNotification._();

  static Future<Flushbar<dynamic>> _show({
    @required String message,
    String title,
    Color backgroundColor,
    IconData icon,
  }) async {
    return Flushbar(
      shouldIconPulse: true,
      borderRadius: BorderRadius.circular(12),
      titleText: Text(
        title ?? '',
        style: TextStyle(
            fontSize: 12, color: Colors.white, fontWeight: FontWeight.bold),
      ),
      messageText: Text(
        message ?? '',
        style: TextStyle(fontSize: 12, color: Colors.white),
      ),
      backgroundColor: backgroundColor ?? Colors.red,
      flushbarPosition: FlushbarPosition.TOP,
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 7),
      icon: Icon(
        icon ?? Icons.info,
        size: 25.0,
        color: Colors.white,
      ),
      duration: Duration(milliseconds: 2000),
      animationDuration: Duration(milliseconds: 500),
    );
  }

  static Future<dynamic> success({
    BuildContext context,
    @required message,
  }) async {
    // Flushbar flush = await _show(
    //   message: message,
    //   backgroundColor: Colors.green,
    //   icon: Icons.check,
    //   title: 'Success',
    // );

    NavigationService navigationService = locator<NavigationService>();
    final _appContext = navigationService.navigatorKey.currentContext;

    return StaarmAlert.show(
      context ?? _appContext,
      title: 'Success',
      description: message ?? '',
      gravity: StaarmAlert.TOP,
      backgroundColor: AppColors.primaryColor,
      duration: 1,
      icon: Icons.check
    );

    // return flush.show(context ?? _appContext);
  }

  static Future<dynamic> error({
    BuildContext context,
    dynamic message,
  }) async {
    String errorMessage;

    if (message is ErrorState) {
      final error = message.value;
      errorMessage = error.errorMessage;
    } else if (message is String) {
      errorMessage = message;
    } else {
      errorMessage = genericErrorMessageString;
    }

    Flushbar flush = await _show(
      message: errorMessage ?? genericErrorMessageString,
      backgroundColor: Colors.red,
      icon: Icons.cancel,
      title: 'Error',
    );

    NavigationService navigationService = locator<NavigationService>();
    final _appContext = navigationService.navigatorKey.currentContext;

    return StaarmAlert.show(
      context ?? _appContext,
      title: 'Oops',
      description: errorMessage ?? genericErrorMessageString,
      gravity: StaarmAlert.TOP,
      backgroundColor: Colors.red,
      duration: 1,
      icon: Icons.clear
    );

    

    return flush.show(context ?? _appContext);
  }

  static Future<dynamic> info({
    BuildContext context,
    @required message,
    String title = 'Alert',
  }) async {
    Flushbar flush = await _show(
      message: message ?? 'alert',
      backgroundColor: AppColors.primaryColor,
      icon: Icons.info_outline,
      title: title,
    );

    NavigationService navigationService = locator<NavigationService>();
    final _appContext = navigationService.navigatorKey.currentContext;

    return StaarmAlert.show(
      context ?? _appContext,
      title: title ?? 'Alert',
      description: message,
      gravity: StaarmAlert.TOP,
      backgroundColor: AppColors.primaryColor,
      duration: 1,
      icon: Icons.info_outline
    );

    return flush.show(context ?? _appContext);
  }
}
