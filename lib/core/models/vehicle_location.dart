class VehicleLocation {
  String state;
  String address;

  VehicleLocation({
    this.state,
    this.address,
  });

  factory VehicleLocation.fromJson(Map<String, dynamic> json) => new VehicleLocation(
    state: json["state"],
    address: json["address"],
  );

  Map<String, dynamic> toJson() => {
    "state": state,
    "address": address,
  };
}