import 'package:flutter/material.dart';
import 'package:staarm_mobile/app/locator.dart';
import 'package:staarm_mobile/core/api/api_helpers.dart';
import 'package:staarm_mobile/core/services/auth_service/auth_service.dart';
import 'package:staarm_mobile/core/services/user_cache_service/user_cache_service.dart';
import 'package:staarm_mobile/ui/base/base_view_model.dart';
import 'package:staarm_mobile/utils/app_helper.dart';
import 'package:staarm_mobile/utils/staarm_app_notification.dart';

import '../../../../main.dart';

class LoginViewModel extends BaseViewModel {
  final _authService = locator<AuthService>();
  final _userCacheService = locator<UserCacheService>();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController phoneNumberController;

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

  String _phoneNumber;
  String get phoneNumber => _phoneNumber;
  set phoneNumber(String val) {
    _phoneNumber = val;
    notifyListeners();
  }

  bool _fromHost;
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

  void init(
    String phone, {
    bool isFromHost = false,
  }) {
    fromHost = isFromHost;
    // phoneNumber = phone ?? '';

    String _formated = (phone ?? '').replaceAll('+234', '');
    phoneNumberController = TextEditingController(text: _formated ?? '');
  }

  void login() async {
    FormState form = formKey.currentState;

    if (form.validate()) {
      form.save();

      phoneNumber = '+234' + phoneNumber;

      if (phoneNumber == null || phoneNumber.isEmpty) {
        StaarmAppNotification.error(message: 'Phone number is Invalid.');
        return;
      }

      if (password == null || password.isEmpty) {
        StaarmAppNotification.error(message: 'Please, enter your password');
        return;
      }

      isLoading = true;
      dynamic res = await _authService.login(
        phoneNumber: phoneNumber,
        password: password,
      );
      isLoading = false;

      print("Verification --- ${res.toString()}");

      APIHelpers.handleResponse(res, onSuccess: (response) async {
        dynamic data = response.value['data'];
        // _userService.cacheUser(data);
        _userCacheService.cacheUser(response.value);

        // final String token = data['person']['token'];

        // StorageHelper.setString(StorageKeys.token, token);
        // Model user = PersonModel.fromJson(data['person']);

        //has saved token?
        String t = prefs.getString('loggedInToken');

        AppHelper.loginUser(appContext, response.value);
        // .then((check) async {
        //   if (check) {

        //     Navigator.pushReplacement(
        //       appContext,
        //       StaarmPageRoute.routeTo(
        //         builder: (context) => MainPage(),
        //       ),
        //     );
        //   } else {
        //     StaarmAppNotification.error(message: 'Error occurred');
        //   }

        // //cache user details
        // _userCacheService.cacheUser(response);
        // //save user
        // UserModel _user = UserModel.fromJson(response.value['data']['user']);
        // UserProvider _userProvider =
        //     Provider.of<UserProvider>(appContext, listen: false);
        // _userProvider.saveUser(_user);
        // _userProvider.isLoggedIn = true;

        // //set user identity to third parties
        // UserIdentityHelper.setUserIdentity(_user);

        // //persist user token
        // final String token = response.value['data']['token'];
        // print("token : $token");
        // StorageHelper.setString(StorageKeys.token, token);

        // // StaarmToast.success(message: 'Login successful');

        // AppHelper.syncProviders();

        // if (fromHost) {
        //   navigationService.navigatorKey.currentState.pushAndRemoveUntil(
        //     StaarmPageRoute.routeTo(
        //       builder: (context) => SelectCar1View(),
        //     ),
        //     (route) => false,
        //   );
        // } else {
        //   navigationService.navigatorKey.currentState.pushAndRemoveUntil(
        //     StaarmPageRoute.routeTo(
        //       builder: (context) => MainPage(),
        //     ),
        //     (route) => false,
        //   );
        // }
      }, onError: (error) {
        print("errrr --- ${error.value.toString()}");
        StaarmAppNotification.error(message: error.value.errorMessage);
      });
    }
  }
}
