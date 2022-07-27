import 'package:flutter/material.dart';
import 'package:staarm_mobile/app/locator.dart';
import 'package:staarm_mobile/core/api/api_helpers.dart';
import 'package:staarm_mobile/core/models/card.dart';
import 'package:staarm_mobile/core/models/protection_plan.dart';
import 'package:staarm_mobile/core/models/vehicle/vehicle_model.dart';
import 'package:staarm_mobile/core/services/navigator_service.dart';
import 'package:staarm_mobile/core/services/payment_service/payment_service.dart';
import 'package:staarm_mobile/core/services/trips_service/trips_service.dart';
import 'package:staarm_mobile/ui/base/base_view_model.dart';
import 'package:staarm_mobile/ui/views/profile/payments/select_payment_metthod/select_payment_method.dart';
import 'package:staarm_mobile/ui/views/search/booking/trips_successful.dart';
import 'package:staarm_mobile/utils/app_helper.dart';
import 'package:staarm_mobile/utils/events/staarm_events.dart';
import 'package:staarm_mobile/utils/staarm_app_notification.dart';
import 'package:staarm_mobile/utils/staarm_page_route.dart';

class CheckoutViewModel extends BaseViewModel {
  final _navService = locator<NavigationService>();
  final _tripsService = locator<TripsService>();
  final _paymentService = locator<PaymentService>();

  CardModel _selectedCard;
  CardModel get selectedCard => _selectedCard;
  set selectedCard(CardModel val) {
    _selectedCard = val;
    notifyListeners();
  }

  // void init() async {
  //   //sync protection plans
  //   VehicleProvider _vehicleProviders = Provider.of<VehicleProvider>(appContext, listen: false);

  //   if(_vehicleProviders.protectionPlans.length == 0){
  //     await _vehicleProviders.syncProtectionPlans();
  //   }
  // }

  num tripTotal(num price, DateTime startDate, DateTime endDate,
      ProtectionPlanModel plan) {
    int _days = AppHelper.getDaysBetweenDates(startDate, endDate);
    num total = AppHelper.getTripAmountByPeriod(price, startDate, endDate);
    num planTotal = plan.price * _days;

    return (total + planTotal) ?? 0;
  }

  num totalInsuranceAmount(
      num insurancePrice, DateTime startDate, DateTime endDate) {
    int _days = AppHelper.getDaysBetweenDates(startDate, endDate);

    num _total = insurancePrice * _days;

    return _total ?? 0;
  }

  void selectPaymentMethod() async {
    await Navigator.push(
      appContext,
      StaarmPageRoute.routeTo(
        builder: (context) => SelectPaymentMethod(
          onSelect: (c) {
            if (c != null) {
              selectedCard = c;
            }

            Navigator.of(context).pop();
          },
        ),
      ),
    );
  }

  void bookTrip(
    VehicleModel vehicle,
    DateTime startDate,
    DateTime endDate,
    ProtectionPlanModel plan,
  ) async {
    isLoading = true;
    dynamic res = await _tripsService.bookTrip(
      vehicleId: vehicle.id,
      startDate: startDate,
      endDate: endDate,
      protectionPlanId: plan.id,
    );

    APIHelpers.handleResponse(res, onSuccess: (response) async {
      int _tripId = response.value['data']['trip']['id'];

      print(" RESP --- ${response.value}");
      print("TRIP ID --- $_tripId");

      payForBooking(selectedCard, _tripId);
    }, onError: (e) {
      isLoading = false;
      StaarmAppNotification.error(message: e);
    });
  }

  void payForBooking(CardModel card, int tripId) async {
    isLoading = true;
    dynamic res =
        await _paymentService.chargeCard(cardId: card.id, tripId: tripId);
    isLoading = false;

    APIHelpers.handleResponse(res, onSuccess: (response) async {
      //trigger events
      mixPanel.logEvent(StaarmEvents.onBookingAVehicle, logIntercom: true);

      await Navigator.pushReplacement(
        appContext,
        StaarmPageRoute.routeTo(
          builder: (context) => TripsSuccessfulView(),
        ),
      );
    });
  }
}
