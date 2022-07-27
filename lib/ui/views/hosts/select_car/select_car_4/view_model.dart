import 'package:flutter/material.dart';
import 'package:staarm_mobile/app/locator.dart';
import 'package:staarm_mobile/core/api/api_helpers.dart';
import 'package:staarm_mobile/core/models/host_draft_vehicle.dart';
import 'package:staarm_mobile/core/services/vehicle_service/vehicle_service.dart';
import 'package:staarm_mobile/ui/base/base_view_model.dart';
import 'package:staarm_mobile/ui/views/hosts/select_car/car_features/car_features.dart';
import 'package:staarm_mobile/utils/staarm_app_notification.dart';
import 'package:staarm_mobile/utils/staarm_page_route.dart';

class SelectCar4ViewModel extends BaseViewModel {
  final _vehicleService = locator<VehicleService>();
  TextEditingController pricingTextController = TextEditingController();

  String _vehicleDraftId;
  String get vehicleDraftId => _vehicleDraftId;
  set vehicleDraftId(String val) {
    _vehicleDraftId = val;
    notifyListeners();
  }

  void init(String draftId, HostDraftVehicleModel hostVehicle) {
    vehicleDraftId = draftId;

    if(hostVehicle != null){
      pricingTextController.text = hostVehicle.dailyPriceInKobo.toString();
    }
  }

  void updateVehiclePricing(HostDraftVehicleModel hostVehicle) async {
    if (pricingTextController.text.replaceAll(",", "").isEmpty) {
      StaarmAppNotification.error(message: 'Enter an amount');
    } else {
      isLoading = true;

      num _enteredPrice = num.tryParse(pricingTextController.text.replaceAll(",", "")) ?? 0;
      num _price = (_enteredPrice * 100);
      dynamic res = await _vehicleService.updateVehiclePricing(dailyPrice: _price, draftId: vehicleDraftId);
      isLoading = false;

      APIHelpers.handleResponse(res, onSuccess: (response) async {
        Navigator.push(
          appContext,
          StaarmPageRoute.routeTo(
            builder: (context) => CarFeatures(
              draftId: vehicleDraftId,
              hostVehicle: hostVehicle,
            ),
          ),
        );
      });
    }
  }
}