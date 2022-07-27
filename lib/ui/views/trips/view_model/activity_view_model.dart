import 'package:staarm_mobile/app/locator.dart';
import 'package:staarm_mobile/core/models/notifications/notification_model.dart';
import 'package:staarm_mobile/core/services/in_app_notification/in_app_notification_service.dart';
import 'package:staarm_mobile/ui/base/base_view_model.dart';

class ActivityViewModel extends BaseViewModel {
  final _notificationService = locator<InAppNotificationService>();

  NotificationModel _model;
  NotificationModel get notificationModel => _model;
  set notificationModel(NotificationModel val) {
    _model = val;
    notifyListeners();
  }

  Future<void> _getNotification() async {
    NotificationModel res = await _notificationService.getNotifications();
    if (res != null) {
      notificationModel = res;
    }
    notifyListeners();
  }

  void init() async {
    isLoading = true;
    await _getNotification();
    isLoading = false;
  }

  void silentReload(){
    _getNotification();
  }
}
