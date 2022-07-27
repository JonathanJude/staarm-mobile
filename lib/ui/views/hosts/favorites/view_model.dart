
import 'package:flutter/material.dart';
import 'package:staarm_mobile/app/locator.dart';
import 'package:staarm_mobile/core/models/vehicle/vehicle_model.dart';
import 'package:staarm_mobile/core/services/vehicle_service/vehicle_service.dart';
import 'package:staarm_mobile/ui/base/base_view_model.dart';

class FavoritesViewModel extends BaseViewModel {
  final _vehicleService = locator<VehicleService>();
  TextEditingController pricingTextController = TextEditingController();

  List<VehicleModel> _favoritesVehicles = [];
  List<VehicleModel> get favoritesVehicles => _favoritesVehicles;
  set favoritesVehicles(List<VehicleModel> val) {
    _favoritesVehicles = val;
    notifyListeners();
  }

  void init() {
    loadFavoriteVehicles();
  }

  void loadFavoriteVehicles() async {
    isLoading = true;
    dynamic res = await _vehicleService.favoriteVehicles();
    isLoading = false;

    if (res != null) {
        favoritesVehicles = res;
      }
  }
}