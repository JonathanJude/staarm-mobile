import 'package:staarm_mobile/app/locator.dart';
import 'package:staarm_mobile/core/services/trips_service/trips_service.dart';
import 'package:staarm_mobile/ui/base/base_view_model.dart';

class HostsVehicleTabViewModel extends BaseViewModel {
  final _tripsService = locator<TripsService>();

  Future<void> getVehicles() async {
    // List<VehicleModel> res = await _tripsService.getBookings();
    // if (res != null) {
    //   vehicles = res;
    // }
    // notifyListeners();
  }

  void init() async {
    isLoading = true;
    await getVehicles();
    isLoading = false;
  }
}
