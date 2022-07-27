import 'package:location/location.dart';

class AppLocationData {
  num latitude;
  num longitude;

  AppLocationData({
    this.latitude,
    this.longitude,
  });

  factory AppLocationData.fromJson(Map<String, dynamic> json) => new AppLocationData(
    latitude: json["latitude"],
    longitude: json["longitude"],
  );


  factory AppLocationData.fromLocationData(LocationData loc) => new AppLocationData(
    latitude: loc?.latitude ?? 0,
    longitude: loc?.longitude ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "latitude": latitude,
    "longitude": longitude,
  };
}
