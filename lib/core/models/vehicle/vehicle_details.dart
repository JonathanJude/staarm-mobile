class VehicleDetails {
  String make;
  String model;
  String year;
  String type;
  String transmission;
  String odometer;
  String marketValue;
  String get fullName => "$make $model $year";

  VehicleDetails({
    this.make,
    this.model,
    this.year,
    this.type,
    this.transmission,
    this.odometer,
    this.marketValue,
  });

  factory VehicleDetails.fromJson(Map<String, dynamic> json) => new VehicleDetails(
    make: json["make"].toString(),
    model: json["model"].toString(),
    year: json["year"].toString(),
    type: json["type"].toString(),
    transmission: json["transmission"].toString(),
    odometer: json["odometer"].toString(),
    marketValue: json["market_value"].toString(),
  );

  Map<String, dynamic> toJson() => {
    "make": make,
    "model": model,
    "year": year,
    "type": type,
    "transmission": transmission,
    "odometer": odometer,
    "market_value": marketValue,
  };
}