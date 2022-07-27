import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:staarm_mobile/app/locator.dart';
import 'package:staarm_mobile/app/storage_helper.dart';
import 'package:staarm_mobile/app/storage_keys.dart';
import 'package:staarm_mobile/core/api/api_helpers.dart';
import 'package:staarm_mobile/core/models/host_draft_vehicle.dart';
import 'package:staarm_mobile/core/models/vehicle/vehicle_info_model.dart';
import 'package:staarm_mobile/core/providers/vehicle_provider.dart';
import 'package:staarm_mobile/core/services/vehicle_service/vehicle_service.dart';
import 'package:staarm_mobile/ui/base/base_view_model.dart';
import 'package:staarm_mobile/ui/views/hosts/select_car/select_car_2/select_car_2.dart';
import 'package:staarm_mobile/utils/staarm_app_notification.dart';
import 'package:staarm_mobile/utils/staarm_page_route.dart';

class SelectCar1ViewModel extends BaseViewModel {
  final _vehicleService = locator<VehicleService>();

  VehicleMake _selectedCarMake;
  VehicleMake get selectedCarMake => _selectedCarMake;
  set selectedCarMake(VehicleMake val) {
    _selectedCarMake = val;
    notifyListeners();
  }

  String _selectedModel;
  String get selectedModel => _selectedModel;
  set selectedModel(String val) {
    _selectedModel = val;
    notifyListeners();
  }

  String _vehicleYear;
  String get vehicleYear => _vehicleYear;
  set vehicleYear(String val) {
    _vehicleYear = val;
    notifyListeners();
  }

  void init(HostDraftVehicleModel hostVehicle) async {
    VehicleProvider _vehicleProvider =
        Provider.of<VehicleProvider>(appContext, listen: false);

    if (_vehicleProvider.vehicleData == null) {
      _vehicleProvider.syncVehicleData(appContext);
    }

    if(hostVehicle != null){
      vehicleYear = hostVehicle.carYear;
      selectedModel = hostVehicle.carModel;
      // selectedCarMake = hostVehicle.carMake
    }
  }

  void startVehicleHosting(HostDraftVehicleModel hostVehicle) async {
    isLoading = true;
    dynamic res = await _vehicleService.startVehicleHosting(
      carMake: selectedCarMake.make,
      carModel: selectedModel,
      carYear: vehicleYear,
    );
    isLoading = false;

    APIHelpers.handleResponse(res, onSuccess: (response) async {
      if(vehicleYear == null || vehicleYear.isEmpty){
        StaarmAppNotification.error(message: 'Select a Car year');
      }else if(selectedCarMake == null){
        StaarmAppNotification.error(message: 'Select a Car Make');
      }else if(selectedModel == null){
        StaarmAppNotification.error(message: 'Select a Car Model');
      }else if(response.value['data']['draft_vehicle_id'] == null){
        StaarmAppNotification.error(message: 'Error saving Vehicle details');
      }else{
        String _draftId = response.value['data']['draft_vehicle_id'];

      StorageHelper.setString(StorageKeys.vehicleDraftId, _draftId);
      Navigator.push(
        appContext,
        StaarmPageRoute.routeTo(
          builder: (context) => SelectCar2View(
            vehicle: selectedCarMake,
            model: selectedModel,
            year: vehicleYear,
            draftId: _draftId,
            hostVehicle: hostVehicle,
          ),
        ),
      );
      }
    });
  }
}
