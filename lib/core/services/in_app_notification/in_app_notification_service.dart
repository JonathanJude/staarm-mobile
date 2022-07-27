import 'package:staarm_mobile/core/models/notifications/notification_model.dart';

abstract class InAppNotificationService{
  Future<NotificationModel> getNotifications();
}