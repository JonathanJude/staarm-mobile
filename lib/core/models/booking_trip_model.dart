// To parse this JSON data, do
//
//     final bookingTripModel = bookingTripModelFromJson(jsonString);



import 'vehicle/vehicle_model.dart';

class TripModel {
  TripModel({
    this.id,
    this.date,
    this.status,
    this.endDate,
    this.startDate,
    this.vehicle,
    this.protectionPlan,
  });

  int id;
  DateTime date;
  String status;
  DateTime endDate;
  DateTime startDate;
  VehicleModel vehicle;
  ProtectionPlan protectionPlan;

  factory TripModel.fromJson(Map<String, dynamic> json) =>
      TripModel(
        id: json["id"],
        date: DateTime.parse(json["date"]),
        status: json["status"],
        endDate: DateTime.parse(json["end_date"]),
        startDate: DateTime.parse(json["start_date"]),
        vehicle: VehicleModel.fromJson(json["vehicle"]),
        protectionPlan: ProtectionPlan.fromJson(json["protection_plan"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "date": date.toIso8601String(),
        "status": status,
        "end_date": endDate.toIso8601String(),
        "start_date": startDate.toIso8601String(),
        "vehicle": vehicle.toJson(),
        "protection_plan": protectionPlan.toJson(),
      };
}

class ProtectionPlan {
  ProtectionPlan({
    this.id,
    this.name,
    this.price,
    this.summary,
    this.protectionPlanDefault,
  });

  int id;
  String name;
  int price;
  String summary;
  bool protectionPlanDefault;

  factory ProtectionPlan.fromJson(Map<String, dynamic> json) => ProtectionPlan(
        id: json["id"],
        name: json["name"],
        price: json["price"],
        summary: json["summary"],
        protectionPlanDefault: json["default"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "summary": summary,
        "default": protectionPlanDefault,
      };
}

// class Vehicle {
//   Vehicle({
//     this.id,
//     this.price,
//     this.details,
//     this.pickUp,
//     this.dropOff,
//     this.features,
//     this.avgRating,
//     this.totalTrips,
//     this.description,
//     this.licenceState,
//     this.licenceNumber,
//     this.vehiclePhotos,
//     this.vehicleOwner,
//   });

//   int id;
//   int price;
//   Details details;
//   String pickUp;
//   String dropOff;
//   List<String> features;
//   dynamic avgRating;
//   int totalTrips;
//   String description;
//   String licenceState;
//   String licenceNumber;
//   List<VehiclePhoto> vehiclePhotos;
//   VehicleOwner vehicleOwner;

//   factory Vehicle.fromJson(Map<String, dynamic> json) => Vehicle(
//         id: json["id"],
//         price: json["price"],
//         details: Details.fromJson(json["details"]),
//         pickUp: json["pick_up"],
//         dropOff: json["drop_off"],
//         features: List<String>.from(json["features"].map((x) => x)),
//         avgRating: json["avg_rating"],
//         totalTrips: json["total_trips"],
//         description: json["description"],
//         licenceState: json["licence_state"],
//         licenceNumber: json["licence_number"],
//         vehiclePhotos: List<VehiclePhoto>.from(
//             json["vehicle_photos"].map((x) => VehiclePhoto.fromJson(x))),
//         vehicleOwner: VehicleOwner.fromJson(json["vehicle_owner"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "price": price,
//         "details": details.toJson(),
//         "pick_up": pickUp,
//         "drop_off": dropOff,
//         "features": List<dynamic>.from(features.map((x) => x)),
//         "avg_rating": avgRating,
//         "total_trips": totalTrips,
//         "description": description,
//         "licence_state": licenceState,
//         "licence_number": licenceNumber,
//         "vehicle_photos":
//             List<dynamic>.from(vehiclePhotos.map((x) => x.toJson())),
//         "vehicle_owner": vehicleOwner.toJson(),
//       };
// }

// class Details {
//   Details({
//     this.make,
//     this.model,
//     this.year,
//     this.type,
//     this.transmission,
//     this.odometer,
//     this.marketValue,
//   });

//   String get fullName => "$make $model $year";

//   String make;
//   String model;
//   String year;
//   String type;
//   String transmission;
//   String odometer;
//   String marketValue;

//   factory Details.fromJson(Map<String, dynamic> json) => Details(
//         make: json["make"],
//         model: json["model"],
//         year: json["year"],
//         type: json["type"],
//         transmission: json["transmission"],
//         odometer: json["odometer"],
//         marketValue: json["market_value"],
//       );

//   Map<String, dynamic> toJson() => {
//         "make": make,
//         "model": model,
//         "year": year,
//         "type": type,
//         "transmission": transmission,
//         "odometer": odometer,
//         "market_value": marketValue,
//       };
// }

// class VehicleOwner {
//   VehicleOwner({
//     this.dob,
//     this.email,
//     this.about,
//     this.approved,
//     this.lastName,
//     this.firstName,
//     this.profilePic,
//   });

//   dynamic dob;
//   String email;
//   String about;
//   bool approved;
//   String lastName;
//   String firstName;
//   String profilePic;

//   factory VehicleOwner.fromJson(Map<String, dynamic> json) => VehicleOwner(
//         dob: json["dob"],
//         email: json["email"],
//         about: json["about"],
//         approved: json["approved"],
//         lastName: json["last_name"],
//         firstName: json["first_name"],
//         profilePic: json["profile_pic"],
//       );

//   Map<String, dynamic> toJson() => {
//         "dob": dob,
//         "email": email,
//         "about": about,
//         "approved": approved,
//         "last_name": lastName,
//         "first_name": firstName,
//         "profile_pic": profilePic,
//       };
// }

// class VehiclePhoto {
//   VehiclePhoto({
//     this.id,
//     this.url,
//     this.cover,
//   });

//   int id;
//   String url;
//   bool cover;

//   factory VehiclePhoto.fromJson(Map<String, dynamic> json) => VehiclePhoto(
//         id: json["id"],
//         url: json["url"],
//         cover: json["cover"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "url": url,
//         "cover": cover,
//       };
// }
