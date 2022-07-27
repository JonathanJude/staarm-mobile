import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:staarm_mobile/app/locator.dart';
import 'package:staarm_mobile/core/models/address_model.dart';
import 'package:staarm_mobile/core/providers/location_provider.dart';
import 'package:staarm_mobile/core/services/address_service/address_service.dart';
import 'package:staarm_mobile/core/services/vehicle_service/vehicle_service.dart';
import 'package:staarm_mobile/ui/base/base_view_model.dart';
import 'package:staarm_mobile/ui/views/search/modals/select_trip_date_modal/select_trip_date_modal.dart';
import 'package:staarm_mobile/utils/app_debouncer.dart';

class LocationSearchViewModel extends BaseViewModel {
  final _vehicleService = locator<VehicleService>();
  final _addrService = locator<AddressService>();
  TextEditingController locationTextController = TextEditingController();

  final debouncer = AppDebouncer(milliseconds: 500);

  AddressModel _selectedPickUpLocation;
  AddressModel get selectedPickUpLocation => _selectedPickUpLocation;
  set selectedPickUpLocation(AddressModel val) {
    _selectedPickUpLocation = val;
    notifyListeners();
  }

  List<PlaceModel> _pickUpPlaces = [];
  List<PlaceModel> get pickUpPlaces => _pickUpPlaces;
  set pickUpPlaces(List<PlaceModel> val) {
    _pickUpPlaces = val;
    notifyListeners();
  }

  void onPickUpChanged(String str) {
    if (str.trim().isEmpty) {
      pickUpPlaces = [];
    } else {
      searchPickUpPlaces(str);
    }
  }

  void onExploreHostsNearby() {
    LocationProvider _locationProvider = Provider.of(appContext, listen: false);

    if (_locationProvider.isLocationAvailable) {
      AddressModel _addr = AddressModel(
        lat: _locationProvider.locationData.latitude,
        lng: _locationProvider.locationData.longitude,
        name: "Your Location",
      );

      showCupertinoModalBottomSheet(
        expand: true,
        context: appContext,
        isDismissible: false,
        useRootNavigator: true,
        enableDrag: false,
        backgroundColor: Colors.transparent,
        builder: (context) => SelectTripDateModalView(
          address: _addr,
        ),
      );

      // Navigator.pushReplacement(
      //   appContext,
      //   StaarmPageRoute.routeTo(
      //     builder: (context) => SearchCarsView(
      //       location: _addr,
      //     ),
      //   ),
      // );
    }
  }

  void onPickUpSelected(PlaceModel plc) async {
    locationTextController.text = plc?.name ?? '';
    pickUpPlaces = [];
    selectedPickUpLocation =
        await _addrService.getAddressModelByPlaceId(plc.placeId, plc.name);

    showCupertinoModalBottomSheet(
      expand: true,
      context: appContext,
      isDismissible: false,
      useRootNavigator: true,
      enableDrag: false,
      backgroundColor: Colors.transparent,
      builder: (context) => SelectTripDateModalView(
        address: selectedPickUpLocation,
      ),
    );

    // Navigator.pushReplacement(
    //   appContext,
    //   StaarmPageRoute.routeTo(
    //     builder: (context) => SearchCarsView(
    //       location: selectedPickUpLocation,
    //     ),
    //   ),
    // );
  }

  Future<List<PlaceModel>> searchPickUpPlaces(String query) async {
    debouncer.run(() async {
      dynamic res = await _addrService.searchAddresses(query);

      pickUpPlaces = res;

      return res;
    });
  }

  void clearSearch() {
    locationTextController.clear();
    pickUpPlaces = [];
    notifyListeners();
  }
}
