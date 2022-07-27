import 'package:flutter/material.dart';
import 'package:google_place/google_place.dart';
import 'package:logging/logging.dart';

import '../../../utils/constants.dart';
import '../../models/address_model.dart';
import '../http_helper.dart/http_helper.dart';
import 'address_service.dart';

class AddressServiceImpl extends AddressService {
  HttpHelper httpHelper;
  AddressServiceImpl({@required this.httpHelper}) : assert(httpHelper != null);

  final _log = Logger('AddressServiceImpl');
  var googlePlace = GooglePlace(kGoogleApiKey);

  @override
  Future<List<PlaceModel>> searchAddresses(String placeName) async {
    AutocompleteResponse result = await googlePlace.queryAutocomplete.get(placeName);
    if(result?.status != null && result?.status == 'OK' && result.predictions.length > 0){
      return result.predictions.map((e){
        return PlaceModel(
          name: e.description,
          placeId: e.placeId,
        );
      }).toList();
    }

    return [];
  }

  @override
  Future<AddressModel> getAddressModelByPlaceId(String placeId, String name) async {

    DetailsResponse detail = await googlePlace.details.get(placeId);

    Geometry _geo = detail.result.geometry;

    if(_geo != null){
      AddressModel _addr = AddressModel(
        lat: _geo.location.lat,
        lng: _geo.location.lng,
        name: name,
      );

      return _addr;
    }

    return null;
  }
}
