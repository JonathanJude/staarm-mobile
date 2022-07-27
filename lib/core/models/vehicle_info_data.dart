// class VehicleInfoData {
//   String make;
//   List<VehicleModelInfoData> models;

//   VehicleInfoData({
//     this.make,
//     this.models,
//   });

//   factory VehicleInfoData.fromJson(Map<String, dynamic> json) =>
//       new VehicleInfoData(
//         make: json["make"],
//         models: new List<VehicleModelInfoData>.from(
//           json["models"].map(
//             (x) => VehicleModelInfoData.fromJson(x),
//           ),
//         ),
//       );

//   Map<String, dynamic> toJson() => {
//         "make": make,
//         "models": new List<dynamic>.from(
//           models.map(
//             (x) => x.toJson(),
//           ),
//         ),
//       };
// }

// class VehicleModelInfoData {
//   String model;
//   List<String> types;

//   VehicleModelInfoData({
//     this.model,
//     this.types,
//   });

//   factory VehicleModelInfoData.fromJson(Map<String, dynamic> json) => new VehicleModelInfoData(
//         model: json["model"],
//         types: new List<String>.from(
//           json["types"].map((x) => x),
//         ),
//       );

//   Map<String, dynamic> toJson() => {
//         "model": model,
//         "types": new List<dynamic>.from(
//           types.map((x) => x),
//         ),
//       };
// }
