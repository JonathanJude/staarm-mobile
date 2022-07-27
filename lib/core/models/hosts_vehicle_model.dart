import 'host_draft_vehicle.dart';
import 'vehicle/vehicle_model.dart';

class HostVehicleModel {
  List<VehicleModel> listedVehicles = [];
  List<HostDraftVehicleModel> draftVehicles = [];

  HostVehicleModel({
    this.listedVehicles,
    this.draftVehicles,
  });

  factory HostVehicleModel.fromJson(Map<String, dynamic> json) => new HostVehicleModel(
    listedVehicles: new List<VehicleModel>.from(json["listed_vehicles"].map((x) => VehicleModel.fromJson(x))),
    draftVehicles: new List<HostDraftVehicleModel>.from(json["draft_vehicles"].map((x) => HostDraftVehicleModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "listed_vehicles": new List<dynamic>.from(listedVehicles.map((x) => x.toJson())),
    "draft_vehicles": new List<dynamic>.from(draftVehicles.map((x) => x.toJson())),
  };
}