import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:staarm_mobile/app/locator.dart';
import 'package:staarm_mobile/core/api/api_helpers.dart';
import 'package:staarm_mobile/core/services/vehicle_service/vehicle_service.dart';
import 'package:staarm_mobile/ui/base/base_view_model.dart';
import 'package:staarm_mobile/ui/views/hosts/select_car/car_features/car_features.dart';
import 'package:staarm_mobile/ui/views/hosts/select_car/upload_photos/upload_photos.dart';
import 'package:staarm_mobile/utils/english_asset_picker_delegate.dart';
import 'package:staarm_mobile/utils/staarm_app_notification.dart';
import 'package:staarm_mobile/utils/staarm_page_route.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class UploadPhotoInfoViewModel extends BaseViewModel {
  final _vehicleService = locator<VehicleService>();
  TextEditingController pricingTextController = TextEditingController();
  final ImagePicker picker = ImagePicker();
  dynamic _pickImageError;

  String _vehicleDraftId;
  String get vehicleDraftId => _vehicleDraftId;
  set vehicleDraftId(String val) {
    _vehicleDraftId = val;
    notifyListeners();
  }

  void init(String draftId) {
    vehicleDraftId = draftId;
  }

  // List<XFile> _imageFileList;
  // List<XFile> get imageFileList => _imageFileList;
  // set imageFileList(List<XFile> val) {
  //   _imageFileList = val;
  //   notifyListeners();
  // }

  List<AssetEntity> _imageAssets = <AssetEntity>[];
  List<AssetEntity> get imageAssets => _imageAssets;
  set imageAssets(List<AssetEntity> val) {
    _imageAssets = val;
    notifyListeners();
  }

  String _imageError = '';
  String get imageError => _imageError;
  set imageError(String val) {
    _imageError = val;
    notifyListeners();
  }

  Future<void> pickImageAssets() async {


    try {
      isLoading = true;

      final List<AssetEntity> assets = await AssetPicker.pickAssets(appContext,
        maxAssets: 10,
        textDelegate: EnglistTextDelegate(),
        themeColor: Color(0xFF824DFF),
    );
      imageAssets = assets;

      if (imageAssets != null && imageAssets.length > 0) {
        Navigator.push(
          appContext,
          StaarmPageRoute.routeTo(
            builder: (context) => UploadPhotosView(
              photos: imageAssets,
              draftId: vehicleDraftId,
            ),
          ),
        );
      }
      isLoading = false;
    } catch (e) {
      _pickImageError = e;
    }
  }

  // void pickImages() async {
  //   try {
  //     isLoading = true;
  //     final pickedFileList = await picker.pickMultiImage(
  //       imageQuality: 60,
  //     );
  //     imageFileList = pickedFileList;

  //     if (imageFileList != null && imageFileList.length > 0) {
  //       Navigator.push(
  //         appContext,
  //         StaarmPageRoute.routeTo(
  //           builder: (context) => UploadPhotosView(
  //             photos: imageAssets,
  //             draftId: vehicleDraftId,
  //           ),
  //         ),
  //       );
  //     }
  //     isLoading = false;
  //   } catch (e) {
  //     _pickImageError = e;
  //   }
  // }

  void updateVehiclePricing() async {
    if (pricingTextController.text.isEmpty) {
      StaarmAppNotification.error(message: 'Enter an amount');
    } else {
      isLoading = true;

      num _price = num.tryParse(pricingTextController.text) ?? 0;
      dynamic res = await _vehicleService.updateVehiclePricing(
          dailyPrice: _price, draftId: vehicleDraftId);
      isLoading = false;

      APIHelpers.handleResponse(res, onSuccess: (response) async {
        Navigator.push(
          appContext,
          StaarmPageRoute.routeTo(
            builder: (context) => CarFeatures(
              draftId: vehicleDraftId,
            ),
          ),
        );
      });
    }
  }
}
