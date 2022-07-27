import 'package:flutter/material.dart';
import 'package:staarm_mobile/app/locator.dart';
import 'package:staarm_mobile/core/models/booking_trip_model.dart';
import 'package:staarm_mobile/core/services/trips_service/trips_service.dart';
import 'package:staarm_mobile/ui/base/base_view_model.dart';

class TripViewModel extends BaseViewModel {
  
  final _tripsService = locator<TripsService>();

  void init(TripModel trip) {
    _tripId = trip.id;
  }

  int _tripId;

  bool isLoading = false;
  bool isLoadingForDecline = false;

  Future<bool> cancelTrip() {
    return _tripsService.cancelTrip(tripId: _tripId);
  }

  Future<bool> acceptTrip(BuildContext context) async {
    isLoading = true;
    notifyListeners();
    bool successful = await _tripsService.acceptTrip(tripId: _tripId);
    isLoading = false;
    notifyListeners();
    if (successful) {
      Navigator.pop(context, true);
    }
    return successful;
  }

  Future<bool> declineTrip(BuildContext context) async {
    isLoadingForDecline = true;
    notifyListeners();
    bool successful = await _tripsService.declineTrip(tripId: _tripId);
    isLoadingForDecline = false;
    notifyListeners();
    if (successful) {
      Navigator.pop(context, false);
    }
    return successful;
  }
}
