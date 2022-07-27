class ProtectionPlanModel {
  int id;
  String name;
  int price;
  String summary;
  bool isDefault;

  ProtectionPlanModel({
    this.id,
    this.name,
    this.price,
    this.summary,
    this.isDefault = false,
  });

  factory ProtectionPlanModel.fromJson(Map<String, dynamic> json) => new ProtectionPlanModel(
    id: json["id"],
    name: json["name"],
    price: json["price"],
    summary: json["summary"],
    isDefault: json["default"] ?? false,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "price": price,
    "summary": summary,
    "default": isDefault,
  };
}
