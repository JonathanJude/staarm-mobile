class HostDraftVehicleModel {
  String draftId;
  String carYear;
  String carMake;
  String carModel;
  int currentDraftStage;
  String odometer;
  String transmission;
  String vehicleType;
  String marketValue;
  String licenceState;
  String licenceNumber;
  String pickUpLocation;
  String dropOffLocation;
  double pickUpLatitude;
  double pickUpLongitude;
  int dailyPriceInKobo;
  String get fullName => "$carMake $carModel $carYear";

  HostDraftVehicleModel({
    this.draftId,
    this.carYear,
    this.carMake,
    this.carModel,
    this.currentDraftStage,
    this.odometer,
    this.transmission,
    this.vehicleType,
    this.marketValue,
    this.licenceState,
    this.licenceNumber,
    this.pickUpLocation,
    this.dropOffLocation,
    this.pickUpLatitude,
    this.pickUpLongitude,
    this.dailyPriceInKobo,
  });

  factory HostDraftVehicleModel.fromJson(Map<String, dynamic> json) => new HostDraftVehicleModel(
    draftId: json["draft_id"] ?? '',
    carYear: json["car_year"],
    carMake: json["car_make"],
    carModel: json["car_model"],
    currentDraftStage: json["current_draft_stage"],
    odometer: json["odometer"],
    transmission: json["transmission"],
    vehicleType: json["vehicle_type"],
    marketValue: json["market_value"],
    licenceState: json["licence_state"],
    licenceNumber: json["licence_number"],
    pickUpLocation: json["pick_up_location"],
    dropOffLocation: json["drop_off_location"],
    pickUpLatitude: json["pick_up_latitude"],
    pickUpLongitude: json["pick_up_longitude"],
    dailyPriceInKobo: json["daily_price_in_kobo"],
  );

  Map<String, dynamic> toJson() => {
    "draft_id": draftId,
    "car_year": carYear,
    "car_make": carMake,
    "car_model": carModel,
    "current_draft_stage": currentDraftStage,
    "odometer": odometer,
    "transmission": transmission,
    "vehicle_type": vehicleType,
    "market_value": marketValue,
    "licence_state": licenceState,
    "licence_number": licenceNumber,
    "pick_up_location": pickUpLocation,
    "drop_off_location": dropOffLocation,
    "pick_up_latitude": pickUpLatitude,
    "pick_up_longitude": pickUpLongitude,
    "daily_price_in_kobo": dailyPriceInKobo,
  };
}
