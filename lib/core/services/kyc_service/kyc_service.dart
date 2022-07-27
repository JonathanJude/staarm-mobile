
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:staarm_mobile/core/models/kyc_model.dart';

abstract class KYCService {
  Future<dynamic> storeNIN({
    @required String nin,
  });

  Future<dynamic> storeDriversLicence({
    @required String dob,
    @required String licenceNumber,
  });

  // Future<dynamic> storeDriversLicenceImages({
  //   @required File driversLicenceFront,
  //   @required File driversLicenceBack,
  //   @required String driversLicenceVerificationId,
  // });

  Future<dynamic> storeDriversLicenceImages({
    // @required XFile driversLicenceFront,
    // @required XFile driversLicenceBack,
    // @required String driversLicenceVerificationId,
    @required File driversLicenceFront,
    @required File driversLicenceBack,
    @required String driversLicenceVerificationId,
  });

  Future<KYCModel> getKYC();
}
