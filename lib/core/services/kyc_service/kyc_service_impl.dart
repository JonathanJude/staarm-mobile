
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:staarm_mobile/core/api/service_state.dart';
import 'package:staarm_mobile/core/endpoints/endpoints.dart';
import 'package:staarm_mobile/core/exceptions/unknown_exception.dart';
import 'package:staarm_mobile/core/models/kyc_model.dart';
import 'package:staarm_mobile/core/services/http_helper.dart/http_helper.dart';

import 'kyc_service.dart';

class KYCServiceImpl extends KYCService {
  HttpHelper httpHelper;
  KYCServiceImpl({@required this.httpHelper}) : assert(httpHelper != null);

  final _log = Logger('KYCServiceImpl');

  @override
  Future<dynamic> storeNIN({
    @required String nin,
  }) async {
    try {
      Map<String, dynamic> _data = {
        'nin': nin,
      };

      final jsonData = await httpHelper.post(
        Endpoints.kycNIN,
        body: _data,
      );

      _log.fine(jsonData.toString());
      print(jsonData.toString());

      return jsonData;
    } on Exception {
      _log.severe('Error occured');
      throw const UnknownException();
    }
  }

  @override
  Future<dynamic> storeDriversLicence({
    @required String dob,
    @required String licenceNumber,
  }) async {
    try {
      Map<String, dynamic> _data = {
        'dob': dob,
        'licence_number': licenceNumber,
      };

      final jsonData = await httpHelper.post(
        Endpoints.kycDriversLicence,
        body: _data,
      );

      _log.fine(jsonData.toString());
      print(jsonData.toString());

      return jsonData;
    } on Exception {
      _log.severe('Error occured');
      throw const UnknownException();
    }
  }

  @override
  Future<dynamic> storeDriversLicenceImages({
    // @required XFile driversLicenceFront,
    // @required XFile driversLicenceBack,
    // @required String driversLicenceVerificationId,
    @required File driversLicenceFront,
    @required File driversLicenceBack,
    @required String driversLicenceVerificationId,
  }) async {
    try {
      //handle files
      dynamic _data = FormData.fromMap(
        {
          'drivers_licence_verification_id': driversLicenceVerificationId,
          'drivers_licence_front':
              MultipartFile.fromFileSync(driversLicenceFront.path),
          'drivers_licence_back':
              MultipartFile.fromFileSync(driversLicenceBack.path),
        },
        // ListFormat.multiCompatible,
      );

      final jsonData = await httpHelper.post(
        Endpoints.kycDriversLicenceImages,
        body: _data,
        useMultiPart: true,
      );

      _log.fine(jsonData.toString());
      print(jsonData.toString());

      return jsonData;
    } on Exception {
      _log.severe('Error occured');
      throw const UnknownException();
    }
  }

   @override
  Future<KYCModel> getKYC() async {
    try {
      final jsonData = await httpHelper.get(Endpoints.kyc);

      _log.fine(jsonData.toString());

      if (jsonData is SuccessState) {
        final mapResponse = jsonData.value;
        if (mapResponse["data"] != null) {
          KYCModel _user = KYCModel.fromJson(mapResponse["data"]);
          return _user;
        }
        return null;
      } else {
        return null;
      }
    } on Exception {
      _log.severe('Error occured when getting kyc');
      throw const UnknownException();
    }
  }
}
