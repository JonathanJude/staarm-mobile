
import 'package:flutter/material.dart';
import 'package:staarm_mobile/app/locator.dart';
import 'package:staarm_mobile/core/models/vehicle/vehicle_model.dart';
import 'package:staarm_mobile/core/services/vehicle_service/vehicle_service.dart';
import 'package:staarm_mobile/ui/base/base_view_model.dart';

class CarOwnerProfileViewModel extends BaseViewModel {
  final _vehicleService = locator<VehicleService>();
  TextEditingController pricingTextController = TextEditingController();

  List<VehicleModel> _ownerVehicles = [];
  List<VehicleModel> get ownerVehicles => _ownerVehicles;
  set ownerVehicles(List<VehicleModel> val) {
    _ownerVehicles = val;
    notifyListeners();
  }

  

  void init(int ownerId) async {
    loadOwnerVehicles(ownerId);
  }

  void loadOwnerVehicles(int ownerId) async {
      isLoading = true;
      dynamic res = await _vehicleService.getVehiclesByOwner(
        ownerId: ownerId,
      );
      isLoading = false;

      if (res != null) {
        ownerVehicles = res;
      }
  }
}