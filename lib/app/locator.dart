import 'package:get_it/get_it.dart';
import 'package:staarm_mobile/core/services/address_service/address_service.dart';
import 'package:staarm_mobile/core/services/address_service/address_service_impl.dart';
import 'package:staarm_mobile/core/services/auth_service/auth_service.dart';
import 'package:staarm_mobile/core/services/auth_service/auth_service_impl.dart';
import 'package:staarm_mobile/core/services/crashlytics_service/crashlytics_service.dart';
import 'package:staarm_mobile/core/services/crashlytics_service/crashlytics_service_impl.dart';
import 'package:staarm_mobile/core/services/google_service/google_service.dart';
import 'package:staarm_mobile/core/services/google_service/google_service_impl.dart';
import 'package:staarm_mobile/core/services/in_app_notification/in_app_notification_service.dart';
import 'package:staarm_mobile/core/services/in_app_notification/in_app_notification_service_impl.dart';
import 'package:staarm_mobile/core/services/kyc_service/kyc_service.dart';
import 'package:staarm_mobile/core/services/kyc_service/kyc_service_impl.dart';
import 'package:staarm_mobile/core/services/messages/message_service.dart';
import 'package:staarm_mobile/core/services/messages/message_service_impl.dart';
import 'package:staarm_mobile/core/services/notification_service/notification_service.dart';
import 'package:staarm_mobile/core/services/notification_service/notification_service_impl.dart';
import 'package:staarm_mobile/core/services/payment_service/payment_service.dart';
import 'package:staarm_mobile/core/services/payment_service/payment_service_impl.dart';
import 'package:staarm_mobile/core/services/sentry_service/sentry_service.dart';
import 'package:staarm_mobile/core/services/sentry_service/sentry_service_impl.dart';
import 'package:staarm_mobile/core/services/trips_service/trips_service.dart';
import 'package:staarm_mobile/core/services/trips_service/trips_service_impl.dart';
import 'package:staarm_mobile/core/services/user_cache_service/user_cache_service.dart';
import 'package:staarm_mobile/core/services/user_cache_service/user_cache_service_impl.dart';
import 'package:staarm_mobile/core/services/vehicle_service/vehicle_service.dart';
import 'package:staarm_mobile/core/services/vehicle_service/vehicle_service_impl.dart';

import '../core/services/http_helper.dart/http_helper.dart';
import '../core/services/navigator_service.dart';

GetIt locator = GetIt.instance;

Future<void> setUpLocator() async {
  /////////////////////////////////////////
  ///Network Services
  ////////////////////////////////////////
  locator.registerFactory(() => HttpHelper());
  // locator.registerLazySingleton<ApiService>(() => ApiServiceImpl());
  locator.registerLazySingleton<AuthService>(
      () => AuthServiceImpl(httpHelper: locator.get()));

  locator.registerLazySingleton<VehicleService>(
      () => VehicleServiceImpl(httpHelper: locator.get()));

  locator.registerLazySingleton<GoogleService>(
      () => GoogleServiceImpl(httpHelper: locator.get()));

  locator.registerLazySingleton<KYCService>(
      () => KYCServiceImpl(httpHelper: locator.get()));

  locator.registerLazySingleton<MessageService>(
      () => MessageServiceImpl(httpHelper: locator.get()));

  locator.registerLazySingleton<AddressService>(
      () => AddressServiceImpl(httpHelper: locator.get()));
  locator.registerLazySingleton<PaymentService>(
      () => PaymentServiceImpl(httpHelper: locator.get()));
  locator.registerLazySingleton<TripsService>(
      () => TripsServiceImpl(httpHelper: locator.get()));
  locator.registerLazySingleton<NotificationService>(
      () => NotificationServiceImpl(httpHelper: locator.get()));

  locator.registerLazySingleton<InAppNotificationService>(
      () => InAppNotificationServiceImpl(httpHelper: locator.get()));

  /////////////////////////////////////////
  ///Third Party Services
  ////////////////////////////////////////
  locator.registerLazySingleton<NavigationService>(() => NavigationService());
  locator.registerLazySingleton<UserCacheService>(() => UserCacheServiceImpl());
  // locator.registerLazySingleton<LocationService>(
  //     () => LocationServiceImpl(httpHelper: locator.get()));

  locator.registerLazySingleton<SentryService>(() => SentryServiceImpl());
  locator.registerLazySingleton<CrashlyticsService>(
      () => CrashlyticsServiceImpl());

  /////////////////////////////////////////
  ///Platform Services
  ////////////////////////////////////////
  // await _setupSharedPreferences();
  // await _setupSecuredStorage();
}

// Future<void> _setupSharedPreferences() async {
//   final instance = await StorageServiceImpl.getInstance();
//   locator.registerLazySingleton<StorageService>(() => instance);
// }

// Future<void> _setupSecuredStorage() async {
//   final instance = await SecureStorageServiceImpl.getInstance();
//   locator.registerLazySingleton<SecureStorageService>(() => instance);
// }
