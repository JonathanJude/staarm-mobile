import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:staarm_mobile/app/locator.dart';
import 'package:staarm_mobile/core/api/api_helpers.dart';
import 'package:staarm_mobile/core/providers/user_provider.dart';
import 'package:staarm_mobile/core/services/auth_service/auth_service.dart';
import 'package:staarm_mobile/core/services/kyc_service/kyc_service.dart';
import 'package:staarm_mobile/ui/base/base_view_model.dart';
import 'package:staarm_mobile/utils/staarm_app_notification.dart';
import 'package:staarm_mobile/utils/staarm_page_route.dart';

import '../nin/nin.dart';

class UploadKYCProfilePictureViewModel extends BaseViewModel {
  final _kycService = locator<KYCService>();
  final _authService = locator<AuthService>();
  final ImagePicker picker = ImagePicker();
  dynamic _pickImageError;

  XFile _imageFile;
  XFile get imageFile => _imageFile;
  set imageFile(XFile val) {
    _imageFile = val;
    notifyListeners();
  }

  void addPhoto() async {
    try {
      isLoading = true;
      final pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 60,
      );
      isLoading = false;
      imageFile = pickedFile;
    } catch (e) {
      _pickImageError = e;
    }
  }

  void uploadPhoto() async {
    if (imageFile == null) {
      StaarmAppNotification.error(message: 'Select a photo');
      return;
    }

    isLoading = true;
    dynamic res =
        await _authService.updateProfilePicture(profilePicture: imageFile);
    isLoading = false;

    APIHelpers.handleResponse(res, onSuccess: (response) async {
      StaarmAppNotification.success(message: 'Profile picture uploaded');

      UserProvider _userProvider =
          Provider.of<UserProvider>(appContext, listen: false);
      _userProvider.syncUser();

      Navigator.push(
        appContext,
        StaarmPageRoute.routeTo(
          builder: (context) => KYCNinView(
          ),
        ),
      );
    });
  }
}
