
import 'package:staarm_mobile/core/models/address_model.dart';

abstract class AddressService {
  Future<List<PlaceModel>> searchAddresses(String placeName);
  Future<AddressModel> getAddressModelByPlaceId(String placeId, String name);
}
