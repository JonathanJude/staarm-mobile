import 'dart:developer';

import 'package:staarm_mobile/core/models/booking_trip_model.dart';
import 'package:staarm_mobile/core/models/vehicle/vehicle_model.dart';

class NotificationModel {
  NotificationModel({
    this.tripRequests,
    this.otherNotifications,
  }) {
    tripRequests.removeWhere((element) => element.data.protectionPlan == null);
  }

  List<TripRequestNotification> tripRequests;
  List<OtherNotification> otherNotifications;

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel(
        tripRequests: List<TripRequestNotification>.from(
          json["trip_requests"].map(
            (x) => TripRequestNotification.fromJson(x),
          ),
        ),
        otherNotifications: List<OtherNotification>.from(
          json["other_notifications"].map(
            (x) => OtherNotification.fromJson(x),
          ),
        ),
      );

  Map<String, dynamic> toJson() => {
        "trip_requests":
            List<dynamic>.from(tripRequests.map((x) => x.toJson())),
        "other_notifications":
            List<dynamic>.from(otherNotifications.map((x) => x.toJson())),
      };

  bool get isEmpty => tripRequests.isEmpty && otherNotifications.isEmpty;
}

class OtherNotification {
  OtherNotification({
    this.id,
    this.data,
    this.date,
  });

  String id;
  OtherNotificationData data;
  DateTime date;

  factory OtherNotification.fromJson(Map<String, dynamic> json) =>
      OtherNotification(
        id: json["id"],
        data: OtherNotificationData.fromJson(json["data"]),
        date: DateTime.parse(json["date"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "data": data.toJson(),
        "date": date.toIso8601String(),
      };
}

class OtherNotificationData {
  OtherNotificationData({
    this.tripId,
    this.title,
    this.message,
  });

  String tripId;
  String title;
  String message;

  factory OtherNotificationData.fromJson(Map<String, dynamic> json) =>
      OtherNotificationData(
        tripId: json["trip_id"],
        title: json["title"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "trip_id": tripId,
        "title": title,
        "message": message,
      };
}

class TripRequestNotification {
  TripRequestNotification({
    this.id,
    this.data,
    this.date,
  });

  String id;
  TripRequestData data;
  DateTime date;

  factory TripRequestNotification.fromJson(Map<String, dynamic> json) {
    log("heyy $json");
    return TripRequestNotification(
      id: json["id"],
      data:
          TripRequestData.fromJson(json["data"], DateTime.parse(json["date"])),
      date: DateTime.parse(json["date"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "data": data.toJson(),
        "date": date.toIso8601String(),
      };
}

class TripRequestData {
  TripRequestData({
    this.price,
    this.tripId,
    this.title,
    this.message,
    this.customer,
    this.endDate,
    this.startDate,
    this.tripDuration,
    this.pickUpLocation,
    this.date,
    this.protectionPlan,
    this.vehicleModel,
  });

  String price;
  String tripId;
  String title;
  String message;
  String customer;
  DateTime endDate;
  DateTime date;
  DateTime startDate;
  String tripDuration;
  String pickUpLocation;
  ProtectionPlan protectionPlan;
  VehicleModel vehicleModel;

  factory TripRequestData.fromJson(Map<String, dynamic> json, DateTime date) {
    return TripRequestData(
      price: json["price"],
      tripId: json["trip_id"],
      title: json["title"],
      message: json["message"],
      customer: json["customer"],
      endDate: DateTime.parse(json["end_date"]),
      startDate: DateTime.parse(json["start_date"]),
      tripDuration: json["trip_duration"],
      pickUpLocation: json["pick_up_location"],
      date: date,
      protectionPlan: json['protection_plan'] == null ? null :  ProtectionPlan.fromJson(Map.from(json['protection_plan'])),
      vehicleModel: json['vehicle'] == null ? null : VehicleModel.fromJson(Map.from(json['vehicle'])),
    );
  }

  Map<String, dynamic> toJson() => {
        "price": price,
        "trip_id": tripId,
        "title": title,
        "message": message,
        "customer": customer,
        "end_date": endDate.toIso8601String(),
        "start_date": startDate.toIso8601String(),
        "trip_duration": tripDuration,
        "pick_up_location": pickUpLocation,
      };

  TripModel toTripModel() {
    print(protectionPlan.id);
    return TripModel(
      id: int.parse(tripId),
      date: date,
      status: 'Pending',
      startDate: startDate,
      endDate: endDate,
      vehicle: vehicleModel,
      protectionPlan: protectionPlan,
    );
  }
}
