import 'package:flutter/material.dart';
import 'package:staarm_mobile/core/models/app_location_data.dart';
import 'package:staarm_mobile/utils/constants.dart';

class LocationProvider extends ChangeNotifier {
  // final _locationService = locator<LocationService>();

  AppLocationData _locationData = AppLocationData(
    latitude: lagosLat,
    longitude: lagosLng,
  );
  AppLocationData get locationData => _locationData;
  set locationData(AppLocationData val) {
    _locationData = val;
    notifyListeners();
  }

  bool get isLocationAvailable {
    return locationData != null && locationData.latitude != null && locationData.longitude != null;
  }

  // void onLocationChange() {
  //   _locationService.getLocationStream().listen((loc) {
  //     AppLocationData _appLocationData = AppLocationData.fromLocationData(loc);
  //     locationData = _appLocationData;
  //   });
  // }
}
