import 'package:flutter/foundation.dart';
import 'package:staarm_mobile/core/models/user.dart';

import '../main.dart';

class FbAnalyticsHelper {
  Future<void> recordEvent(String title, {Map<String, dynamic> data}) async {
    bool isRelease = kReleaseMode;

    if (isRelease) {
      await analytics.logEvent(name: title, parameters: data);
    }
  }

  Future<void> setUserIdentity(UserModel person) async {
    if (person != null) {
      analytics.setUserId(person.phoneNumber);

      String _name = "${person.firstName} ${person.lastName}";

      analytics.setUserProperty(name: 'name', value: _name);
      analytics.setUserProperty(
        name: 'phone_number',
        value: person?.phoneNumber ?? '',
      );
      analytics.setUserProperty(name: 'email', value: person?.email ?? '');
    }
  }
}