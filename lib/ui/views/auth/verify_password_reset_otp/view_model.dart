import 'package:flutter/material.dart';
import 'package:staarm_mobile/app/locator.dart';
import 'package:staarm_mobile/core/api/api_helpers.dart';
import 'package:staarm_mobile/core/services/auth_service/auth_service.dart';
import 'package:staarm_mobile/ui/base/base_view_model.dart';
import 'package:staarm_mobile/ui/views/auth/login/login.dart';
import 'package:staarm_mobile/ui/views/auth/reset_password/reset_password.dart';
import 'package:staarm_mobile/ui/views/auth/signup/signup.dart';
import 'package:staarm_mobile/utils/staarm_app_notification.dart';
import 'package:staarm_mobile/utils/staarm_modal_helpers.dart';
import 'package:staarm_mobile/utils/staarm_page_route.dart';
import 'package:staarm_mobile/utils/staarm_toast.dart';

class VerifyPasswordResetOTPViewModel extends BaseViewModel {
  final _authService = locator<AuthService>();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String _otp;
  String get otp => _otp;
  set otp(String val) {
    _otp = val;
    notifyListeners();
  }

  void verifyResetPasswordRequest({
    @required int verificationId,
    @required String phoneNumber,
  }) async {
    if (otp == null || otp.isEmpty) {
      StaarmAppNotification.error(message: 'OTP is Invalid.');
      return;
    }

    isLoading = true;
    dynamic res = await _authService.verifyResetRequest(
      phoneNumber: phoneNumber,
      otp: otp,
      passwordResetRequestId: verificationId,
    );
    isLoading = false;

    print("Verification --- ${res.toString()}");


    APIHelpers.handleResponse(res, onSuccess: (response) async {

      StaarmToast.success(message: 'Phone number verified');

       StaarmModalHelpers.fullpageModal(
          appContext,
          child: ResetPasswordView(
            verificationId: verificationId,
            phoneNumber: phoneNumber,
          ),
          title: 'Reset password',
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
