import 'package:flutter/material.dart';
import 'package:staarm_mobile/app/locator.dart';
import 'package:staarm_mobile/core/api/api_helpers.dart';
import 'package:staarm_mobile/core/models/hosts_vehicle_model.dart';
import 'package:staarm_mobile/core/models/protection_plan.dart';
import 'package:staarm_mobile/core/models/vehicle/vehicle_info_model.dart';
import 'package:staarm_mobile/core/models/vehicle/vehicle_model.dart';
import 'package:staarm_mobile/core/services/trips_service/trips_service.dart';
import 'package:staarm_mobile/core/services/vehicle_service/vehicle_service.dart';

class VehicleProvider extends ChangeNotifier {
  final _vehicleService = locator<VehicleService>();
  final _tripsService = locator<TripsService>();

  VehicleInfoModel _vehicleData;
  VehicleInfoModel get vehicleData => _vehicleData;
  set vehicleData(VehicleInfoModel val) {
    _vehicleData = val;
    notifyListeners();
  }

  List<VehicleModel> _favoriteVehicles = [];
  List<VehicleModel> get favoriteVehicles => _favoriteVehicles;
  set favoriteVehicles(List<VehicleModel> val) {
    _favoriteVehicles = val;
    notifyListeners();
  }

  List<ProtectionPlanModel> _protectionPlans = [];
  List<ProtectionPlanModel> get protectionPlans => _protectionPlans;
  set protectionPlans(List<ProtectionPlanModel> val) {
    _protectionPlans = val;
    notifyListeners();
  }

  HostVehicleModel _hostVehicles;
  HostVehicleModel get hostVehicles => _hostVehicles;
  set hostVehicles(HostVehicleModel val) {
    _hostVehicles = val;
    notifyListeners();
  }

  bool get isHostVehicleAvailable {
    if(hostVehicles == null) return false;
    if(hostVehicles.listedVehicles != null && hostVehicles.listedVehicles.length > 0) return true;
    if(hostVehicles.draftVehicles != null && hostVehicles.draftVehicles.length > 0) return true;
    return false;
  }

   bool get isHostDraftVehicleAvailable {
    if(hostVehicles == null) return false;
    if(hostVehicles.draftVehicles != null && hostVehicles.draftVehicles.length > 0) return true;
    return false;
  }

  bool get isHostListedVehicleAvailable {
    if(hostVehicles == null) return false;
    if(hostVehicles.listedVehicles != null && hostVehicles.listedVehicles.length > 0) return true;
    return false;
  }

  bool _isSyncingFavorites = false;
  bool get isSyncingFavorites => _isSyncingFavorites;
  set isSyncingFavorites(bool val) {
    _isSyncingFavorites = val;
    notifyListeners();
  }

  bool _isSyncingProtectionPlan = false;
  bool get isSyncingProtectionPlan => _isSyncingProtectionPlan;
  set isSyncingProtectionPlan(bool val) {
    _isSyncingProtectionPlan = val;
    notifyListeners();
  }

  bool _isSyncingHostsVehicles = false;
  bool get isSyncingHostsVehicles => _isSyncingHostsVehicles;
  set isSyncingHostsVehicles(bool val) {
    _isSyncingHostsVehicles = val;
    notifyListeners();
  }

  bool _isTogglingFavorites = false;
  bool get isTogglingFavorites => _isTogglingFavorites;
  set isTogglingFavorites(bool val) {
    _isTogglingFavorites = val;
    notifyListeners();
  }

  Future<void> syncVehicleData(BuildContext context) async {
    dynamic res = await _vehicleService.getVehicleData();

    if (res != null) {
      vehicleData = res;
    }

    notifyListeners();
  }

  Future<void> syncFavorites() async {
    isSyncingFavorites = true;
    dynamic res = await _vehicleService.favoriteVehicles();
    isSyncingFavorites = false;

    if (res != null) {
      favoriteVehicles = res;
    }
    notifyListeners();
  }

  Future<void> syncHostsVehicles() async {
    isSyncingHostsVehicles = true;
    dynamic res = await _vehicleService.getHostsVehicles();
    isSyncingHostsVehicles = false;

    if (res != null) {
      hostVehicles = res;
    }
    notifyListeners();
  }

  Future<void> syncProtectionPlans() async {
    isSyncingProtectionPlan = true;
    dynamic res = await _tripsService.getProtectionPlans();
    isSyncingProtectionPlan = false;

    if (res != null) {
      protectionPlans = res;
    }
    notifyListeners();
  }

  void toggleFavorite(VehicleModel fav, [int favId]) async {
    var check = favoriteVehicles.firstWhere(
      (e) => e.id == fav.id,
      orElse: () => null,
    );

    if (check != null) {
      //it exists
      favoriteVehicles.add(fav);
      await addFavorite(fav);
    } else {
      //doesn't exists
      favoriteVehicles.remove(fav);
      await removeFavorite(favId);
    }

    notifyListeners();
  }

  bool isFavorited(VehicleModel vehicle){
    return favoriteVehicles.contains(vehicle);
  }

  //add favorite
  Future<void> addFavorite(VehicleModel fav) async {
    isTogglingFavorites = true;
    dynamic res = await _vehicleService.addVehicleToFavorite(vehicleId: fav.id);
    isTogglingFavorites = false;

    APIHelpers.handleResponse(res, onSuccess: (response) async {
      this.syncFavorites();
    });
  }

  //delete favorite
  Future<void> removeFavorite(int favId) async {
    isTogglingFavorites = true;
    dynamic res = await _vehicleService.deleteFavorite(favoriteId: favId);
    isTogglingFavorites = false;

    APIHelpers.handleResponse(res, onSuccess: (response) async {
      this.syncFavorites();
    });
  }
}
