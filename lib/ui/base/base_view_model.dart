import 'package:flutter/material.dart';
import 'package:staarm_mobile/utils/mixpanel_helper.dart';

import '../../app/locator.dart';
import '../../core/services/navigator_service.dart';

class BaseViewModel extends ChangeNotifier {
  MixPanelHelper _mixPanel = MixPanelHelper();
  final navigationService = locator<NavigationService>();

  //get `BuildContext`
  BuildContext get appContext => navigationService.navigatorKey.currentContext;

  //mixPanel
  MixPanelHelper get mixPanel => _mixPanel;

  bool _isLoading = false;
  bool disposed = false;

  bool get isLoading => _isLoading;
  set isLoading(bool val) {
      _isLoading = val;
      notifyListeners();
  }

  void setLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    disposed = true;
  }

  // @override
  // void notifyListeners() {
  //   if (!disposed) {
  //     super.notifyListeners();
  //   }
  // }
}
