import 'package:flutter/material.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:staarm_mobile/core/models/user.dart';
import 'package:staarm_mobile/core/services/navigator_service.dart';
import 'package:staarm_mobile/core/services/sentry_service/sentry_service.dart';

import '../../../app/locator.dart';

/// An absraction over the [sentry_flutter] library
class SentryServiceImpl extends SentryService {
  static final NavigationService _navigationService =
      locator<NavigationService>();
  BuildContext appContext = _navigationService.navigatorKey.currentContext;

  Future init(AppRunner appRunner, String dsn) async {
    await SentryFlutter.init(
      (options) {
        options.dsn = dsn;
        options.beforeSend = (SentryEvent event, {dynamic hint}) {
          // send error to Sentry
          return event;
        };
      },
      appRunner: appRunner,
    );
  }

  void reportError(dynamic error, {dynamic stackTrace}) {
    Sentry.captureException(error, stackTrace: stackTrace);
  }

  void setUser(UserModel user) {
    Sentry.configureScope((scope) {
      if (user == null) {
        scope.user = null;
      } else {
        scope.user = SentryUser(
          id: user?.phoneNumber ?? '',
          username: "${user?.firstName + " " + user?.lastName}",
          email: user?.email ?? '',
        );
      }
    });
  }
}
