import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:staarm_mobile/app/locator.dart';
import 'package:staarm_mobile/core/api/api_helpers.dart';
import 'package:staarm_mobile/core/services/kyc_service/kyc_service.dart';
import 'package:staarm_mobile/styles/colors.dart';
import 'package:staarm_mobile/ui/base/base_view_model.dart';
import 'package:staarm_mobile/ui/views/search/get_approved/scan_licence/scan_licence.dart';
import 'package:staarm_mobile/utils/staarm_app_notification.dart';
import 'package:staarm_mobile/utils/staarm_page_route.dart';

List<CameraDescription> cameras;

class KYCDriverslicenceViewModel extends BaseViewModel {
  final _kycService = locator<KYCService>();
  final DateFormat dateRequestFormatter = DateFormat('dd/MM/yyyy');
  final DateFormat apiRequestFormatter = DateFormat('dd-MM-yyyy');

  String _licenceNumber = '';
  String get licenceNumber => _licenceNumber;
  set licenceNumber(String val) {
    _licenceNumber = val;
    notifyListeners();
  }

  DateTime _selectedDate;
  DateTime get selectedDate => _selectedDate;
  set selectedDate(DateTime val) {
    _selectedDate = val;
    notifyListeners();
  }

  String get formattedDOB {
    if (selectedDate == null) return '--/--/----';
    return dateRequestFormatter.format(selectedDate);
  }

  void init() {
    loadCam();
  }

  loadCam() async {
    try {
      cameras = await availableCameras();
    } on CameraException {
      //logError(e.code, e.description);
    }
  }

  void showDatePicker() async {
    final today = DateTime.now();
    final pastDate = DateTime(today.year - 80, 1, 1);

    final DateTime picked = await DatePicker.showDatePicker(
      appContext,
      showTitleActions: true,
      maxTime: DateTime(today.year, today.month, today.day),
      minTime: DateTime(pastDate.year, pastDate.month, pastDate.day),
      currentTime: _selectedDate,
      locale: LocaleType.en,
      theme: DatePickerTheme(
        doneStyle: TextStyle(
          color: AppColors.mainPurple,
        ),
      ),
    );

    if (picked != null && picked != selectedDate) selectedDate = picked;
  }

  void storeLicenceInfo(List<CameraDescription> cameras) async {
    if (licenceNumber == null || licenceNumber.isEmpty) {
      StaarmAppNotification.error(message: 'Please enter your Licence Number');
      return;
    }

    if (selectedDate == null) {
      StaarmAppNotification.error(message: 'Please enter your Date of Birth');
      return;
    }

    String _dobFormatted = apiRequestFormatter.format(selectedDate);

    isLoading = true;
    dynamic res = await _kycService.storeDriversLicence(
        dob: _dobFormatted, licenceNumber: licenceNumber);
    isLoading = false;

    APIHelpers.handleResponse(res, onSuccess: (response) async {
      if (response.value['data']['drivers_licence_verification_id'] != null) {
        StaarmAppNotification.success(message: 'Licence information saved');
        String _verId =
            response.value['data']['drivers_licence_verification_id'];

        Navigator.push(
          appContext,
          StaarmPageRoute.routeTo(
            builder: (context) => KYCScanLicence(
              cameras: cameras,
              driversLicenceVerificationId: _verId,
            ),
          ),
        );
      } else {
        StaarmAppNotification.error(
            message: 'Error getting Licence information');
      }
    });
  }
}
