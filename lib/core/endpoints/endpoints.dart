import 'package:flutter/material.dart';

class Endpoints {
  Endpoints._();

  static const String stagingUrl =
      'https://test.api.staarm.com/api/v1/';
  static const String prodUrl = 'https://api.staarm.com/api/v1/';

  static const String baseUrl = prodUrl;

  //Auth
  static const String startPhoneNumberVerification =
      'user/start-phone-number-verification';
  static const String resendPhoneNumberVerificationOtp =
      'user/resend-phone-number-verification-otp';
  static const String completePhoneNumberVerification =
      'user/complete-phone-number-verification';
  static const String completeRegistration = 'user/complete-registration';
  static const String login = 'user/login';

  static const String requestPasswordReset = 'user/password/request-reset';
  static const String verifyPasswordResetRequest =
      'user/password/verify-reset-request';
  static const String passwordReset = 'user/password/reset';
  static const String passwordUpdate = 'user/password/update';
  static const String updateUser = 'user/update';
  static const String updateProfilePicture = 'user/update/profile-pic';
  static const String user = 'user';


  //Vehicle
  static const String vehicleDataList = 'vehicles/vehicle-data-list';
  static const String getHostVehicles = 'vehicles';
  static const String startVehicleHosting = 'vehicles/start-vehicle-hosting';
  static String updateVehicleDetails({@required String draftVehicleId}) =>
      'vehicles/$draftVehicleId/details';
  static String updateVehiclePickupAndDropoff(
          {@required String draftVehicleId}) =>
      'vehicles/$draftVehicleId/pick-up-drop-off';
  static String updateVehiclePricing({@required String draftVehicleId}) =>
      'vehicles/$draftVehicleId/pricing';
  static String updateVehicleFeatures({@required String draftVehicleId}) =>
      'vehicles/$draftVehicleId/features';
  static String updateVehicleDescription({@required String draftVehicleId}) =>
      'vehicles/$draftVehicleId/description';
  static String updateVehiclePhotos({@required String draftVehicleId}) =>
      'vehicles/$draftVehicleId/photos';
  static String updateVehicleDraftCoverPhoto(
          {@required String draftVehicleId}) =>
      'vehicles/$draftVehicleId/draft-cover-photo';
  static const String completeVehicleHosting =
      'vehicles/complete-vehicle-hosting';
  static const String searchVehicles = 'vehicles/search';
  static String vehiclesOfAUser({@required int userId}) =>
      'user/$userId/vehicles';

  //Search
  static const String searchTrips = 'vehicles/search';

  //Trips
  static const String trips = 'trips';
  static const String tripBookings = 'trips/bookings';

  //Protection Plans
  static const String protectionPlans = 'protection-plans';

  //Payments
  static const String startAddCardRequest = 'payment/cards/add-request';
  static const String cards = 'payment/cards';
  static String cardWIthId({@required int cardId}) => 'payment/cards/$cardId';
  static String chargeCard({@required int cardId}) =>
      'payment/cards/$cardId/charge';
  static const String chargeOneOffRequest =
      'payment/cards/charge-one-off-request';
  static const String completeOneOffRequest =
      'payment/cards/complete-one-off-request';

  //Payouts
  static const String banks = 'payout/banks';
  static const String bankListData = 'payout/banks/bank-list-data';
  static const String verifyBank = 'payout/banks/verify';
  static String getBank({@required int bankId}) => 'payout/banks/$bankId';

  //Favorites
  static const String favorites = 'favorites';
  static String favoriteWIthId({@required int favoriteId}) =>
      'favorites/$favoriteId';

  //KYC
  static const String kyc = 'kyc';
  static const String kycNIN = 'kyc/nins';
  static const String kycDriversLicence = 'kyc/drivers-licences';
  static const String kycDriversLicenceImages = 'kyc/drivers-licences/images';

  //Messages
  static String sendMessage({@required String tripId}) => "message/$tripId/create";
  static String getMessages({@required String tripId}) => "message/$tripId/get";

  //Notifications
  static const String deviceTokens = 'user/device-tokens';
  static const String inAppNotifications = 'user/notifications';
}
