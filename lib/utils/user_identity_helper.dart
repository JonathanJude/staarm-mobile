import 'package:intercom_flutter/intercom_flutter.dart';
import 'package:staarm_mobile/app/locator.dart';
import 'package:staarm_mobile/core/models/user.dart';
import 'package:staarm_mobile/core/services/auth_service/auth_service.dart';
import 'package:staarm_mobile/core/services/sentry_service/sentry_service.dart';

import 'fb_analytics_helper.dart';
import 'mixpanel_helper.dart';

class UserIdentityHelper {
  UserIdentityHelper._();

  static final _authService = locator<AuthService>();
  static final _sentryService = locator<SentryService>();
  static final _firebaseAnalytics = FbAnalyticsHelper();
  static final MixPanelHelper mixPanel = MixPanelHelper();

  // set user profiles & identity on multiple third party services
  static void setUserIdentity(UserModel user) {
    //set user identity on `Sentry`
    _sentryService.setUser(user);

    // mixPanel.logEvent(StaarmEvents.onboardingStarted);

    //set useridentity on Branch after login
    try {
      if (user.phoneNumber != null && user.phoneNumber.isNotEmpty) {
        //set user identity on `Firebase Analytics`
        _firebaseAnalytics.setUserIdentity(user);

        //set user identity on `MixPanel`
        mixPanel.setUserIdentity(user);

        //set user identity on `Intercom`
        Intercom.registerIdentifiedUser(
          userId: user.phoneNumber ?? '',
          email: user.email ?? '',
        );
      }else{
        Intercom.registerUnidentifiedUser();
      }
    } catch (e) {
      print("mixpanel & firebase error on logging in -- ${e.toString()}");
    }
  }
}
