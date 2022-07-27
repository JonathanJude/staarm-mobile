import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:staarm_mobile/ui/base/base_view_model.dart';
import 'package:staarm_mobile/ui/views/search/modals/select_trip_date_modal/select_trip_date_modal.dart';

class BookingViewModel extends BaseViewModel {
  DateTime _tripStartDate = DateTime.now().add(Duration(days: 1));
  DateTime get tripStartDate => _tripStartDate;
  set tripStartDate(DateTime val) {
    _tripStartDate = val;
    notifyListeners();
  }

  DateTime _tripStartTime = DateTime.now().add(Duration(days: 1));
  DateTime get tripStartTime => _tripStartTime;
  set tripStartTime(DateTime val) {
    _tripStartTime = val;
    notifyListeners();
  }

  DateTime _tripEndDate = DateTime.now().add(Duration(days: 5));
  DateTime get tripEndDate => _tripEndDate;
  set tripEndDate(DateTime val) {
    _tripEndDate = val;
    notifyListeners();
  }

  DateTime _tripEndTime = DateTime.now().add(Duration(days: 5));
  DateTime get tripEndTime => _tripEndTime;
  set tripEndTime(DateTime val) {
    _tripEndTime = val;
    notifyListeners();
  }

  void init(
      DateTime pDate, DateTime pTime, DateTime rDate, DateTime rTime) async {
    tripStartDate = pDate;
    tripStartTime = pTime;
    tripEndDate = rDate;
    tripEndTime = rTime;
  }

  void updateTripDates() async {
    await showCupertinoModalBottomSheet(
      expand: true,
      context: appContext,
      isDismissible: false,
      useRootNavigator: true,
      enableDrag: false,
      backgroundColor: Colors.transparent,
      builder: (context) => SelectTripDateModalView(
        iPickupDate: tripStartDate,
        iPickupTime: tripStartDate,
        iReturnDate: tripEndDate,
        iReturnTime: tripEndTime,
        address: null,
        onSelect: (sPickupDate, sPickupTime, sReturnDate, sReturnTime) {
          tripStartDate = sPickupDate;
          tripStartTime = sPickupTime;
          tripEndDate = sReturnDate;
          tripEndTime = sReturnTime;
          Navigator.pop(context);
        },
      ),
    );
  }
}
