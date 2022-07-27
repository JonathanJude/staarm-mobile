import 'package:flutter/material.dart';
import 'package:staarm_mobile/core/models/hosts_vehicle_model.dart';
import 'package:staarm_mobile/core/models/vehicle/vehicle_info_model.dart';
import 'package:staarm_mobile/core/models/vehicle/vehicle_model.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

abstract class VehicleService {
  Future<VehicleInfoModel> getVehicleData();

  Future<dynamic> startVehicleHosting({
    @required String carMake,
    @required String carModel,
    @required String carYear,
  });

  Future<dynamic> updateVehicleDetails({
    @required String odometer,
    @required String transmission,
    @required String vehicleType,
    @required String marketValue,
    @required String licenceState,
    @required String licenceNumber,
    @required String draftId,
  });

  Future<dynamic> updateVehiclePickUpAndDropOff({
    @required String pickupLocation,
    @required String dropOffLocation,
    @required num pickupLatitude,
    @required num pickupLongitude,
    @required String draftId,
  });

  Future<dynamic> updateVehiclePricing({
    @required num dailyPrice,
    @required String draftId,
  });

  Future<dynamic> updateVehicleFeatures({
    @required List<String> features,
    @required String draftId,
  });

  Future<dynamic> updateVehicleDescription({
    @required String description,
    @required String draftId,
  });

  Future<dynamic> updateVehiclePhotos({
    @required List<AssetEntity> vehiclePhotos,
    @required String draftId,
  });

  Future<dynamic> completeVehicleHosting({
    @required String draftId,
  });

  Future<List<VehicleModel>> searchVehicles({
    num lat,
    num lng,
  });

  Future<List<VehicleModel>> favoriteVehicles();

  Future<List<VehicleModel>> getVehiclesByOwner({
    @required int ownerId,
  });

  Future<dynamic> addVehicleToFavorite({
    @required int vehicleId,
  });

  Future<dynamic> deleteFavorite({
    @required int favoriteId,
  });

  Future<HostVehicleModel> getHostsVehicles();
}
