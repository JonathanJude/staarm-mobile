import 'package:flutter/material.dart';
import 'package:staarm_mobile/app/locator.dart';
import 'package:staarm_mobile/core/api/api_helpers.dart';
import 'package:staarm_mobile/core/services/auth_service/auth_service.dart';
import 'package:staarm_mobile/ui/base/base_view_model.dart';
import 'package:staarm_mobile/ui/views/auth/confirm_phone_number/confirm_phone_number.dart';
import 'package:staarm_mobile/ui/views/auth/login/login.dart';
import 'package:staarm_mobile/utils/staarm_app_notification.dart';
import 'package:staarm_mobile/utils/staarm_modal_helpers.dart';

class LoginOrSignupViewModel extends BaseViewModel {
  final _authService = locator<AuthService>();
  // TextEditingController phoneNumberController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String _phoneNumber;
  String get phoneNumber => _phoneNumber;
  set phoneNumber(String val) {
    _phoneNumber = val;
    notifyListeners();
  }

  bool _fromHost = false;
  bool get fromHost => _fromHost;
  set fromHost(bool val) {
    _fromHost = val;
    notifyListeners();
  }

  String phoneNumberValidator(String str) {
    if (str.isEmpty) return 'Phone number is required';
    return null;
  }

  void savePhoneNumber(String str) {
    phoneNumber = str;
  }

  void init({bool isFromHost}){
    if(isFromHost != null){
      fromHost = isFromHost;
    }
  }

  void _handleResponse(dynamic data, [int code = 400]) {
    print("OnError from api response --- ${data.toString()}");

    if (data['message'].contains('Phone number has already been used')) {

      StaarmModalHelpers.fullpageModal(
          appContext,
          child: LoginView(
            phoneNumber: phoneNumber,
          ),
          title: 'Login',
        );

    } else {
      StaarmAppNotification.error(message: data['message']);
    }
  }

  void startRegistration() async {
    FormState form = formKey.currentState;

    if (form.validate()) {
      form.save();

      phoneNumber = '+234' + phoneNumber;

      if (phoneNumber == null || phoneNumber.isEmpty) {
        StaarmAppNotification.error(message: 'Phone number is Invalid.');
      }

      isLoading = true;
      dynamic res = await _authService.startPhoneNumberVerification(
          phoneNumber: phoneNumber,
          onError: (error, code) {
            _handleResponse(error.value, code);
          });
      isLoading = false;

      APIHelpers.handleResponse(res, onSuccess: (response) async {
        if (response.value['status'] == false) {
          _handleResponse(response.value);
        } else {
          int _verificationId = response.value['data']['verification_id'] ?? 0;

          print("success ${res.toString()}");

          StaarmModalHelpers.fullpageModal(
            appContext,
            child: ConfirmPhoneNumber(
              verificationId: _verificationId,
              phoneNumber: phoneNumber,
            ),
            title: 'Confirm your number',
          );
        }
      }, onError: (error) {
        print("errrr --- ${error.value.toString()}");
      StaarmAppNotification.error(message: error.value.errorMessage);
      });
    }
  }
}
