import 'package:flutter/material.dart';
import 'package:staarm_mobile/app/locator.dart';
import 'package:staarm_mobile/core/api/api_helpers.dart';
import 'package:staarm_mobile/core/models/host_draft_vehicle.dart';
import 'package:staarm_mobile/core/services/vehicle_service/vehicle_service.dart';
import 'package:staarm_mobile/ui/base/base_view_model.dart';
import 'package:staarm_mobile/ui/views/hosts/select_car/car_description/car_description.dart';
import 'package:staarm_mobile/utils/app_helper.dart';
import 'package:staarm_mobile/utils/staarm_app_notification.dart';
import 'package:staarm_mobile/utils/staarm_page_route.dart';

class CarFeaturesViewModel extends BaseViewModel {
  final _vehicleService = locator<VehicleService>();
  TextEditingController pricingTextController = TextEditingController();
  ScrollController scrollController = ScrollController();

  List<String> featuresList1 = AppHelper.getCarFeatures;
  List<String> featuresList2 = ['Fire extinguisher', 'First aid kit'];

  String _vehicleDraftId;
  String get vehicleDraftId => _vehicleDraftId;
  set vehicleDraftId(String val) {
    _vehicleDraftId = val;
    notifyListeners();
  }

  List<String> _selectedfeatures = [];
  List<String> get selectedfeatures => _selectedfeatures;
  set selectedfeatures(List<String> val) {
    _selectedfeatures = val;
    notifyListeners();
  }

  void onSelectFeature(String feature) {
    if (selectedfeatures.contains(feature)) {
      selectedfeatures.remove(feature);
    } else {
      selectedfeatures.add(feature);
    }

    notifyListeners();
  }

  bool isSelected(String feature) {
    return selectedfeatures.contains(feature);
  }

  void init(String draftId, HostDraftVehicleModel hostVehicle) {
    vehicleDraftId = draftId;

    if(hostVehicle != null){
      // selectedfeatures = hostVehicle.
    }
  }

  void updateVehicleFeatures(HostDraftVehicleModel hostVehicle) async {
    if (selectedfeatures.length == 0) {
      StaarmAppNotification.error(message: 'Select a Car feature');
    } else {
      isLoading = true;
      dynamic res = await _vehicleService.updateVehicleFeatures(
        features: selectedfeatures,
        draftId: vehicleDraftId,
      );
      isLoading = false;

      APIHelpers.handleResponse(res, onSuccess: (response) async {
        Navigator.push(
          appContext,
          StaarmPageRoute.routeTo(
            builder: (context) => CarDescription(
              draftId: vehicleDraftId,
            ),
          ),
        );
      });
    }
  }
}
