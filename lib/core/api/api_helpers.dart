import 'package:flutter/material.dart';
import 'package:staarm_mobile/utils/staarm_app_notification.dart';

import 'service_state.dart';

class APIHelpers {
  APIHelpers._();

  static dynamic handleResponse(
    ServiceState response, {
    @required Function(SuccessState) onSuccess,
    Function(ErrorState) onError,
  }) {
    if (response is SuccessState) {
      onSuccess(response);
    } else if (response is ErrorState && onError != null) {
      onError(response);
    } else if (response is ErrorState) {
      StaarmAppNotification.error(message: response);
    } else {
      StaarmAppNotification.error();
    }
  }
}
