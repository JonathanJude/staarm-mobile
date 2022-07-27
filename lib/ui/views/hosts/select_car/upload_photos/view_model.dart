import 'package:flutter/material.dart';
import 'package:staarm_mobile/app/locator.dart';
import 'package:staarm_mobile/core/api/api_helpers.dart';
import 'package:staarm_mobile/core/services/vehicle_service/vehicle_service.dart';
import 'package:staarm_mobile/ui/base/base_view_model.dart';
import 'package:staarm_mobile/utils/staarm_app_notification.dart';
import 'package:staarm_mobile/utils/staarm_page_route.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

import '../safety_and_quality.dart';

class UploadPhotosViewModel extends BaseViewModel {
  final _vehicleService = locator<VehicleService>();
  ScrollController scrollController = ScrollController();

  String _vehicleDraftId;
  String get vehicleDraftId => _vehicleDraftId;
  set vehicleDraftId(String val) {
    _vehicleDraftId = val;
    notifyListeners();
  }

  List<AssetEntity> _photos;
  List<AssetEntity> get photos => _photos;
  set photos(List<AssetEntity> val) {
    _photos = val;
    notifyListeners();
  }

  void init(String draftId, List<AssetEntity> imgs) {
    vehicleDraftId = draftId;
    photos = imgs;
  }

  void updateVehiclePhotos() async {
    
    if (photos == null || photos.length == 0) {
      StaarmAppNotification.error(message: 'Select your pictures');
    } else {
      isLoading = true;

      dynamic res = await _vehicleService.updateVehiclePhotos(
        vehiclePhotos: photos,
        draftId: vehicleDraftId,
      );
      isLoading = false;

      APIHelpers.handleResponse(res, onSuccess: (response) async {
        Navigator.push(
          appContext,
          StaarmPageRoute.routeTo(
            builder: (context) => SafetyAndQualityView(
              draftId: vehicleDraftId,
            ),
          ),
        );
      });
    }
  }
}
