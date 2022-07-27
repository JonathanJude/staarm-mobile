import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:staarm_mobile/core/providers/location_provider.dart';

import '../../base/base_view_model.dart';

class MainPageViewModel extends BaseViewModel {
  // final _locationService = locator<LocationService>();

  bool _isChecking = true;
  bool get isChecking => _isChecking;

  set isChecking(bool val) {
    _isChecking = val;
    notifyListeners();
  }

  Future<void> init() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
    //get location permission
    // await _locationService.requestLocationPermission();

    //location stream
    LocationProvider _locProvider = Provider.of<LocationProvider>(
      appContext,
      listen: false,
    );

    // LocationData _loc = await _locationService.getLocation();
    // _locProvider.locationData = _loc;

    // _locProvider.onLocationChange();
    });
  }
}
