// import 'package:flutter/material.dart';
// import 'package:location/location.dart';
// import 'package:location_platform_interface/location_platform_interface.dart';
// import 'package:logging/logging.dart';
// import 'package:staarm_mobile/core/services/http_helper.dart/http_helper.dart';

// import 'location_service.dart';

// class LocationServiceImpl extends LocationService {
//   HttpHelper httpHelper;
//   LocationServiceImpl({@required this.httpHelper}) : assert(httpHelper != null);

//   final _log = Logger('LocationServiceImpl');

//   @override
//   Future<LocationData> getLocation() async {
//     Location location = new Location();

//     bool _serviceEnabled;
//     PermissionStatus _permissionGranted;
//     LocationData _locationData;

//     _serviceEnabled = await location.serviceEnabled();
//     if (!_serviceEnabled) {
//       _serviceEnabled = await location.requestService();
//       if (!_serviceEnabled) {
//         return null;
//       }
//     }

//     _permissionGranted = await location.hasPermission();
//     if (_permissionGranted == PermissionStatus.denied) {
//       _permissionGranted = await location.requestPermission();
//       if (_permissionGranted != PermissionStatus.granted) {
//         return null;
//       }
//     }

//     _locationData = await location.getLocation();
    
//     return _locationData;
//   }

//   @override
//   Future<bool> requestLocationPermission() async {
//     PermissionStatus _permissionGranted;
//     Location location = new Location();

//     _permissionGranted = await location.hasPermission();
//     if (_permissionGranted == PermissionStatus.denied) {
//       _permissionGranted = await location.requestPermission();
//       if (_permissionGranted == PermissionStatus.granted) {
//         return true;
//       }
//     }

//     return false;
//   }

//   @override
//   Stream<LocationData> getLocationStream() {
//     Location location = new Location();

//     return location.onLocationChanged;
//   }
// }
