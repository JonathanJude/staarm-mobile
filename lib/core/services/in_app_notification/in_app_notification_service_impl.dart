import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:staarm_mobile/core/api/service_state.dart';
import 'package:staarm_mobile/core/endpoints/endpoints.dart';
import 'package:staarm_mobile/core/exceptions/unknown_exception.dart';
import 'package:staarm_mobile/core/models/notifications/notification_model.dart';
import 'package:staarm_mobile/core/services/http_helper.dart/http_helper.dart';

import 'in_app_notification_service.dart';

class InAppNotificationServiceImpl extends InAppNotificationService {
  final HttpHelper httpHelper;

  InAppNotificationServiceImpl({
    @required this.httpHelper,
  });

  final _log = Logger('InAppNotificationServiceImpl');

  @override
  Future<NotificationModel> getNotifications() async {
    try {
      final jsonData = await httpHelper.get(
        Endpoints.inAppNotifications,
      );

      _log.fine(jsonData.toString());

      if (jsonData is SuccessState) {
        final mapResponse = jsonData.value["data"];
        return NotificationModel.fromJson(Map.from(mapResponse));
      } else {
        return null;
      }
    } on Exception {
      _log.severe('Error occured at get bookings');
      throw const UnknownException();
    }
  }
}
