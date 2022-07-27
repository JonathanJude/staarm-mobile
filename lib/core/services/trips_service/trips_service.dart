import 'package:flutter/material.dart';
import 'package:staarm_mobile/core/models/booking_trip_model.dart';
import 'package:staarm_mobile/core/models/protection_plan.dart';

abstract class TripsService {
  Future<List<ProtectionPlanModel>> getProtectionPlans();

  Future<dynamic> bookTrip({
    @required int vehicleId,
    @required DateTime startDate,
    @required DateTime endDate,
    @required int protectionPlanId,
  });

  Future<List<TripModel>> getBookings();

  Future<List<TripModel>> getHistory();

  Future<bool> cancelTrip({int tripId});

  Future<bool> acceptTrip({int tripId});

  Future<bool> declineTrip({int tripId});
}
