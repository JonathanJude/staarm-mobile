import 'package:flutter/material.dart';
import 'package:staarm_mobile/app/locator.dart';
import 'package:staarm_mobile/core/models/kyc_model.dart';
import 'package:staarm_mobile/core/models/user.dart';
import 'package:staarm_mobile/core/models/vehicle/vehicle_model.dart';
import 'package:staarm_mobile/core/services/auth_service/auth_service.dart';
import 'package:staarm_mobile/core/services/kyc_service/kyc_service.dart';

class UserProvider extends ChangeNotifier {
  final _kycService = locator<KYCService>();
  final _authService = locator<AuthService>();

  bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;
  set isLoggedIn(bool val) {
    _isLoggedIn = val;
    notifyListeners();
  }

  UserModel _user;
  UserModel get user => _user;
  set user(UserModel val) {
    _user = val;
    notifyListeners();
  }

  KYCModel _kyc;
  KYCModel get kyc => _kyc;
  set kyc(KYCModel val) {
    _kyc = val;
    notifyListeners();
  }

  void saveUser(UserModel val) {
    _user = val;
    notifyListeners();
  }

  bool _isSyncingKYC = false;
  bool get isSyncingKYC => _isSyncingKYC;
  set isSyncingKYC(bool val) {
    _isSyncingKYC = val;
    notifyListeners();
  }

  bool _isSyncingUser = false;
  bool get isSyncingUser => _isSyncingUser;
  set isSyncingUser(bool val) {
    _isSyncingUser = val;
    notifyListeners();
  }

  Future<void> syncKYC() async {
    try {
      isSyncingKYC = true;
      dynamic res = await _kycService.getKYC();
      isSyncingKYC = false;

      if (res != null) {
        kyc = res;
      }
      notifyListeners();
    } catch (e) {
      print("error syncing kyc: ${e.toString()}");
    }
  }

  Future<void> syncUser() async {
    try {
      isSyncingUser = true;
      dynamic res = await _authService.getUser();
      isSyncingUser = false;

      if (res != null) {
        user = res;
      }
      notifyListeners();
    } catch (e) {
      print("error syncing user: ${e.toString()}");
    }
  }

  //getting verified
  VehicleModel _tempVehicle;
  VehicleModel get tempVehicle => _tempVehicle;
  set tempVehicle(VehicleModel val) {
    _tempVehicle = val;
    notifyListeners();
  }

  DateTime _tempTripStartDate;
  DateTime get tempTripStartDate => _tempTripStartDate;
  set tempTripStartDate(DateTime val) {
    _tempTripStartDate = val;
    notifyListeners();
  }

  DateTime _tempTripEndDate;
  DateTime get tempTripEndDate => _tempTripEndDate;
  set tempTripEndDate(DateTime val) {
    _tempTripEndDate = val;
    notifyListeners();
  }

  DateTime _tempTripStartTime;
  DateTime get tempTripStartTime => _tempTripStartTime;
  set tempTripStartTime(DateTime val) {
    _tempTripStartTime = val;
    notifyListeners();
  }

  DateTime _tempTripEndTime;
  DateTime get tempTripEndTime => _tempTripEndTime;
  set tempTripEndTime(DateTime val) {
    _tempTripEndTime = val;
    notifyListeners();
  }

  bool _verifyingFromBookingScreen = false;
  bool get verifyingFromBookingScreen => _verifyingFromBookingScreen;
  set verifyingFromBookingScreen(bool val) {
    _verifyingFromBookingScreen = val;
    notifyListeners();
  }

  bool get tempPropertiesAvailable {
    if (_tempVehicle != null &&
        _tempTripStartDate != null &&
        _tempTripEndDate != null &&
        _tempTripStartTime != null &&
        _tempTripEndTime != null) {
      return true;
    } else {
      return false;
    }
  }

  void clearVerifyFromBooking() {
    verifyingFromBookingScreen = false;
    tempVehicle = null;
    tempTripStartDate = null;
    tempTripEndDate = null;
    tempTripStartTime = null;
    tempTripEndTime = null;
  }
}
