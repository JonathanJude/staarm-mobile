class AddressModel {
  String name;
  num lng;
  num lat;

  AddressModel({
    this.name,
    this.lng,
    this.lat,
  });
}

class PlaceModel {
  String name;
  String placeId;

  PlaceModel({
    this.name,
    this.placeId,
  });
}