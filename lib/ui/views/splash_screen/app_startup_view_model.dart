import 'package:flutter/material.dart';
import 'package:intercom_flutter/intercom_flutter.dart';
import 'package:provider/provider.dart';
import 'package:staarm_mobile/app/locator.dart';
import 'package:staarm_mobile/core/providers/location_provider.dart';
import 'package:staarm_mobile/core/services/user_cache_service/user_cache_service.dart';
import 'package:staarm_mobile/utils/app_helper.dart';
import 'package:staarm_mobile/utils/staarm_page_route.dart';

import '../../base/base_view_model.dart';
import '../main_page/main_page.dart';

class AppStartupViewModel extends BaseViewModel {
  // final _locationService = locator<LocationService>();
  final _userCacheService = locator<UserCacheService>();

  bool _isChecking = true;
  bool get isChecking => _isChecking;

  set isChecking(bool val) {
    _isChecking = val;
    notifyListeners();
  }

  void _navigateToLogin() {
    Navigator.push(
      appContext,
      StaarmPageRoute.routeTo(
        builder: (context) => MainPage(),
        // builder: (context) => GettingStartedView(),
      ),
    );
  }

  void handleCacheLogic() async {
    try {
      dynamic _data = await _userCacheService.getCacheUser();

      if (_data != null) {
        bool res = await AppHelper.loginUser(appContext, _data);

        if (res) {
          //reValidateUserCache
          _userCacheService.revalidateCache();

          Navigator.pushReplacement(
            appContext,
            StaarmPageRoute.routeTo(
              builder: (context) => MainPage(),
            ),
          );
        } else {
          _navigateToLogin();
        }
      }
    } catch (e) {
      _navigateToLogin();
    }
  }

  void init() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final _appContext = navigationService.navigatorKey.currentContext;

      await Future.delayed(Duration(seconds: 1));

      Intercom.registerUnidentifiedUser();

      AppHelper.syncProviders();

      // await _retriveLocation();

      try {
        //check if user has a cache
        bool _userHasACache = await _userCacheService.checkIfCacheUserExists();

        if (_userHasACache) {
          handleCacheLogic();
        } else {
          // take user to login page

          _navigateToLogin();
        }
      } catch (e) {
        print("UserCache --- Error trying to check user ${e.toString()}");
      }

      Navigator.push(
        _appContext,
        StaarmPageRoute.routeTo(
          builder: (context) => MainPage(),
          // builder: (context) => GettingStartedView(),
        ),
      );

      // StaarmModalHelpers.fullpageModal(
      //   _appContext,
      //   child: LoginOrSignupView(),
      //   title: 'Log in or sign up',
      // );
    });
  }

  Future<void> _retriveLocation() async {
    //get location permission
    // await _locationService.requestLocationPermission();

    //location stream
    LocationProvider _locProvider = Provider.of<LocationProvider>(
      appContext,
      listen: false,
    );

    // LocationData _loc = await _locationService.getLocation();
    // _locProvider.locationData = _loc;

    // _locProvider.onLocationChange();
  }
}
