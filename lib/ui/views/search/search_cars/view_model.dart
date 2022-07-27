import 'package:intl/intl.dart';
import 'package:staarm_mobile/app/locator.dart';
import 'package:staarm_mobile/core/models/address_model.dart';
import 'package:staarm_mobile/core/models/vehicle/vehicle_model.dart';
import 'package:staarm_mobile/core/services/vehicle_service/vehicle_service.dart';
import 'package:staarm_mobile/ui/base/base_view_model.dart';

class SearchCarsViewModel extends BaseViewModel {
  final _vehicleService = locator<VehicleService>();
  final DateFormat dateRequestFormatter = DateFormat('dd MMM');
  final DateFormat timeFormatter = DateFormat('h:m a');

  AddressModel _location;
  AddressModel get location => _location;
  set location(AddressModel val) {
    _location = val;
    notifyListeners();
  }

  DateTime _pickupDate = DateTime.now().add(Duration(days: 1));
  DateTime get pickupDate => _pickupDate;
  set pickupDate(DateTime val) {
    _pickupDate = val;
    notifyListeners();
  }

  DateTime _pickupTime = DateTime.now();
  DateTime get pickupTime => _pickupTime;
  set pickupTime(DateTime val) {
    _pickupTime = val;
    notifyListeners();
  }

  DateTime _returnDate = DateTime.now().add(Duration(days: 5));
  DateTime get returnDate => _returnDate;
  set returnDate(DateTime val) {
    _returnDate = val;
    notifyListeners();
  }

  DateTime _returnTime = DateTime.now();
  DateTime get returnTime => _returnTime;
  set returnTime(DateTime val) {
    _returnTime = val;
    notifyListeners();
  }


  String formattedDate(DateTime date, DateTime time) {
    if (date == null) return '---';
    return dateRequestFormatter.format(date) + ', ' + timeFormatter.format(date);
  }

  String get getTripPeriod{
    return '${formattedDate(pickupDate, pickupTime)}  -  ${formattedDate(returnDate, returnTime)}';
  }

  // void init() async {
  //   setLoading(true);
  //   await Future.delayed(Duration(seconds: 2));
  //   setLoading(false);
  // }

  List<VehicleModel> _vehicles = [];
  List<VehicleModel> get vehicles => _vehicles;
  set vehicles(List<VehicleModel> val) {
    _vehicles = val;
    notifyListeners();
  }

  void init(AddressModel loc, DateTime pDate, DateTime pTime, DateTime rDate,
      DateTime rTime) async {
    location = loc;
    pickupDate = pDate;
    pickupTime = pTime;
    returnDate = rDate;
    returnTime = rTime;
    searchVehicles(loc.lat, loc.lng);
  }

  void searchVehicles([num lat, num lng]) async {
    isLoading = true;
    dynamic res = await _vehicleService.searchVehicles(
      lat: lat,
      lng: lng,
    );
    isLoading = false;

    if (res != null) {
      vehicles = res;
    }
  }
}
