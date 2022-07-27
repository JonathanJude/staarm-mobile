import 'package:staarm_mobile/core/models/booking_trip_model.dart';

abstract class MessageService {
  Future<List> getMessages({String tripId});

  Future<void> sendMessage({String tripId, String message});
}
