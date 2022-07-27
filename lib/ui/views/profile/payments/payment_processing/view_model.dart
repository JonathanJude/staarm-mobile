import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:provider/provider.dart';
import 'package:staarm_mobile/app/locator.dart';
import 'package:staarm_mobile/core/api/api_helpers.dart';
import 'package:staarm_mobile/core/models/user.dart';
import 'package:staarm_mobile/core/providers/payment_provider.dart';
import 'package:staarm_mobile/core/providers/user_provider.dart';
import 'package:staarm_mobile/core/services/payment_service/payment_service.dart';
import 'package:staarm_mobile/ui/base/base_view_model.dart';
import 'package:staarm_mobile/utils/staarm_app_notification.dart';

class PaymentProcessingViewModel extends BaseViewModel {
  final _paystackPlugin = PaystackPlugin();
  final _paymentService = locator<PaymentService>();

  void init() async {
    _paystackPlugin.initialize(publicKey: env['PAYSTACK_TEST_PUBLIC_KEY']);
    _paystackPlugin.initialize(publicKey: env['PAYSTACK_LIVE_PUBLIC_KEY']); //for paystack

    await Future.delayed(Duration(milliseconds: 1000));

    _startCardProcessing();
  }

  Future<void> _startCardProcessing() async {
    isLoading = true;
    dynamic res = await _paymentService.startAddNewCardProcess();
    // isLoading = false;

    APIHelpers.handleResponse(res, onSuccess: (response) async {

      print("PAYSTACK -- Get  Card response : ${response.value}");
      String _tnxnRef = response.value['data']['transaction_reference'];
      String _accessCode = response.value['data']['access_code'];
      num _amount = response.value['data']['amount_in_kobo'];

      if (_tnxnRef != null && _accessCode != null && _amount != null) {
        chargeUCardViaPaystack(
          tnxRef: _tnxnRef,
          accessCode: _accessCode,
          amount: _amount,
        );
      } else {
        StaarmAppNotification.error(message: 'Error add Card');
        Navigator.of(appContext).pop();
      }
    });
  }

  Future<void> chargeUCardViaPaystack({
    @required String tnxRef,
    @required String accessCode,
    @required num amount,
  }) async {

    //get User
      UserProvider _userProvider =
          Provider.of<UserProvider>(appContext, listen: false);

      UserModel _user = _userProvider.user;


    Charge charge = Charge()
      ..amount = amount
      ..accessCode = accessCode
      ..email = _user.email ?? '';

    isLoading = true;

    CheckoutResponse checkoutResponse = await _paystackPlugin.checkout(
      appContext,
      method: CheckoutMethod.card,
      charge: charge,
    );

    if (checkoutResponse.status) {
      _addCard(checkoutResponse.reference);
    } else {
      StaarmAppNotification.error(message: 'Error add Card');
      Navigator.of(appContext).pop();
    }
  }

  Future<void> _addCard(String tnxRef) async {
    isLoading = true;
    dynamic res =
        await _paymentService.addNewCard(transactionReference: tnxRef);
    isLoading = false;

    APIHelpers.handleResponse(res, onSuccess: (response) async {
      StaarmAppNotification.success(message: 'Card successfully added');

      //sync Cards Providers
      PaymentProvider _cardProvider =
          Provider.of<PaymentProvider>(appContext, listen: false);
      _cardProvider.syncCards();

      Navigator.of(appContext).pop();
    });
  }
}
