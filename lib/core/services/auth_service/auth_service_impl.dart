import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logging/logging.dart';
import 'package:staarm_mobile/core/api/service_state.dart';
import 'package:staarm_mobile/core/endpoints/endpoints.dart';
import 'package:staarm_mobile/core/exceptions/unknown_exception.dart';
import 'package:staarm_mobile/core/models/user.dart';
import 'package:staarm_mobile/core/services/http_helper.dart/http_helper.dart';

import 'auth_service.dart';

class AuthServiceImpl extends AuthService {
  HttpHelper httpHelper;
  AuthServiceImpl({@required this.httpHelper}) : assert(httpHelper != null);

  final _log = Logger('AuthServiceImpl');

  @override
  Future<dynamic> startPhoneNumberVerification({
    @required String phoneNumber,
    Function(dynamic data, int statusCode) onError,
  }) async {
    try {
      Map<String, dynamic> _data = {
        'phone_number': phoneNumber,
      };

      final jsonData = await httpHelper.post(
          Endpoints.startPhoneNumberVerification,
          body: _data,
          onError: onError,
          checkStatus: false);

      _log.fine(jsonData.toString());

      return jsonData;
    } on Exception {
      _log.severe('Error occured');
      throw const UnknownException();
    }
  }

  @override
  Future<dynamic> resendPhoneNumberVerification({
    @required String phoneNumber,
    @required int verificationId,
  }) async {
    try {
      Map<String, dynamic> _data = {
        'phone_number': phoneNumber,
        'verification_id': verificationId,
      };

      final jsonData = await httpHelper.post(
        Endpoints.resendPhoneNumberVerificationOtp,
        body: _data,
      );

      _log.fine(jsonData.toString());

      return jsonData;
    } on Exception {
      _log.severe('Error occured');
      throw const UnknownException();
    }
  }

  @override
  Future<dynamic> completePhoneNumberVerification({
    @required String phoneNumber,
    @required int verificationId,
    @required String otp,
  }) async {
    try {
      Map<String, dynamic> _data = {
        'phone_number': phoneNumber,
        'verification_id': verificationId,
        'otp': otp,
      };

      final jsonData = await httpHelper.post(
        Endpoints.completePhoneNumberVerification,
        body: _data,
      );

      _log.fine(jsonData.toString());

      return jsonData;
    } on Exception {
      _log.severe('Error occured');
      throw const UnknownException();
    }
  }

  @override
  Future<dynamic> completeRegistration({
    @required String firstName,
    @required String lastName,
    @required String phoneNumber,
    @required String password,
    @required String passwordConfirmation,
    @required String email,
    @required int verificationId,
  }) async {
    try {
      Map<String, dynamic> _data = {
        "email": email,
        "password": password,
        "password_confirmation": passwordConfirmation,
        "last_name": lastName,
        "first_name": firstName,
        "phone_number": phoneNumber,
        "verification_id": verificationId,
      };

      final jsonData = await httpHelper.post(
        Endpoints.completeRegistration,
        body: _data,
      );

      _log.fine(jsonData.toString());

      return jsonData;
    } on Exception {
      _log.severe('Error occured');
      throw const UnknownException();
    }
  }

  @override
  Future<dynamic> login({
    @required String phoneNumber,
    @required String password,
  }) async {
    try {
      Map<String, dynamic> _data = {
        'phone_number': phoneNumber,
        'password': password,
      };

      final jsonData = await httpHelper.post(
        Endpoints.login,
        body: _data,
      );

      _log.fine(jsonData.toString());

      return jsonData;
    } on Exception {
      _log.severe('Error occured');
      throw const UnknownException();
    }
  }

  @override
  Future<dynamic> requestResetPassword({
    @required String phoneNumber,
  }) async {
    try {
      Map<String, dynamic> _data = {
        'phone_number': phoneNumber,
      };

      final jsonData = await httpHelper.post(
        Endpoints.requestPasswordReset,
        body: _data,
      );

      _log.fine(jsonData.toString());

      return jsonData;
    } on Exception {
      _log.severe('Error occured');
      throw const UnknownException();
    }
  }

  @override
  Future<dynamic> verifyResetRequest({
    @required String phoneNumber,
    @required String otp,
    @required int passwordResetRequestId,
  }) async {
    try {
      Map<String, dynamic> _data = {
        'otp': otp,
        'phone_number': phoneNumber,
        'password_reset_request_id': passwordResetRequestId,
      };

      final jsonData = await httpHelper.post(
        Endpoints.verifyPasswordResetRequest,
        body: _data,
      );

      _log.fine(jsonData.toString());

      return jsonData;
    } on Exception {
      _log.severe('Error occured');
      throw const UnknownException();
    }
  }

  @override
  Future<dynamic> passwordReset({
    @required String phoneNumber,
    @required String password,
    @required String passwordConfirmation,
    @required int passwordResetRequestId,
  }) async {
    try {
      Map<String, dynamic> _data = {
        "phone_number": phoneNumber,
        "password": password,
        "password_confirmation": passwordConfirmation,
        "password_reset_request_id": passwordResetRequestId,
      };

      final jsonData = await httpHelper.post(
        Endpoints.passwordReset,
        body: _data,
      );

      _log.fine(jsonData.toString());

      return jsonData;
    } on Exception {
      _log.severe('Error occured');
      throw const UnknownException();
    }
  }

  @override
  Future<dynamic> passwordUpdate({
    @required String password,
    @required String passwordConfirmation,
    @required String newPasswordConfirmation,
  }) async {
    try {
      Map<String, dynamic> _data = {
        "password": password,
        "new_password": passwordConfirmation,
        "new_password_confirmation": newPasswordConfirmation,
      };

      final jsonData = await httpHelper.post(
        Endpoints.passwordUpdate,
        body: _data,
      );

      _log.fine(jsonData.toString());

      return jsonData;
    } on Exception {
      _log.severe('Error occured');
      throw const UnknownException();
    }
  }

  @override
  Future<dynamic> updateUserProfile({
    @required String email,
    @required String firstName,
    @required String lastName,
    String dob,
    String about,
  }) async {
    try {
      Map<String, dynamic> _data = {
        "email": email,
        "dob": dob,
        "first_name": firstName,
        "last_name": lastName,
        "about": about,
      };

      final jsonData = await httpHelper.post(
        Endpoints.updateUser,
        body: _data,
      );

      _log.fine(jsonData.toString());

      return jsonData;
    } on Exception {
      _log.severe('Error occured');
      throw const UnknownException();
    }
  }

  @override
  Future<dynamic> updateProfilePicture({
    @required XFile profilePicture,
  }) async {
    try {
      //handle files
      dynamic _data = FormData.fromMap(
        {
          'profile_pic': MultipartFile.fromFileSync(profilePicture.path),
        },
        ListFormat.multiCompatible,
      );

      final jsonData = await httpHelper.post(
        Endpoints.updateProfilePicture,
        body: _data,
        useMultiPart: true,
      );

      _log.fine(jsonData.toString());
      print(jsonData.toString());

      return jsonData;
    } on Exception {
      _log.severe('Error occured');
      throw const UnknownException();
    }
  }

  @override
  Future<UserModel> getUser() async {
    try {
      final jsonData = await httpHelper.get(Endpoints.user);

      _log.fine(jsonData.toString());

      if (jsonData is SuccessState) {
        final mapResponse = jsonData.value;
        if (mapResponse["data"]["user"] != null) {
          UserModel _user = UserModel.fromJson(mapResponse["data"]["user"]);
          return _user;
        }
        return null;
      } else {
        return null;
      }
    } on Exception {
      _log.severe('Error occured when getting user');
      throw const UnknownException();
    }
  }
}
