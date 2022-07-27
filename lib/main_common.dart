import 'dart:async';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intercom_flutter/intercom_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/locator.dart';
import 'core/api/config.dart';
import 'core/services/crashlytics_service/crashlytics_service.dart';
import 'core/services/sentry_service/sentry_service.dart';
import 'environment.dart';
import 'staarm_app.dart';

SharedPreferences prefs;
FirebaseAnalytics analytics;
FirebaseAnalyticsObserver observer;

Future<void> mainCommon(String environ) async {
  WidgetsFlutterBinding.ensureInitialized();

  // await ConfigReader.initialize();

  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();

    // cameras = await availableCameras();

    prefs = await SharedPreferences.getInstance();
    await DotEnv.load();

    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    await setUpLocator();

    //SET UP INTERCOM
    await Intercom.initialize(
      env['INTERCOM_APP_ID'],
      iosApiKey: env['INTERCOM_IOS_API_KEY'],
      androidApiKey: env['INTERCOM_ANDROID_API_KEY'],
    );

    //setup FirebaseAnalytics
    analytics = FirebaseAnalytics();
    observer = FirebaseAnalyticsObserver(analytics: analytics);

    if (environ == Environment.dev) {
      Config.isProd = false;
    } else {
      Config.isProd = true;
    }

    // get unhandled errors
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

     //initialize Sentry
    final sentryService = locator<SentryService>();
    sentryService.init(() => runApp(StaarmApp(
      isDebug: environ == Environment.dev,
    )), env['SENTRY_DSN']);
  }, (exception, stackTrace) async {
    final sentryService = locator<SentryService>();
    final crashlyticsService = locator<CrashlyticsService>();
    sentryService.reportError(exception, stackTrace: stackTrace);
    crashlyticsService.reportError(exception, stackTrace: stackTrace);
  });
}
