import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:staarm_mobile/core/models/user.dart';

abstract class SentryService {
  Future init(AppRunner appRunner, String dsn) async {}

  void reportError(dynamic error, {dynamic stackTrace}) {}

  void setUser(UserModel user){}

}
