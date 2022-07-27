import 'package:flutter/material.dart' show BuildContext, required;
import 'package:image_picker/image_picker.dart';
import 'package:staarm_mobile/core/models/user.dart';

abstract class AuthService {

  Future<dynamic> startPhoneNumberVerification({
    @required String phoneNumber,
    Function(dynamic data, int statusCode) onError,
  });

  Future<dynamic> resendPhoneNumberVerification({
    @required String phoneNumber,
    @required int verificationId,
  });

  Future<dynamic> completePhoneNumberVerification({
   @required String phoneNumber,
    @required int verificationId,
    @required String otp,
  });

  Future<dynamic> completeRegistration({
    @required String firstName,
    @required String lastName,
    @required String phoneNumber,
    @required String password,
    @required String passwordConfirmation,
    @required String email,
    @required int verificationId,
  });

  Future<dynamic> login({
    @required String phoneNumber,
    @required String password,
  });

  Future<dynamic> requestResetPassword({
    @required String phoneNumber,
  });

  Future<dynamic> verifyResetRequest({
    @required String phoneNumber,
    @required String otp,
    @required int passwordResetRequestId,
  });

  Future<dynamic> passwordReset({
    @required String phoneNumber,
    @required String password,
    @required String passwordConfirmation,
    @required int passwordResetRequestId,
  });

  Future<dynamic> passwordUpdate({
    @required String password,
    @required String passwordConfirmation,
    @required String newPasswordConfirmation,
  });

  Future<dynamic> updateUserProfile({
    @required String email,
    @required String firstName,
    @required String lastName,
    String dob,
    String about,
  });

  Future<dynamic> updateProfilePicture({
    @required XFile profilePicture,
  });

  Future<UserModel> getUser();
}