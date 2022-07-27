import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:staarm_mobile/app/locator.dart';
import 'package:staarm_mobile/core/models/address_model.dart';
import 'package:staarm_mobile/core/services/address_service/address_service.dart';
import 'package:staarm_mobile/core/services/vehicle_service/vehicle_service.dart';
import 'package:staarm_mobile/ui/base/base_view_model.dart';
import 'package:staarm_mobile/ui/views/search/search_cars/search_cars.dart';
import 'package:staarm_mobile/utils/app_debouncer.dart';
import 'package:staarm_mobile/utils/staarm_page_route.dart';

class SelectTripDateModalViewModel extends BaseViewModel {
  final _vehicleService = locator<VehicleService>();
  final _addrService = locator<AddressService>();
  final DateFormat dateRequestFormatter = DateFormat('dd/MM/yyyy');
  final DateFormat timeFormatter = DateFormat('h:m a');

  final debouncer = AppDebouncer(milliseconds: 500);

  AddressModel _selectedPickUpLocation;
  AddressModel get selectedPickUpLocation => _selectedPickUpLocation;
  set selectedPickUpLocation(AddressModel val) {
    _selectedPickUpLocation = val;
    notifyListeners();
  }

  DateTime _selectedPickupDate = DateTime.now().add(Duration(days: 1));
  DateTime get selectedPickupDate => _selectedPickupDate;
  set selectedPickupDate(DateTime val) {
    _selectedPickupDate = val;

    //if pickup date is more than dropoff date, we need to update the dropoff date to 4 days ahead of pickup date
    if (val.isAfter(selectedReturnDate) || val.isAtSameMomentAs(selectedReturnDate)) {
      selectedReturnDate = val.add(Duration(days: 4));
    }
    notifyListeners();
  }

  DateTime _selectedPickupTime = DateTime.now();
  DateTime get selectedPickupTime => _selectedPickupTime;
  set selectedPickupTime(DateTime val) {
    _selectedPickupTime = val;
    notifyListeners();
  }

  DateTime _selectedReturnDate = DateTime.now().add(Duration(days: 5));
  DateTime get selectedReturnDate => _selectedReturnDate;
  set selectedReturnDate(DateTime val) {
    _selectedReturnDate = val;
    notifyListeners();
  }

  DateTime _selectedReturnTime = DateTime.now();
  DateTime get selectedReturnTime => _selectedReturnTime;
  set selectedReturnTime(DateTime val) {
    _selectedReturnTime = val;
    notifyListeners();
  }

  String formattedDate(DateTime date) {
    if (date == null) return '--/--/----';
    return dateRequestFormatter.format(date);
  }

  String formattedTime(DateTime date) {
    if (date == null) return '--/--/----';
    return timeFormatter.format(date);
  }

  void reset() {
    selectedPickUpLocation = null;
    selectedPickupDate = DateTime.now().add(Duration(days: 1));
    selectedPickupTime = DateTime.now();
    selectedReturnDate = DateTime.now().add(Duration(days: 5));
    selectedReturnTime = DateTime(selectedReturnDate.year, selectedReturnDate.month, selectedReturnDate.day, 12);
  }

  void init(DateTime iPickupDate, DateTime iPickupTime, DateTime iReturnDate, DateTime iReturnTime) {
     selectedPickupDate = iPickupDate ?? DateTime.now().add(Duration(days: 1));
    selectedPickupTime = iPickupTime?? DateTime.now();
    selectedReturnDate = iReturnDate ?? DateTime.now().add(Duration(days: 5));
    selectedReturnTime = iReturnTime ?? DateTime(selectedReturnDate.year, selectedReturnDate.month, selectedReturnDate.day, 12);
  }

  void search(AddressModel addr) {
    Navigator.push(
      appContext,
      StaarmPageRoute.routeTo(
        builder: (context) => SearchCarsView(
          location: addr,
          pickupDate: selectedPickupDate,
          pickupTime: selectedPickupTime,
          returnDate: selectedReturnDate,
          returnTime: selectedReturnTime,
        ),
      ),
    );
  }
}
