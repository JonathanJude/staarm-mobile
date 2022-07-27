import 'package:flutter/material.dart';
import 'package:staarm_mobile/app/locator.dart';
import 'package:staarm_mobile/core/api/api_helpers.dart';
import 'package:staarm_mobile/core/models/host_draft_vehicle.dart';
import 'package:staarm_mobile/core/services/vehicle_service/vehicle_service.dart';
import 'package:staarm_mobile/ui/base/base_view_model.dart';
import 'package:staarm_mobile/utils/staarm_page_route.dart';

import '../select_car_3/select_car_3.dart';

class SelectCar2ViewModel extends BaseViewModel {
  final _vehicleService = locator<VehicleService>();
  TextEditingController licenseNumberTextController = TextEditingController();

  List<String> transmissionList = ['Automatic', 'Manual'];
  List<String> vehicleTypesList = ['Sedan', 'Coupe', 'SUV', 'Convertible'];
  List<String> marketValueList = [
    '1 million - 3 million',
    '3 million - 9 million'
  ];
  List<String> odometerList = [
    '0 - 40k kilometers',
    '40k - 80k kilometers',
    '80k - 150k kilometers'
  ];

  String _vehicleDraftId;
  String get vehicleDraftId => _vehicleDraftId;
  set vehicleDraftId(String val) {
    _vehicleDraftId = val;
    notifyListeners();
  }

  String _transmission;
  String get transmission => _transmission;
  set transmission(String val) {
    _transmission = val;
    notifyListeners();
  }

  String _odometer;
  String get odometer => _odometer;
  set odometer(String val) {
    _odometer = val;
    notifyListeners();
  }

  String _vehicleType;
  String get vehicleType => _vehicleType;
  set vehicleType(String val) {
    _vehicleType = val;
    notifyListeners();
  }

  String _marketValue;
  String get marketValue => _marketValue;
  set marketValue(String val) {
    _marketValue = val;
    notifyListeners();
  }

  String _selectedState;
  String get selectedState => _selectedState;
  set selectedState(String val) {
    _selectedState = val;
    notifyListeners();
  }

  String _licenceNumber;
  String get licenceNumber => _licenceNumber;
  set licenceNumber(String val) {
    _licenceNumber = val;
    notifyListeners();
  }

  void init(String draftId, HostDraftVehicleModel hostVehicle){
    vehicleDraftId = draftId;

    if(hostVehicle != null){
      // vehicleDraftId = hostVehicle.draftId;
      transmission = hostVehicle.transmission ?? '';
      odometer = hostVehicle.odometer ?? '';
      vehicleType = hostVehicle.vehicleType ?? '';
      marketValue = hostVehicle.marketValue ?? '';
      selectedState = hostVehicle.licenceState ?? '';
      licenceNumber = hostVehicle.licenceNumber ?? '';
      licenseNumberTextController.text = hostVehicle.licenceNumber ?? '';
      selectedState = hostVehicle.licenceState ?? '';
    }
  }

  void updateVehicleDetails() async {
    isLoading = true;
    dynamic res = await _vehicleService.updateVehicleDetails(
      odometer: odometer,
      transmission: transmission,
      vehicleType: vehicleType,
      marketValue: marketValue,
      licenceState: selectedState,
      licenceNumber: licenceNumber,
      draftId: vehicleDraftId,
    );
    isLoading = false;

    APIHelpers.handleResponse(res, onSuccess: (response) async {
      // StorageHelper.setString(StorageKeys.vehicleDraftId, _draftId);

      Navigator.push(
        appContext,
        StaarmPageRoute.routeTo(
          builder: (context) => SelectCar3View(
            draftId: vehicleDraftId,
          ),
        ),
      );
    });
  }
}
