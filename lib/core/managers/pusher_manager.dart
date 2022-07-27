import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter_pusher/pusher.dart';

class PusherManager {
  static Pusher pusher;
  static Channel channel;
  static ConnectionStateChange connectionState;
  static String event;
  static void init() async {
    await Pusher.init(
      "1214101d47e6c35a569a",
      PusherOptions(cluster: "eu"),
      enableLogging: true,
    );
  }

  static void connect({
    ValueChanged<PusherConnectionState> onConnectionStateChange,
    ValueChanged<Map> onNewMessage,
    String tripId,
  }) {
    Pusher.connect(
      onConnectionStateChange: (x) async {
        connectionState = x;
        event = x.currentState;
        if (event == "CONNECTED") {
          log("I am connected");
          continue_(onNewMessage, tripId);
        }
      },
      onError: (x) {
        log(
          "Error: ${x.message}",
        );
      },
    );
  }

  static Future<void> continue_(
    ValueChanged<Map> onNewMessage,
    String tripId,
  ) async {
    _tripId = tripId;
    channel = await Pusher.subscribe("trips-messages-channel");
    channel.bind(
      "TripMessage-$tripId",
      (p0) {
        onNewMessage(p0.toJson());
        log(p0.toJson().toString());
        // event = p0.;
      },
    );
  }

  static String _tripId = "";

  static void disconnect() async {
    await channel.unbind("TripMessage-$_tripId");
    _tripId = "";
    await Pusher.unsubscribe("trips-messages-channel");
    await Pusher.disconnect();
  }
}
