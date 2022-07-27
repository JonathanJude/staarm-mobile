import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:staarm_mobile/config_reader.dart';
import 'package:staarm_mobile/core/api/service_state.dart';
import 'package:staarm_mobile/core/exceptions/unknown_exception.dart';
import 'package:staarm_mobile/core/models/prediction.dart';
import 'package:staarm_mobile/core/services/google_service/google_service.dart';
import 'package:staarm_mobile/core/services/http_helper.dart/http_helper.dart';


class GoogleServiceImpl extends GoogleService {
  HttpHelper httpHelper;
  GoogleServiceImpl({@required this.httpHelper}) : assert(httpHelper != null);

  final _log = Logger('GoogleServiceImpl');

  @override
  Future<List<AddressPrediction>> getSearchPredictions(String placeName)async {
    try {
      final jsonData = await httpHelper.get(
          'https://maps.googleapis.com/maps/api/place/autocomplete/json?input='
              '$placeName&key=${ConfigReader.getMapsApiKey()}'
              '&sessiontoken=123456789&components=country:ng'
      );

      _log.fine(jsonData.toString());

      if (jsonData is SuccessState) {
        final mapResponse = jsonData.value;
        print(mapResponse);
        List<AddressPrediction> _dataList = [];

        if (mapResponse['status'] != 'OK') {
          _dataList = [];
        } else {
          _dataList = mapResponse['predictions'].map<AddressPrediction>((json) {
            return AddressPrediction.fromJson(json);
          }).toList();
        }

        return _dataList;
      } else {
        return null;
      }
    } on Exception {
      _log.severe('Error occured');
      throw const UnknownException();
    }
  }
}
