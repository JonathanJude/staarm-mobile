import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intercom_flutter/intercom_flutter.dart';
import 'package:mixpanel_flutter/mixpanel_flutter.dart';
import 'package:staarm_mobile/core/models/user.dart';


class MixPanelHelper {
  static MixPanelHelper _instance;

  Mixpanel _mixpanel;

  MixPanelHelper._internal() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {

      Mixpanel.init(env['MIXPANEL_TOKEN'], optOutTrackingDefault: false).then((mixpanel) {
        _mixpanel = mixpanel;
        debugPrint('MIXPANEL Instance created with success!');
      });
    });

    _instance = this;
  }

  factory MixPanelHelper() => _instance ?? MixPanelHelper._internal();

  void logEvent(
    String eventType, {
    Map<String, dynamic> eventProperties,
    bool outOfSession,
    bool logMixpanel = true,
    bool logFirebase = true,
    bool logIntercom = false,
  }) {
    bool isRelease = kReleaseMode;

    try {
      if (isRelease) {
        WidgetsBinding.instance.addPostFrameCallback((_) async {
          await Future.delayed(Duration(milliseconds: 200));
          print("MIX PANEL EVENT --- $eventType");
          if (logMixpanel) {
            _mixpanel.track(eventType, properties: eventProperties);
          }

          if(logIntercom){
            Intercom.logEvent(eventType, eventProperties ?? null);
          }
        });
      }
    } catch (e) {
      print("AppLogger -- error when logging event -- ${e.toString()}");
    }
  }

  void setUserIdentity(UserModel person) {
    if (person != null &&
        person?.phoneNumber != null &&
        person?.phoneNumber.isNotEmpty) {
      _mixpanel.identify(person?.phoneNumber ?? '');
    }
  }
}
