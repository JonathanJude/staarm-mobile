import 'package:flutter/material.dart';
import 'package:staarm_mobile/app/locator.dart';
import 'package:staarm_mobile/core/api/api_helpers.dart';
import 'package:staarm_mobile/core/services/auth_service/auth_service.dart';
import 'package:staarm_mobile/ui/base/base_view_model.dart';
import 'package:staarm_mobile/utils/staarm_app_notification.dart';

class ResetPasswordViewModel extends BaseViewModel {
  final _authService = locator<AuthService>();
  // TextEditingController phoneNumberController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool _showPassword = false;
  bool get showPassword => _showPassword;
  void togglePassword() {
    _showPassword = !_showPassword;
    notifyListeners();
  }

  String _password;
  String get password => _password;
  set password(String val) {
    _password = val;
    notifyListeners();
  }

  String _passwordConfirmation;
  String get passwordConfirmation => _passwordConfirmation;
  set passwordConfirmation(String val) {
    _passwordConfirmation = val;
    notifyListeners();
  }

  String fieldValidator(String str) {
    if (str.isEmpty) return 'This field is required';
    return null;
  }

  String emailValidator(String str) {
    if (str.isEmpty) return 'This field is required';
    return null;
  }

  void resetPassword({
    @required String phoneNumber,
    @required int verificationId,
  }) async {
    FormState form = formKey.currentState;

    if (form.validate()) {
      form.save();

      if (phoneNumber == null || phoneNumber.isEmpty) {
        StaarmAppNotification.error(message: 'Phone number is Invalid.');
      }

      isLoading = true;
      dynamic res = await _authService.passwordReset(
        phoneNumber: phoneNumber,
        password: password,
        passwordConfirmation: password,
        passwordResetRequestId: verificationId,
      );
      isLoading = false;

      APIHelpers.handleResponse(res, onSuccess: (response) async {
        Navigator.of(appContext).pop();
        Navigator.of(appContext).pop();

        // StaarmToast.success(message: 'Registration successful');
        Navigator.of(appContext).pop();

      }, onError: (error) {
        StaarmAppNotification.error(message: error.value['message']);
      });
    }
  }
}
