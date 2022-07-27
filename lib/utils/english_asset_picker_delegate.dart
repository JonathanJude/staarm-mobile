import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class EnglistTextDelegate extends AssetsPickerTextDelegate {
  @override
  String get confirm => 'OK';

  @override
  String get cancel => 'Cancel';

  @override
  String get edit => 'Edit';

  @override
  String get gifIndicator => 'GIF';

  @override
  String get heicNotSupported => 'Type of image not supported';

  @override
  String get loadFailed => 'Load failed';

  @override
  String get original => 'Original';

  @override
  String get preview => 'Preview';

  @override
  String get select => 'Select';

  @override
  String get unSupportedAssetType => 'Unsupported asset type';

  @override
  String get unableToAccessAll => "Unable to access all selected assets";

  @override
  String get viewingLimitedAssetsTip =>
      'Only view assets and albums accessible to app.';

  @override
  String get changeAccessibleLimitedAssets =>
      'Update limited access assets list';

  @override
  String get accessAllTip => 'App can only access some assets on the device. '
      'Go to system settings and allow app to access all assets on the device.';

  @override
  String get goToSystemSettings => 'Go to system settings';

  @override
  String get accessLimitedAssets => 'Continue with limited access';

  @override
  String get accessiblePathName => 'Accessible assets';
}