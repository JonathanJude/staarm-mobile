import 'package:flutter/material.dart';
import 'package:staarm_mobile/app/locator.dart';
import 'package:staarm_mobile/core/services/notification_service/notification_service.dart';

class NotificationProvider extends ChangeNotifier {
  final service = locator<NotificationService>();

  void sendDeviceToken(String token) {
    service.sendDeviceToken(token);
  }
}
