import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:staarm_mobile/app/locator.dart';
import 'package:staarm_mobile/app/storage_helper.dart';
import 'package:staarm_mobile/app/storage_keys.dart';
import 'package:staarm_mobile/core/api/api_helpers.dart';
import 'package:staarm_mobile/core/models/user.dart';
import 'package:staarm_mobile/core/providers/user_provider.dart';
import 'package:staarm_mobile/core/services/auth_service/auth_service.dart';
import 'package:staarm_mobile/ui/base/base_view_model.dart';
import 'package:staarm_mobile/ui/views/hosts/select_car/select_car_1/select_car_1.dart';
import 'package:staarm_mobile/ui/views/main_page/main_page.dart';
import 'package:staarm_mobile/utils/events/staarm_events.dart';
import 'package:staarm_mobile/utils/staarm_app_notification.dart';
import 'package:staarm_mobile/utils/staarm_page_route.dart';
import 'package:staarm_mobile/utils/user_identity_helper.dart';

class SignupViewModel extends BaseViewModel {
  final _authService = locator<AuthService>();
  // TextEditingController phoneNumberController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool _showPassword = false;
  bool get showPassword => _showPassword;
  set showPassword(bool val) {
    _showPassword = val;
    notifyListeners();
  }

  String _firstName;
  String get firstName => _firstName;
  set firstName(String val) {
    _firstName = val;
    notifyListeners();
  }

  String _lastName;
  String get lastName => _lastName;
  set lastName(String val) {
    _lastName = val;
    notifyListeners();
  }

  String _email;
  String get email => _email;
  set email(String val) {
    _email = val;
    notifyListeners();
  }

  String _password;
  String get password => _password;
  set password(String val) {
    _password = val;
    notifyListeners();
  }

  bool _fromHost;
  bool get fromHost => _fromHost;
  set fromHost(bool val) {
    _fromHost = val;
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

  void saveFirstName(String str) {
    firstName = str;
  }

  void saveLastName(String str) {
    lastName = str;
  }

  void saveEmail(String str) {
    email = str;
  }

  void savePassword(String str) {
    password = str;
  }


  void init({isFromHost = false}){
    fromHost = isFromHost;
  }

  void completeRegistration({
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
      dynamic res = await _authService.completeRegistration(
        phoneNumber: phoneNumber,
        email: email,
        firstName: firstName,
        lastName: lastName,
        password: password,
        passwordConfirmation: password,
        verificationId: verificationId,
      );
      isLoading = false;

      APIHelpers.handleResponse(res, onSuccess: (response) async {
        //save user
        UserModel _user = UserModel.fromJson(response.value['data']['user']);
        UserProvider _userProvider =
            Provider.of<UserProvider>(appContext, listen: false);
        _userProvider.saveUser(_user);
        _userProvider.isLoggedIn = true;

        //set user identity to third parties
        UserIdentityHelper.setUserIdentity(_user);

        //persist user token
        final String token = response.value['data']['token'];
        print("token : $token");
        StorageHelper.setString(StorageKeys.token, token);

        //trigger events
        mixPanel.logEvent(StaarmEvents.onSignupCompleted, logIntercom: true);

        // StaarmToast.success(message: 'Registration successful');

        if(fromHost){
           navigationService.navigatorKey.currentState.pushAndRemoveUntil(
          StaarmPageRoute.routeTo(
            builder: (context) => SelectCar1View(),
          ),
          (route) => false,
        );
        }else{
          navigationService.navigatorKey.currentState.pushAndRemoveUntil(
          StaarmPageRoute.routeTo(
            builder: (context) => MainPage(),
          ),
          (route) => false,
        );
        }
      }, onError: (error) {
        StaarmAppNotification.error(message: error.value['message']);
      });
    }
  }
}
