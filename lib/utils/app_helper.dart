import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:provider/provider.dart';
import 'package:staarm_mobile/app/locator.dart';
import 'package:staarm_mobile/app/storage_helper.dart';
import 'package:staarm_mobile/app/storage_keys.dart';
import 'package:staarm_mobile/core/models/user.dart';
import 'package:staarm_mobile/core/providers/payment_provider.dart';
import 'package:staarm_mobile/core/providers/user_provider.dart';
import 'package:staarm_mobile/core/providers/vehicle_provider.dart';
import 'package:staarm_mobile/core/services/navigator_service.dart';
import 'package:staarm_mobile/core/services/user_cache_service/user_cache_service.dart';
import 'package:staarm_mobile/styles/colors.dart';
import 'package:staarm_mobile/ui/views/hosts/select_car/select_car_1/select_car_1.dart';
import 'package:staarm_mobile/ui/views/main_page/main_page.dart';
import 'package:staarm_mobile/utils/staarm_page_route.dart';
import 'package:staarm_mobile/widgets/dialogs/delete_dialog.dart';

import 'user_identity_helper.dart';

class AppHelper {
  AppHelper._();

  static void syncProviders() async {
    print("Syncing Providers");
    final _navigationService = locator<NavigationService>();

    final appContext = _navigationService.navigatorKey.currentContext;
    PaymentProvider _paymentProvider =
        Provider.of<PaymentProvider>(appContext, listen: false);

    await _paymentProvider.syncBankList();
    await _paymentProvider.syncCards();
    await _paymentProvider.syncBanks();

    VehicleProvider _vehicleProvider =
        Provider.of<VehicleProvider>(appContext, listen: false);

    UserProvider _userProvider =
        Provider.of<UserProvider>(appContext, listen: false);

    await _vehicleProvider.syncVehicleData(appContext);
    await _vehicleProvider.syncHostsVehicles();
    await _vehicleProvider.syncFavorites();
    await _vehicleProvider.syncProtectionPlans();
    await _userProvider.syncKYC();
    await _userProvider.syncUser();
    print("End Syncing Providers");
  }

  static void showPicker<T>(
    BuildContext ctx, {
    @required List<T> items,
    @required List<Widget> dropdownItem,
    @required Function(T) onSelect,
  }) {
    final size = MediaQuery.of(ctx).size;

    showCupertinoModalPopup(
      context: ctx,
      builder: (_) => Container(
        height: size.height * .3,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
        ),
        child: CupertinoPicker(
          backgroundColor: Colors.white,
          itemExtent: 25,
          squeeze: 1.0,
          scrollController: FixedExtentScrollController(initialItem: 0),
          useMagnifier: true,
          children: dropdownItem,
          onSelectedItemChanged: (value) {
            T _selected = items[value];
            onSelect(_selected);
          },
        ),
      ),
    );
  }

  static int getDaysBetweenDates(DateTime startDate, DateTime endDate) {
    if (startDate == null || endDate == null) {
      return 0;
    }

    int diff = endDate.difference(startDate).inDays;

    return diff;
  }

  static num getTripAmountByPeriod(
      num amount, DateTime startDate, DateTime endDate) {
    if (amount == null || startDate == null || endDate == null) {
      return 0;
    }

    int period = getDaysBetweenDates(startDate, endDate);
    num _amountPerDay = (amount * period) ?? 0;

    return _amountPerDay;
  }

  static void showDatePicker(
    BuildContext context, {
    @required DateTime currentDate,
    @required Function(DateTime) onSelected,
    DateTime minDate,
    DateTime maxDate,
  }) async {
    final today = DateTime.now();
    final pastDate = DateTime(today.year - 80, 1, 1);

    final DateTime picked = await DatePicker.showDatePicker(
      context,
      showTitleActions: true,
      // maxTime: maxDate ?? DateTime(today.year, today.month, today.day),
      // minTime: minDate ?? DateTime(pastDate.year, pastDate.month, pastDate.day),
      minTime: minDate,
      maxTime: maxDate,
      currentTime: currentDate,
      locale: LocaleType.en,
      theme: DatePickerTheme(
        doneStyle: TextStyle(
          color: AppColors.mainPurple,
        ),
      ),
    );

    if (picked != null && picked != currentDate) {
      onSelected(picked);
    }
  }

  static void showTimePicker(
    BuildContext context, {
    @required DateTime currentTime,
    @required Function(DateTime) onSelected,
  }) async {
    final today = DateTime.now();
    final pastDate = DateTime(today.year - 5, 1, 1);

    final DateTime picked = await DatePicker.showTime12hPicker(context,
        showTitleActions: true,
        currentTime: currentTime,
        locale: LocaleType.en,
        theme:
            DatePickerTheme(doneStyle: TextStyle(color: AppColors.mainPurple)));

    if (picked != null && picked != currentTime) {
      onSelected(picked);
    }
  }

  static List<String> get getCarFeatures => [
        'All-wheel Drive',
        // 'Apple car play'
        //     'Android auto',
        'Aux input',
        'Backup camera',
        'Blindspot warning',
        'Bluetooth',
        'Child seat',
        'Convertible',
        'Gps',
        'Heated seats',
        'Longterm rental',
        'Pet friendly',
        // 'Sunroof',
        // 'Toll pass',
        'USB charger'
      ];

  static void cancelVehicleCreation(BuildContext context) {
    DeleteBottomSheet.show(
      context: context,
      title: 'Leave this screen',
      text: 'Are you sure you want to stop?',
      yesTitle: 'YES',
      noTitle: 'NO',
      onTap: () {
        VehicleProvider _vehicleProvider =
            Provider.of<VehicleProvider>(context, listen: false);
        _vehicleProvider.syncHostsVehicles();

        Navigator.of(context).pushAndRemoveUntil(
          StaarmPageRoute.routeTo(
            builder: (context) => MainPage(),
          ),
          (route) => false,
        );
      },
    );
  }

  static Future<bool> loginUser(
    BuildContext context,
    Map<String, dynamic> data, {
    bool fromHost = false,
  }) {
    final completer = Completer<bool>();

    final _userCacheService = locator<UserCacheService>();
    final _navigationService = locator<NavigationService>();
    //cache user details
    _userCacheService.cacheUser(data);
    //save user
    UserModel _user = UserModel.fromJson(data['data']['user']);
    UserProvider _userProvider =
        Provider.of<UserProvider>(context, listen: false);
    _userProvider.saveUser(_user);
    _userProvider.isLoggedIn = true;

    //set user identity to third parties
    UserIdentityHelper.setUserIdentity(_user);

    //persist user token
    final String token = data['data']['token'];
    print("token : $token");
    StorageHelper.setString(StorageKeys.token, token);

    AppHelper.syncProviders();

    if (fromHost) {
      _navigationService.navigatorKey.currentState.pushAndRemoveUntil(
        StaarmPageRoute.routeTo(
          builder: (context) => SelectCar1View(),
        ),
        (route) => false,
      );
    } else {
      _navigationService.navigatorKey.currentState.pushAndRemoveUntil(
        StaarmPageRoute.routeTo(
          builder: (context) => MainPage(),
        ),
        (route) => false,
      );
    }

    completer.complete(true);
    return completer.future;
  }

  static String getDateFromDateTime(DateTime date){
    return "${date.year}-${date.month}-${date.day}";
  }
}
