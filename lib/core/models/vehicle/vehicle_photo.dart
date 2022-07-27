class VehiclePhoto {
  int id;
  String url;
  bool cover;

  VehiclePhoto({
    this.id,
    this.url,
    this.cover,
  });

  factory VehiclePhoto.fromJson(Map<String, dynamic> json) => new VehiclePhoto(
    id: json["id"],
    url: json["url"],
    cover: json["cover"] ?? false,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "url": url,
    "cover": cover,
  };
}