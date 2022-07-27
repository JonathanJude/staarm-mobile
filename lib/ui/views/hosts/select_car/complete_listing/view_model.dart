import 'package:flutter/material.dart';
import 'package:staarm_mobile/app/locator.dart';
import 'package:staarm_mobile/core/api/api_helpers.dart';
import 'package:staarm_mobile/core/services/vehicle_service/vehicle_service.dart';
import 'package:staarm_mobile/ui/base/base_view_model.dart';
import 'package:staarm_mobile/ui/views/main_page/main_page.dart';
import 'package:staarm_mobile/utils/events/staarm_events.dart';
import 'package:staarm_mobile/utils/staarm_app_notification.dart';
import 'package:staarm_mobile/utils/staarm_page_route.dart';

class CompleteListingViewModel extends BaseViewModel {
  final _vehicleService = locator<VehicleService>();

  String _vehicleDraftId;
  String get vehicleDraftId => _vehicleDraftId;
  set vehicleDraftId(String val) {
    _vehicleDraftId = val;
    notifyListeners();
  }

  void init(String draftId) {
    vehicleDraftId = draftId;
  }

  void completeVehicleCreation() async {
    isLoading = true;

    dynamic res =
        await _vehicleService.completeVehicleHosting(draftId: vehicleDraftId);
    isLoading = false;

    APIHelpers.handleResponse(res, onSuccess: (response) async {

      //trigger events
      mixPanel.logEvent(StaarmEvents.onHostProcessStarted, logIntercom: true);

      StaarmAppNotification.success(message: 'Vehicle has been created successfully');
      
      Navigator.push(
        appContext,
        StaarmPageRoute.routeTo(
          builder: (context) => MainPage(),
        ),
      );
    });
  }
}
