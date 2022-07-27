
import 'package:flutter/material.dart';
import 'package:staarm_mobile/core/api/service_state.dart';
import 'package:staarm_mobile/core/endpoints/endpoints.dart';
import 'package:staarm_mobile/core/services/http_helper.dart/http_helper.dart';
import 'package:staarm_mobile/core/services/notification_service/notification_service.dart';

import '../../../main.dart';

class NotificationServiceImpl extends NotificationService {
  final HttpHelper httpHelper;

  NotificationServiceImpl({@required this.httpHelper});

  @override
  Future<void> sendDeviceToken(String token) async {
    try {
      Map<String, dynamic> _data = {
        "device_token": token,
      };
      final jsonData = await httpHelper.post(
        Endpoints.deviceTokens,
        body: _data,
      );
      print("json data: $jsonData");
      // print("json data: ${jsonData.value}");
      if (jsonData is SuccessState) {
        prefs.setBool("hasSentToken", true);
      }
    } on Exception catch (e) {
      print(e);
    }
  }
}
