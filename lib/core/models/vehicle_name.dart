class VehicleName {
  String year;
  String model;
  String brand;

  VehicleName({
    this.year,
    this.model,
    this.brand,
  });

  factory VehicleName.fromJson(Map<String, dynamic> json) => new VehicleName(
    year: json["year"],
    model: json["model"],
    brand: json["brand"],
  );

  Map<String, dynamic> toJson() => {
    "year": year,
    "model": model,
    "brand": brand,
  };
}