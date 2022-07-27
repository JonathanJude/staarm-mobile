import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:staarm_mobile/app/locator.dart';
import 'package:staarm_mobile/core/api/api_helpers.dart';
import 'package:staarm_mobile/core/providers/user_provider.dart';
import 'package:staarm_mobile/core/services/auth_service/auth_service.dart';
import 'package:staarm_mobile/core/services/kyc_service/kyc_service.dart';
import 'package:staarm_mobile/ui/base/base_view_model.dart';
import 'package:staarm_mobile/utils/staarm_app_notification.dart';

class ProfileHomeViewModel extends BaseViewModel {
  Future<void> init() async {
    //
  }

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

  bool _isUploadingPhoto = false;
  bool get isUploadingPhoto => _isUploadingPhoto;
  set isUploadingPhoto(bool val) {
    _isUploadingPhoto = val;
    notifyListeners();
  }

  Future<void> addPhoto() async {
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

    await addPhoto();
    if (imageFile == null) {
      StaarmAppNotification.error(message: 'Select a photo');
      return;
    }

    isUploadingPhoto = true;
    dynamic res =
        await _authService.updateProfilePicture(profilePicture: imageFile);
    isUploadingPhoto = false;

    APIHelpers.handleResponse(res, onSuccess: (response) async {
      StaarmAppNotification.success(message: 'Profile picture uploaded');

      UserProvider _userProvider =
          Provider.of<UserProvider>(appContext, listen: false);
      _userProvider.syncUser();
    });
  }
}
