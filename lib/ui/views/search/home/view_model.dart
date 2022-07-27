import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mati_plugin_flutter/mati_plugin_flutter.dart';
import 'package:provider/provider.dart';
import 'package:staarm_mobile/app/locator.dart';
import 'package:staarm_mobile/core/models/vehicle/vehicle_model.dart';
import 'package:staarm_mobile/core/providers/location_provider.dart';
import 'package:staarm_mobile/core/services/vehicle_service/vehicle_service.dart';
import 'package:staarm_mobile/ui/base/base_view_model.dart';
import 'package:staarm_mobile/utils/staarm_toast.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class SearchHomeViewModel extends BaseViewModel {
  final _vehicleService = locator<VehicleService>();
  TextEditingController pricingTextController = TextEditingController();
  final ImagePicker picker = ImagePicker();
  dynamic _pickImageError;

  List<VehicleModel> _vehiclesCloseBy = [];
  List<VehicleModel> get vehiclesCloseBy => _vehiclesCloseBy;
  set vehiclesCloseBy(List<VehicleModel> val) {
    _vehiclesCloseBy = val;
    notifyListeners();
  }

  void init() {
    loadVehiclesCloseBy();
  }

  void loadVehiclesCloseBy() async {
    LocationProvider _locationProvider =
        Provider.of<LocationProvider>(appContext, listen: false);

    if (_locationProvider.isLocationAvailable) {
      isLoading = true;
      final _locationData = _locationProvider.locationData;

      dynamic res = await _vehicleService.searchVehicles(
        lat: _locationData.latitude,
        lng: _locationData.longitude,
      );
      isLoading = false;

      if (res != null) {
        vehiclesCloseBy = res;
      }
    }
  }

  //metamap
  void showMetaMapFlow() {
    try {
      final metaData = {"user_id": "jude"};
      MetaMapFlutter.showMetaMapFlow(
          "629f77b5d3304a001cb3c2c8", "62a75ea0c25d96001cb06955", metaData);
      MetaMapFlutter.resultCompleter.future.then(
        (result) => StaarmToast.success(
          message: result is ResultSuccess
              ? "Success ${result.verificationId}"
              : "Cancelled",
        ),
      );
    } catch (e) {
      print("error occured here --- ${e.toString()}");
    }
  }

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

  // Future<void> loadAssets() async {

  //   final List<AssetEntity> assets = await AssetPicker.pickAssets(appContext);
  //   String error = '';

  //   try {

  //     final List<AssetEntity> assets = await AssetPicker.pickAssets(appContext,
  //       maxAssets: 10,
  //       textDelegate: EnglistTextDelegate(),
  //       themeColor: Color(0xFF824DFF),
  //   );

  //     for (var i = 0; i < assets.length; ++i) {
  //       if (assets[i].isImage) {
  //         resultList.add(Asset.fromEntity(assets[i]));
  //       }
  //     }

  //   } on Exception catch (e) {
  //     error = e.toString();
  //   }

  //   // If the widget was removed from the tree while the asynchronous platform
  //   // message was in flight, we want to discard the reply rather than calling
  //   // setState to update our non-existent appearance.
  //   // if (!mounted) return;

  //     imageAssets = resultList;
  //     imageError = error;
  // }

  List<XFile> _imageFileList;
  List<XFile> get imageFileList => _imageFileList;
  set imageFileList(List<XFile> val) {
    _imageFileList = val;
    notifyListeners();
  }

  void pickImages() async {
    try {
      isLoading = true;
      final pickedFileList = await picker.pickMultiImage(
        imageQuality: 60,
      );
      imageFileList = pickedFileList;

      // if (imageFileList != null && imageFileList.length > 0) {
      //   Navigator.push(
      //     appContext,
      //     StaarmPageRoute.routeTo(
      //       builder: (context) => UploadPhotosView(
      //         photos: imageFileList,
      //         draftId: vehicleDraftId,
      //       ),
      //     ),
      //   );
      // }
      isLoading = false;
    } catch (e) {
      _pickImageError = e;
    }
  }
}
