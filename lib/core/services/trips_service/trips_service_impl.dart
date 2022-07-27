import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:logging/logging.dart';
import 'package:staarm_mobile/core/api/service_state.dart';
import 'package:staarm_mobile/core/endpoints/endpoints.dart';
import 'package:staarm_mobile/core/exceptions/unknown_exception.dart';
import 'package:staarm_mobile/core/models/booking_trip_model.dart';
import 'package:staarm_mobile/core/models/protection_plan.dart';
import 'package:staarm_mobile/core/services/http_helper.dart/http_helper.dart';
import 'package:staarm_mobile/core/services/trips_service/trips_service.dart';

class TripsServiceImpl extends TripsService {
  HttpHelper httpHelper;
  TripsServiceImpl({@required this.httpHelper}) : assert(httpHelper != null);

  final _log = Logger('TripsServiceImpl');

  Future<List<ProtectionPlanModel>> getProtectionPlans() async {
    try {
      final jsonData = await httpHelper.get(
        Endpoints.protectionPlans,
      );

      if (jsonData is SuccessState) {
        try {
          final mapResponse = jsonData.value;

          print("mapResponse: -- $mapResponse");

          List<ProtectionPlanModel> _list = [];

          if (mapResponse['data']['protection_plans'] == null) {
            _list = [];
          } else {
            _list = mapResponse['data']['protection_plans']
                .map<ProtectionPlanModel>((json) {
              return ProtectionPlanModel.fromJson(json);
            }).toList();
          }

          return _list;
        } catch (e) {
          print("List error  -=-- ${e.toString()}");
        }
      } else {
        return null;
      }
    } catch (e) {
      _log.severe('Error occured');
      throw const UnknownException();
    }
  }

  @override
  Future<dynamic> bookTrip({
    @required int vehicleId,
    @required DateTime startDate,
    @required DateTime endDate,
    @required int protectionPlanId,
  }) async {
    final DateFormat dateRequestFormatter = DateFormat('yyyy-MM-dd');

    try {
      Map<String, dynamic> _data = {
        "vehicle_id": vehicleId,
        "start_date": dateRequestFormatter.format(startDate),
        "end_date": dateRequestFormatter.format(endDate),
        "protection_plan_id": protectionPlanId,
      };

      final jsonData = await httpHelper.post(
        Endpoints.trips,
        body: _data,
      );

      _log.fine(jsonData.toString());
      print(jsonData.toString());

      return jsonData;
    } on Exception {
      _log.severe('Error occured');
      throw const UnknownException();
    }
  }

  @override
  Future<List<TripModel>> getBookings() async {
    try {
      final jsonData = await httpHelper.get(Endpoints.tripBookings);

      _log.fine(jsonData.toString());

      if (jsonData is SuccessState) {
        final mapResponse = jsonData.value;
        List list = List.from(mapResponse["data"]["booked_trips"]);
        List<TripModel> bookingTripModels = list
            .map(
              (i) => TripModel.fromJson(Map.from(i)),
            )
            .toList();
        return bookingTripModels;
      } else {
        return null;
      }
    } on Exception {
      _log.severe('Error occured at get bookings');
      throw const UnknownException();
    }
  }

  @override
  Future<List<TripModel>> getHistory() async {
    try {
      final jsonData = await httpHelper.get(Endpoints.trips);

      _log.fine(jsonData.toString());

      if (jsonData is SuccessState) {
        final mapResponse = jsonData.value;
        List list = List.from(mapResponse["data"]["trips"]);
        List<TripModel> trips = list
            .map(
              (i) => TripModel.fromJson(Map.from(i)),
            )
            .toList();
        return trips;
      } else {
        return null;
      }
    } on Exception {
      _log.severe('Error occured at get bookings');
      throw const UnknownException();
    }
  }

  @override
  Future<bool> cancelTrip({int tripId}) async {
    try {
      final jsonData = await httpHelper.delete(Endpoints.trips + '/$tripId');

      _log.fine(jsonData.toString());

      if (jsonData is SuccessState) {
        return true;
      }

      return false;
    } on Exception {
      _log.severe('Error occured at cancel trip');
      throw const UnknownException();
    }
  }

  @override
  Future<bool> acceptTrip({int tripId}) async {
    try {
      final jsonData = await httpHelper.put(Endpoints.trips + '/$tripId/approve');

      _log.fine(jsonData.toString());

      if (jsonData is SuccessState) {
        return true;
      }

      return false;
    } on Exception {
      _log.severe('Error occured at cancel trip');
      throw const UnknownException();
    }
  }

  @override
  Future<bool> declineTrip({int tripId}) async {
    try {
      final jsonData = await httpHelper.put(Endpoints.trips + '/$tripId/decline');

      _log.fine(jsonData.toString());

      if (jsonData is SuccessState) {
        return true;
      }

      return false;
    } on Exception {
      _log.severe('Error occured at cancel trip');
      throw const UnknownException();
    }
  }
}
