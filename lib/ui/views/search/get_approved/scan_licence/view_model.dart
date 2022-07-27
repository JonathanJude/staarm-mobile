

import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:staarm_mobile/app/locator.dart';
import 'package:staarm_mobile/core/api/api_helpers.dart';
import 'package:staarm_mobile/core/providers/user_provider.dart';
import 'package:staarm_mobile/core/services/kyc_service/kyc_service.dart';
import 'package:staarm_mobile/ui/base/base_view_model.dart';
import 'package:staarm_mobile/utils/staarm_app_notification.dart';
import 'package:staarm_mobile/utils/staarm_page_route.dart';

import '../licence_success.dart';

List<CameraDescription> cameras;

class KYCScanLicenceModel extends BaseViewModel {
  final _kycService = locator<KYCService>();
  final DateFormat dateRequestFormatter = DateFormat('dd/MM/yyyy');
  CameraController cameraController;

  bool _isFront = true;
  bool get isFront => _isFront;
  set isFront(bool val) {
    _isFront = val;
    notifyListeners();
  }

  bool _isOnCaptureMode = true;
  bool get isOnCaptureMode => _isOnCaptureMode;
  set isOnCaptureMode(bool val) {
    _isOnCaptureMode = val;
    notifyListeners();
  }

  bool _isFrontTaken = false;
  bool get isFrontTaken => _isFrontTaken;
  set isFrontTaken(bool val) {
    _isFrontTaken = val;
    notifyListeners();
  }

  bool _isBackTaken = false;
  bool get isBackTaken => _isBackTaken;
  set isBackTaken(bool val) {
    _isBackTaken = val;
    notifyListeners();
  }

  File _frontLicence;
  File get frontLicence => _frontLicence;
  set frontLicence(File val) {
    _frontLicence = val;
    notifyListeners();
  }

  File _backLicence;
  File get backLicence => _backLicence;
  set backLicence(File val) {
    _backLicence = val;
    notifyListeners();
  }

  // XFile _frontLicence;
  // XFile get frontLicence => _frontLicence;
  // set frontLicence(XFile val) {
  //   _frontLicence = val;
  //   notifyListeners();
  // }

  // XFile _backLicence;
  // XFile get backLicence => _backLicence;
  // set backLicence(XFile val) {
  //   _backLicence = val;
  //   notifyListeners();
  // }

  // void init() {
  //   loadCam();
  // }

  void init(List<CameraDescription> cameras) {
    try {
      onCameraSelected(cameras[0]);
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void dispose() {
    cameraController?.dispose();
    super.dispose();
  }

  void onCameraSelected(CameraDescription cameraDescription) async {
    if (cameraController != null) await cameraController.dispose();
    cameraController =
        CameraController(cameraDescription, ResolutionPreset.medium);

    cameraController.addListener(() {
      if (cameraController.value.hasError) {
        // showMessage('Camera Error: ${controller.value.errorDescription}');
      }
    });

    try {
      await cameraController.initialize();
    } on CameraException {
      // showException(e);
    }

    notifyListeners();
  }

  loadCam() async {
    try {
      cameras = await availableCameras();
    } on CameraException {
      //logError(e.code, e.description);
    }
  }

  onCapture() async {
    try {
      final path = join(
        (await getTemporaryDirectory()).path,
        '${DateTime.now()}.png',
      );

      await cameraController.takePicture(path);
      // XFile rawImage = await cameraController.takePicture();
      final rawImage = File(path);

      if (isFront) {
        frontLicence = rawImage;
        isOnCaptureMode = false;
      } else {
        backLicence = rawImage;
        isOnCaptureMode = false;
      }
    } catch (e) {
      print(e);
    }
  }

  void onSubmitPhoto(String verId) async {
    if (isFront) {
      if(frontLicence != null)
      isFrontTaken = true;
      isOnCaptureMode = true;
      isFront = false;
    } else {
      if(backLicence != null)
      isBackTaken = true;
      isOnCaptureMode = false;

      storeLicenceInfo(verId);
    }
  }

  void onRetakePhoto() async {
    if (isFront) {
      frontLicence = null;
      isFrontTaken = false;
      isOnCaptureMode = true;
    } else {
      backLicence = null;
      isBackTaken = false;
      isOnCaptureMode = true;
    }
  }

  void storeLicenceInfo(String driversLicenceVerificationId) async {
    if (frontLicence == null) {
      StaarmAppNotification.error(
          message: 'Please upload the front part of your licence');
      return;
    }

    if (backLicence == null) {
      StaarmAppNotification.error(
          message: 'Please upload the back part of your licence');
      return;
    }

    isLoading = true;
    dynamic res = await _kycService.storeDriversLicenceImages(
      driversLicenceFront: frontLicence,
      driversLicenceBack: backLicence,
      driversLicenceVerificationId: driversLicenceVerificationId,
    );
    isLoading = false;

    APIHelpers.handleResponse(res, onSuccess: (response) async {
      StaarmAppNotification.success(message: 'Licence information saved');

      //update user
      UserProvider _userProvider = Provider.of<UserProvider>(appContext, listen: false);
      _userProvider.syncUser();
      _userProvider.syncKYC();
      // UserModel _usr = _userProvider.user;


      Navigator.pushReplacement(
        appContext,
        StaarmPageRoute.routeTo(
          builder: (context) => LicenceSuccessView(),
        ),
      );
    });
  }
}
