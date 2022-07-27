class VehicleInfoModel {
  List<int> years;
  List<String> types;
  List<String> odometers;
  List<VehicleMake> vehicleMakes;
  List<String> transmissions;
  List<String> marketValues;

  VehicleInfoModel({
    this.years,
    this.types,
    this.odometers,
    this.vehicleMakes,
    this.transmissions,
    this.marketValues,
  });

  factory VehicleInfoModel.fromJson(Map<String, dynamic> json) => new VehicleInfoModel(
    years: new List<int>.from(json["years"].map((x) => x)),
    types: new List<String>.from(json["types"].map((x) => x)),
    odometers: new List<String>.from(json["odometers"].map((x) => x)),
    vehicleMakes: new List<VehicleMake>.from(json["vehicle_makes"].map((x) => VehicleMake.fromJson(x))),
    transmissions: new List<String>.from(json["transmissions"].map((x) => x)),
    marketValues: new List<String>.from(json["market_values"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "years": new List<dynamic>.from(years.map((x) => x)),
    "types": new List<dynamic>.from(types.map((x) => x)),
    "odometers": new List<dynamic>.from(odometers.map((x) => x)),
    "vehicle_makes": new List<dynamic>.from(vehicleMakes.map((x) => x.toJson())),
    "transmissions": new List<dynamic>.from(transmissions.map((x) => x)),
    "market_values": new List<dynamic>.from(marketValues.map((x) => x)),
  };
}

class VehicleMake {
  String make;
  List<String> models;

  VehicleMake({
    this.make,
    this.models,
  });

  factory VehicleMake.fromJson(Map<String, dynamic> json) => new VehicleMake(
    make: json["make"],
    models: new List<String>.from(json["models"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "make": make,
    "models": new List<dynamic>.from(models.map((x) => x)),
  };
}
