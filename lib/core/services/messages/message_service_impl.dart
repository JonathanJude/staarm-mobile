import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:staarm_mobile/core/api/service_state.dart';
import 'package:staarm_mobile/core/endpoints/endpoints.dart';
import 'package:staarm_mobile/core/exceptions/unknown_exception.dart';
import 'package:staarm_mobile/core/models/booking_trip_model.dart';
import 'package:staarm_mobile/core/models/message/message_model.dart';
import 'package:staarm_mobile/core/services/http_helper.dart/http_helper.dart';

import 'message_service.dart';

class MessageServiceImpl extends MessageService {
  final HttpHelper httpHelper;

  MessageServiceImpl({@required this.httpHelper});
  final _log = Logger('MessageServiceImpl');

  @override
  Future<List<MessageModel>> getMessages({@required String tripId}) async {
    try {
      print(Endpoints.getMessages(tripId: tripId));
      final jsonData = await httpHelper.get(
        Endpoints.getMessages(tripId: tripId),
      );

      _log.fine(jsonData.toString());

      if (jsonData is SuccessState) {
        final mapResponse = jsonData.value["data"];
        return List.from(
          mapResponse.map(
            (e) => MessageModel.fromJson(Map.from(e)),
          ),
        );
      } else {
        return null;
      }
    } on Exception {
      _log.severe('Error occured at get bookings');
      throw const UnknownException();
    }
  }

  @override
  Future<void> sendMessage({String tripId, String message}) async {
    print(tripId);
    try {
      ServiceState jsonData = await httpHelper.post(
        Endpoints.sendMessage(tripId: tripId),
        body: {
          'comment': message,
        },
      );
      print("Send mesage");
      print(jsonData);
    } on Exception {
      _log.severe('Error occured at get sendning messages');
      throw const UnknownException();
    }
  }
}
