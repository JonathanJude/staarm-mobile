import 'package:flutter/material.dart';
import 'package:staarm_mobile/app/locator.dart';
import 'package:staarm_mobile/core/api/api_helpers.dart';
import 'package:staarm_mobile/core/services/vehicle_service/vehicle_service.dart';
import 'package:staarm_mobile/ui/base/base_view_model.dart';
import 'package:staarm_mobile/utils/staarm_app_notification.dart';
import 'package:staarm_mobile/utils/staarm_page_route.dart';

import '../upload_photo_info/upload_photo_info.dart';

class CarDescriptionViewModel extends BaseViewModel {
  final _vehicleService = locator<VehicleService>();
  TextEditingController descTextController = TextEditingController();

  String _vehicleDraftId;
  String get vehicleDraftId => _vehicleDraftId;
  set vehicleDraftId(String val) {
    _vehicleDraftId = val;
    notifyListeners();
  }

  void init(String draftId) {
    vehicleDraftId = draftId;
  }

  void updateVehicleDesc() async {
    if (descTextController.text.isEmpty) {
      StaarmAppNotification.error(message: 'Enter a description');
    } else {
      isLoading = true;

      dynamic res = await _vehicleService.updateVehicleDescription(
        description: descTextController.text,
        draftId: vehicleDraftId,
      );
      isLoading = false;

      APIHelpers.handleResponse(res, onSuccess: (response) async {
        Navigator.push(
          appContext,
          StaarmPageRoute.routeTo(
            builder: (context) => UploadPhotoInfo(
              draftId: vehicleDraftId,
            ),
          ),
        );
      });
    }
  }
}
