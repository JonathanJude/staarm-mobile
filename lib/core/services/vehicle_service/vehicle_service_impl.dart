import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:staarm_mobile/core/api/service_state.dart';
import 'package:staarm_mobile/core/endpoints/endpoints.dart';
import 'package:staarm_mobile/core/exceptions/unknown_exception.dart';
import 'package:staarm_mobile/core/models/hosts_vehicle_model.dart';
import 'package:staarm_mobile/core/models/vehicle/vehicle_info_model.dart';
import 'package:staarm_mobile/core/models/vehicle/vehicle_model.dart';
import 'package:staarm_mobile/core/services/http_helper.dart/http_helper.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

import 'vehicle_service.dart';

class VehicleServiceImpl extends VehicleService {
  HttpHelper httpHelper;
  VehicleServiceImpl({@required this.httpHelper}) : assert(httpHelper != null);

  final _log = Logger('VehicleServiceImpl');

  @override
  Future<VehicleInfoModel> getVehicleData() async {
    try {
      final jsonData = await httpHelper.get(
        Endpoints.vehicleDataList,
      );

      _log.fine(jsonData.toString());

      if (jsonData is SuccessState) {
        final mapResponse = jsonData.value;
        print(mapResponse);
        List<VehicleInfoModel> _dataList = [];

        if (mapResponse['data'] != null) {
          return VehicleInfoModel.fromJson(mapResponse['data']);
        }

        return null;
      } else {
        return null;
      }
    } on Exception {
      _log.severe('Error occured');
      throw const UnknownException();
    }
  }

  @override
  Future<dynamic> startVehicleHosting({
    @required String carMake,
    @required String carModel,
    @required String carYear,
  }) async {
    try {
      Map<String, dynamic> _data = {
        'car_make': carMake,
        'car_model': carModel,
        'car_year': carYear,
      };

      final jsonData = await httpHelper.post(
        Endpoints.startVehicleHosting,
        body: _data,
      );

      _log.fine(jsonData.toString());
      print(jsonData.toString());

      return jsonData;
    } on Exception {
      _log.severe('Error occured');
      throw const UnknownException();
    }
  }

  @override
  Future<dynamic> updateVehicleDetails({
    @required String odometer,
    @required String transmission,
    @required String vehicleType,
    @required String marketValue,
    @required String licenceState,
    @required String licenceNumber,
    @required String draftId,
  }) async {
    try {
      Map<String, dynamic> _data = {
        'odometer': odometer,
        'transmission': transmission,
        'vehicle_type': vehicleType,
        'market_value': marketValue,
        'licence_state': licenceState,
        'licence_number': licenceNumber,
      };

      final jsonData = await httpHelper.put(
        Endpoints.updateVehicleDetails(draftVehicleId: draftId),
        body: _data,
      );

      _log.fine(jsonData.toString());
      print(jsonData.toString());

      return jsonData;
    } on Exception {
      _log.severe('Error occured');
      throw const UnknownException();
    }
  }

  @override
  Future<dynamic> updateVehiclePickUpAndDropOff({
    @required String pickupLocation,
    @required String dropOffLocation,
    @required num pickupLatitude,
    @required num pickupLongitude,
    @required String draftId,
  }) async {
    try {
      Map<String, dynamic> _data = {
        'pick_up_location': pickupLocation,
        'drop_off_location': dropOffLocation,
        'pick_up_latitude': pickupLatitude,
        'pick_up_longitude': pickupLongitude,
      };

      final jsonData = await httpHelper.put(
        Endpoints.updateVehiclePickupAndDropoff(draftVehicleId: draftId),
        body: _data,
      );

      _log.fine(jsonData.toString());
      print(jsonData.toString());

      return jsonData;
    } on Exception {
      _log.severe('Error occured');
      throw const UnknownException();
    }
  }

  @override
  Future<dynamic> updateVehiclePricing({
    @required num dailyPrice,
    @required String draftId,
  }) async {
    try {
      Map<String, dynamic> _data = {
        'daily_price_in_kobo': dailyPrice,
      };

      final jsonData = await httpHelper.put(
        Endpoints.updateVehiclePricing(draftVehicleId: draftId),
        body: _data,
      );

      _log.fine(jsonData.toString());
      print(jsonData.toString());

      return jsonData;
    } on Exception {
      _log.severe('Error occured');
      throw const UnknownException();
    }
  }

  @override
  Future<dynamic> updateVehicleFeatures({
    @required List<String> features,
    @required String draftId,
  }) async {
    try {
      Map<String, dynamic> _data = {
        'features': features,
      };

      final jsonData = await httpHelper.put(
        Endpoints.updateVehicleFeatures(draftVehicleId: draftId),
        body: _data,
      );

      _log.fine(jsonData.toString());
      print(jsonData.toString());

      return jsonData;
    } on Exception {
      _log.severe('Error occured');
      throw const UnknownException();
    }
  }

  @override
  Future<dynamic> updateVehicleDescription({
    @required String description,
    @required String draftId,
  }) async {
    try {
      Map<String, dynamic> _data = {
        'description': description,
      };

      final jsonData = await httpHelper.put(
        Endpoints.updateVehicleDescription(draftVehicleId: draftId),
        body: _data,
      );

      _log.fine(jsonData.toString());
      print(jsonData.toString());

      return jsonData;
    } on Exception {
      _log.severe('Error occured');
      throw const UnknownException();
    }
  }

  @override
  Future<dynamic> updateVehiclePhotos({
    @required List<AssetEntity> vehiclePhotos,
    @required String draftId,
  }) async {
    if (vehiclePhotos.length > 0) {
      try {
        // List<MultipartFile> _multipartFiles =
        //     vehiclePhotos.map((e) => MultipartFile.fromFileSync(e.path)).toList();

        List<MultipartFile> _multipartFiles = [];

        for (var i = 0; i < vehiclePhotos.length; ++i) {
          final File originFile =
              await vehiclePhotos[i].originFile; // Original files.
          final String originPath = originFile.path;

          MultipartFile _muilpart = MultipartFile.fromFileSync(originPath);

          _multipartFiles.add(_muilpart);
        }

        //handle files
        dynamic _data = FormData.fromMap(
          {
            'vehicle_photos': _multipartFiles,
          },
          ListFormat.multiCompatible,
        );

        final jsonData = await httpHelper.post(
          Endpoints.updateVehiclePhotos(draftVehicleId: draftId),
          body: _data,
          useMultiPart: true,
        );

        _log.fine(jsonData.toString());
        print(jsonData.toString());

        return jsonData;
      } on Exception {
        _log.severe('Error occured');
        throw const UnknownException();
      }
    }
  }

  @override
  Future<dynamic> completeVehicleHosting({
    @required String draftId,
  }) async {
    try {
      Map<String, dynamic> _data = {
        'draft_vehicle_id': draftId,
      };

      final jsonData = await httpHelper.post(
        Endpoints.completeVehicleHosting,
        body: _data,
      );

      _log.fine(jsonData.toString());
      print(jsonData.toString());

      return jsonData;
    } on Exception {
      _log.severe('Error occured');
      throw const UnknownException();
    }
  }

  @override
  Future<List<VehicleModel>> searchVehicles({
    num lat,
    num lng,
  }) async {
    try {
      final jsonData = await httpHelper.post(Endpoints.searchVehicles, body: {
        "latitude": lat,
        "longitude": lng,
      });

      if (jsonData is SuccessState) {
        try {
          final mapResponse = jsonData.value;

          print("mapResponse: -- $mapResponse");

          List<VehicleModel> vehicleList = [];

          if (mapResponse['data']['vehicles'] == null) {
            vehicleList = [];
          } else {
            vehicleList =
                mapResponse['data']['vehicles'].map<VehicleModel>((json) {
              return VehicleModel.fromJson(json);
            }).toList();
          }

          return vehicleList;
        } catch (e) {
          print("Vehicle error  -=-- ${e.toString()}");
        }
      } else {
        return null;
      }
    } catch (e) {
      _log.severe('Error occured');
      throw const UnknownException();
    }
  }

  @override
  Future<List<VehicleModel>> favoriteVehicles() async {
    try {
      final jsonData = await httpHelper.get(
        Endpoints.favorites,
      );

      if (jsonData is SuccessState) {
        try {
          final mapResponse = jsonData.value;

          print("mapResponse: -- $mapResponse");

          List<VehicleModel> vehicleList = [];

          if (mapResponse['data']['favorites'] == null) {
            vehicleList = [];
          } else {
            vehicleList =
                mapResponse['data']['favorites'].map<VehicleModel>((json) {
              return VehicleModel.fromJson(json);
            }).toList();
          }

          return vehicleList;
        } catch (e) {
          print("Vehicle error  -=-- ${e.toString()}");
        }
      } else {
        return null;
      }
    } catch (e) {
      _log.severe('Error occured');
      throw const UnknownException();
    }
  }

  @override
  Future<List<VehicleModel>> getVehiclesByOwner({
    @required int ownerId,
  }) async {
    try {
      final jsonData = await httpHelper.get(
        Endpoints.vehiclesOfAUser(userId: ownerId),
      );

      if (jsonData is SuccessState) {
        try {
          final mapResponse = jsonData.value;

          print("mapResponse: -- $mapResponse");

          List<VehicleModel> vehicleList = [];

          if (mapResponse['data']['vehicles'] == null) {
            vehicleList = [];
          } else {
            vehicleList =
                mapResponse['data']['vehicles'].map<VehicleModel>((json) {
              return VehicleModel.fromJson(json);
            }).toList();
          }

          return vehicleList;
        } catch (e) {
          print("Vehicle error  -=-- ${e.toString()}");
        }
      } else {
        return null;
      }
    } catch (e) {
      _log.severe('Error occured');
      throw const UnknownException();
    }
  }

  @override
  Future<dynamic> addVehicleToFavorite({
    @required int vehicleId,
  }) async {
    try {
      Map<String, dynamic> _data = {
        'vehicle_id': vehicleId,
      };

      final jsonData = await httpHelper.post(
        Endpoints.favorites,
        body: _data,
      );

      _log.fine(jsonData.toString());
      print(jsonData.toString());

      return jsonData;
    } on Exception {
      _log.severe('Error occured');
      throw const UnknownException();
    }
  }

  @override
  Future<dynamic> deleteFavorite({
    @required int favoriteId,
  }) async {
    try {
      final jsonData = await httpHelper.delete(
        Endpoints.favoriteWIthId(favoriteId: favoriteId),
      );

      _log.fine(jsonData.toString());
      print(jsonData.toString());

      return jsonData;
    } on Exception {
      _log.severe('Error occured');
      throw const UnknownException();
    }
  }

@override
  Future<HostVehicleModel> getHostsVehicles() async {
    try {
      final jsonData = await httpHelper.get(
        Endpoints.getHostVehicles,
      );

      _log.fine(jsonData.toString());

      if (jsonData is SuccessState) {
        final mapResponse = jsonData.value;
        print(mapResponse);
        // List<HostVehicleModel> _dataList = [];

        if (mapResponse['data'] != null) {
          return HostVehicleModel.fromJson(mapResponse['data']);
        }

        return null;
      } else {
        return null;
      }
    } on Exception {
      _log.severe('Error occured');
      throw const UnknownException();
    }
  }
  
}
