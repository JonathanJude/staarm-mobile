import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:staarm_mobile/core/models/user.dart';
import 'package:staarm_mobile/core/services/navigator_service.dart';

import '../../../app/locator.dart';
import 'crashlytics_service.dart';

/// An absraction over the [firebase_crashlytics] library
class CrashlyticsServiceImpl extends CrashlyticsService {
  static final NavigationService _navigationService =
      locator<NavigationService>();
  BuildContext appContext = _navigationService.navigatorKey.currentContext;

  Future init() async {
    if (kDebugMode) {
      // Force disable Crashlytics collection while doing every day development.
      // Temporarily toggle this to true if you want to test crash reporting in your app.
      await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(false);
    } else {
      // Handle Crashlytics enabled status when not in Debug,
      // e.g. allow your users to opt-in to crash reporting.
    }
  }

  void reportError(dynamic error, {dynamic stackTrace}) async {
    await FirebaseCrashlytics.instance.recordError(
      error,
      stackTrace,
    );
  }

  void setUser(UserModel user) {
    if (user?.phoneNumber != null) {
      FirebaseCrashlytics.instance.setUserIdentifier(user?.phoneNumber ?? '');
    }
  }
}
