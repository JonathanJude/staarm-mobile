import 'package:staarm_mobile/app/locator.dart';
import 'package:staarm_mobile/core/models/booking_trip_model.dart';
import 'package:staarm_mobile/core/services/trips_service/trips_service.dart';
import 'package:staarm_mobile/ui/base/base_view_model.dart';

class HistoryViewModel extends BaseViewModel {
  final _tripsService = locator<TripsService>();

  List<TripModel> _hisory;
  List<TripModel> get history => _hisory;
  set history(List val) {
    _hisory = val;
    notifyListeners();
  }

  void deleteAt(int index){
    _hisory.removeAt(index);
    notifyListeners();
  }

  Future<void> getHistory() async {
    List<TripModel> res = await _tripsService.getHistory();
    if (res != null) {
      history = res;
    }
    notifyListeners();
  }

  void init() async {
    isLoading = true;
    await getHistory();
    isLoading = false;
  }
}
