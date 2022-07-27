import 'package:staarm_mobile/core/models/user.dart';

abstract class CrashlyticsService {
  Future init();

  void reportError(dynamic error, {dynamic stackTrace});

  void setUser(UserModel user);

}
