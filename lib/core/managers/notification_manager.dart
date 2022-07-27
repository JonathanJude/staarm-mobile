import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class NotificationManager {
  static FirebaseMessaging messaging;
  static String _deviceToken;

  static void init({ValueChanged<String> onToken}) {
    print("FIREBASSEEEEEEEEEEE");
    messaging = FirebaseMessaging.instance;
    messaging.getToken().then((value) {
      print("DEVICE TOKEN: ${value}");
      _deviceToken = value;
      onToken(value);
    }).catchError((e){
      print(e);
    });
  }

  String get deviceToken => _deviceToken;
}
