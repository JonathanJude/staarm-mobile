import 'package:flutter/material.dart';
import 'package:staarm_mobile/app/locator.dart';
import 'package:staarm_mobile/core/api/api_helpers.dart';
import 'package:staarm_mobile/core/services/auth_service/auth_service.dart';
import 'package:staarm_mobile/ui/base/base_view_model.dart';
import 'package:staarm_mobile/ui/views/auth/signup/signup.dart';
import 'package:staarm_mobile/utils/staarm_app_notification.dart';
import 'package:staarm_mobile/utils/staarm_modal_helpers.dart';
import 'package:staarm_mobile/utils/staarm_toast.dart';

class ConfirmPhoneNumberViewModel extends BaseViewModel {
  final _authService = locator<AuthService>();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String _otp;
  String get otp => _otp;
  set otp(String val) {
    _otp = val;
    notifyListeners();
  }

  bool _fromHost;
  bool get fromHost => _fromHost;
  set fromHost(bool val) {
    _fromHost = val;
    notifyListeners();
  }

  void init({isFromHost = false}){
    fromHost = isFromHost;
  }

  void completePhoneNumberRegistration({
    @required int verificationId,
    @required String phoneNumber,
  }) async {
    if (otp == null || otp.isEmpty) {
      StaarmAppNotification.error(message: 'OTP is Invalid.');
      return;
    }

    isLoading = true;
    dynamic res = await _authService.completePhoneNumberVerification(
      phoneNumber: phoneNumber,
      otp: otp,
      verificationId: verificationId,
    );
    isLoading = false;

    print("Verification --- ${res.toString()}");


    APIHelpers.handleResponse(res, onSuccess: (response) async {

      StaarmToast.success(message: 'Phone number verified');

       StaarmModalHelpers.fullpageModal(
          appContext,
          child: SignupView(
            verificationId: verificationId,
            phoneNumber: phoneNumber,
          ),
          title: 'Sign up',
        );

    }, onError: (error) {
      StaarmAppNotification.error(message: error.value['message']);
    });
  }

  void resendPhoneNumberOTP({
    @required int verificationId,
    @required String phoneNumber,
  }) async {
    if (_otp == null || _otp.isEmpty) {
      StaarmAppNotification.error(message: 'OTP is Invalid.');
      return;
    }

    isLoading = true;
    dynamic res = await _authService.resendPhoneNumberVerification(
      phoneNumber: phoneNumber,
      verificationId: verificationId,
    );
    isLoading = false;

    APIHelpers.handleResponse(res, onSuccess: (response) async {
      StaarmAppNotification.success(message: "OTP was sent successfully");
    }, onError: (error) {
      StaarmAppNotification.error(message: error.value['message']);
    });
  }
}
