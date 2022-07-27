import 'package:staarm_mobile/app/locator.dart';
import 'package:staarm_mobile/core/models/booking_trip_model.dart';
import 'package:staarm_mobile/core/services/trips_service/trips_service.dart';
import 'package:staarm_mobile/ui/base/base_view_model.dart';

class BookingViewModel extends BaseViewModel {
  final _tripsService = locator<TripsService>();

  List<TripModel> _bookings;
  List<TripModel> get bookings => _bookings;
  set bookings(List val) {
    _bookings = val;
    notifyListeners();
  }

  void deleteAt(int index) {
    _bookings.removeAt(index);
    notifyListeners();
  }

  Future<void> getBookings() async {
    List<TripModel> res = await _tripsService.getBookings();
    if (res != null) {
      bookings = res;
    }
    notifyListeners();
  }

  void init() async {
    isLoading = true;
    await getBookings();
    isLoading = false;
  }
}
