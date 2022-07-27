import 'vehicle_details.dart';
import 'vehicle_owner.dart';
import 'vehicle_photo.dart';

class VehicleModel {
  int id;
  num price;
  VehicleDetails details;
  String pickUp;
  String dropOff;
  List<String> features;
  dynamic avgRating;
  String description;
  String licenceState;
  String licenceNumber;
  num totalTrips;
  List<VehiclePhoto> vehiclePhotos;
  VehicleOwner vehicleOwner;

  VehicleModel({
    this.id,
    this.price,
    this.details,
    this.pickUp,
    this.dropOff,
    this.features,
    this.avgRating,
    this.description,
    this.licenceState,
    this.licenceNumber,
    this.totalTrips = 0,
    this.vehiclePhotos,
    this.vehicleOwner,
  });

  factory VehicleModel.fromJson(Map<String, dynamic> json) => new VehicleModel(
    id: json["id"],
    price: json["price"],
    details: VehicleDetails.fromJson(json["details"]),
    pickUp: json["pick_up"],
    dropOff: json["drop_off"],
    features: new List<String>.from(json["features"].map((x) => x)),
    avgRating: json["avg_rating"] ?? 0,
    description: json["description"],
    licenceState: json["licence_state"],
    licenceNumber: json["licence_number"],
    totalTrips: json["total_trips"],
    vehiclePhotos: new List<VehiclePhoto>.from(json["vehicle_photos"].map((x) => VehiclePhoto.fromJson(x))),
    vehicleOwner: VehicleOwner.fromJson(json["vehicle_owner"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "price": price,
    "details": details.toJson(),
    "pick_up": pickUp,
    "drop_off": dropOff,
    "features": new List<dynamic>.from(features.map((x) => x)),
    "avg_rating": avgRating,
    "description": description,
    "licence_state": licenceState,
    "licence_number": licenceNumber,
    "total_trips": totalTrips,
    "vehicle_photos": new List<dynamic>.from(vehiclePhotos.map((x) => x.toJson())),
    "vehicle_owner": vehicleOwner.toJson(),
  };
}