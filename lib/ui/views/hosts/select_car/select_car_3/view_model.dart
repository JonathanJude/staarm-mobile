import 'package:flutter/material.dart';
import 'package:staarm_mobile/app/locator.dart';
import 'package:staarm_mobile/core/api/api_helpers.dart';
import 'package:staarm_mobile/core/models/address_model.dart';
import 'package:staarm_mobile/core/models/host_draft_vehicle.dart';
import 'package:staarm_mobile/core/services/address_service/address_service.dart';
import 'package:staarm_mobile/core/services/vehicle_service/vehicle_service.dart';
import 'package:staarm_mobile/ui/base/base_view_model.dart';
import 'package:staarm_mobile/ui/views/hosts/select_car/select_car_4/select_car_4.dart';
import 'package:staarm_mobile/utils/app_debouncer.dart';
import 'package:staarm_mobile/utils/staarm_app_notification.dart';
import 'package:staarm_mobile/utils/staarm_page_route.dart';

class SelectCar3ViewModel extends BaseViewModel {
  final _vehicleService = locator<VehicleService>();
  final _addrService = locator<AddressService>();
  TextEditingController pickUpLocationTextController = TextEditingController();
  TextEditingController dropOffLocationTextController = TextEditingController();

  final debouncer = AppDebouncer(milliseconds: 500);

  String _vehicleDraftId;
  String get vehicleDraftId => _vehicleDraftId;
  set vehicleDraftId(String val) {
    _vehicleDraftId = val;
    notifyListeners();
  }

  AddressModel _selectedPickUpLocation;
  AddressModel get selectedPickUpLocation => _selectedPickUpLocation;
  set selectedPickUpLocation(AddressModel val) {
    _selectedPickUpLocation = val;
    notifyListeners();
  }

  AddressModel _selectedDropOffLocation;
  AddressModel get selectedDropOffLocation => _selectedDropOffLocation;
  set selectedDropOffLocation(AddressModel val) {
    _selectedDropOffLocation = val;
    notifyListeners();
  }

  List<PlaceModel> _pickUpPlaces = [];
  List<PlaceModel> get pickUpPlaces => _pickUpPlaces;
  set pickUpPlaces(List<PlaceModel> val) {
    _pickUpPlaces = val;
    notifyListeners();
  }

  List<PlaceModel> _dropOffPlaces = [];
  List<PlaceModel> get dropOffPlaces => _dropOffPlaces;
  set dropOffPlaces(List<PlaceModel> val) {
    _dropOffPlaces = val;
    notifyListeners();
  }

  void init(String draftId, HostDraftVehicleModel hostVehicle) {
    vehicleDraftId = draftId;

    if(hostVehicle != null){
      //
    }
  }

  void onPickUpChanged(String str) {
    if (str.isEmpty) {
      pickUpPlaces = [];
    } else {
      searchPickUpPlaces(str);
    }
  }

  void onDropOffChanged(String str) {
    if (str.isEmpty) {
      dropOffPlaces = [];
    } else {
      searchDropOffPlaces(str);
    }
  }

  void onPickUpSelected(PlaceModel plc) async {
    pickUpLocationTextController.text = plc?.name ?? '';
    pickUpPlaces = [];
    selectedPickUpLocation =
        await _addrService.getAddressModelByPlaceId(plc.placeId, plc.name);
  }

  void onDropOffSelected(PlaceModel plc) async {
    dropOffLocationTextController.text = plc?.name ?? '';
    dropOffPlaces = [];
    selectedDropOffLocation =
        await _addrService.getAddressModelByPlaceId(plc.placeId, plc.name);
  }

  Future<List<PlaceModel>> searchPickUpPlaces(String query) async {
    debouncer.run(() async {
      dynamic res = await _addrService.searchAddresses(query);

      pickUpPlaces = res;

      return res;
    });
  }

  Future<List<PlaceModel>> searchDropOffPlaces(String query) async {
    debouncer.run(() async {
      dynamic res = await _addrService.searchAddresses(query);

      dropOffPlaces = res;

      return res;
    });
  }

  void updateVehiclePickOffAndDropOffLocation(HostDraftVehicleModel hostVehicle) async {
    if (selectedPickUpLocation == null) {
      StaarmAppNotification.error(message: 'Select a Pickup location');
    } else if (selectedDropOffLocation == null) {
      StaarmAppNotification.error(message: 'Select a Dropoff location');
    } else {
      isLoading = true;
      dynamic res = await _vehicleService.updateVehiclePickUpAndDropOff(
        pickupLocation: selectedPickUpLocation.name,
        dropOffLocation: selectedDropOffLocation.name,
        pickupLatitude: selectedPickUpLocation.lat,
        pickupLongitude: selectedPickUpLocation.lng,
        draftId: vehicleDraftId,
      );
      isLoading = false;

      APIHelpers.handleResponse(res, onSuccess: (response) async {
        Navigator.push(
          appContext,
          StaarmPageRoute.routeTo(
            builder: (context) => SelectCar4View(
              draftId: vehicleDraftId,
              hostVehicle: hostVehicle,
            ),
          ),
        );
      });
    }
  }
}
