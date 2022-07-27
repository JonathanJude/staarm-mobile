import 'package:flutter/material.dart';
import 'package:staarm_mobile/app/locator.dart';
import 'package:staarm_mobile/core/api/api_helpers.dart';
import 'package:staarm_mobile/core/services/auth_service/auth_service.dart';
import 'package:staarm_mobile/core/services/kyc_service/kyc_service.dart';
import 'package:staarm_mobile/ui/base/base_view_model.dart';
import 'package:staarm_mobile/ui/views/search/get_approved/drivers_licence/drivers_license.dart';
import 'package:staarm_mobile/utils/staarm_app_notification.dart';
import 'package:staarm_mobile/utils/staarm_page_route.dart';


class KYCNinViewModel extends BaseViewModel {
  final _kycService = locator<KYCService>();
  final _authService = locator<AuthService>();

  String _nin = '';
  String get nin => _nin;
  set nin(String val) {
    _nin = val;
    notifyListeners();
  }

  void storeNIN() async {
    if (nin == null || nin.isEmpty) {
      StaarmAppNotification.error(message: 'Please enter your NIN');
      return;
    }

    isLoading = true;
    dynamic res = await _kycService.storeNIN(nin: nin);
    isLoading = false;

    APIHelpers.handleResponse(res, onSuccess: (response) async {
      StaarmAppNotification.success(message: 'NIN saved successfully');

      Navigator.push(
        appContext,
        StaarmPageRoute.routeTo(
          builder: (context) => KYCDriverslicenceView(
          ),
        ),
      );
    });
  }
}
