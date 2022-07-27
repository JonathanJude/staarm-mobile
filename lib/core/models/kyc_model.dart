class KYCModel {
  String nin;
  String driversLicence;

  KYCModel({
    this.nin,
    this.driversLicence,
  });

  factory KYCModel.fromJson(Map<String, dynamic> json) => new KYCModel(
        nin: json["nin"],
        driversLicence: json["drivers_licence"],
      );

  Map<String, dynamic> toJson() => {
        "nin": nin,
        "drivers_licence": driversLicence,
      };
}
