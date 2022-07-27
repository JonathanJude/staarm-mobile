import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:staarm_mobile/app/locator.dart';
import 'package:staarm_mobile/core/api/api_helpers.dart';
import 'package:staarm_mobile/core/models/bank_model.dart';
import 'package:staarm_mobile/core/providers/payment_provider.dart';
import 'package:staarm_mobile/core/services/payment_service/payment_service.dart';
import 'package:staarm_mobile/ui/base/base_view_model.dart';
import 'package:staarm_mobile/utils/staarm_app_notification.dart';

class AddBankViewModel extends BaseViewModel {
  final _paymentService = locator<PaymentService>();
  TextEditingController bankNumberTextEditingController =
      TextEditingController();

  BankModel _selectedBank;
  BankModel get selectedBank => _selectedBank;
  set selectedBank(BankModel val) {
    _selectedBank = val;
    notifyListeners();
  }

  String _accountName;
  String get accountName => _accountName;
  set accountName(String val) {
    _accountName = val;
    notifyListeners();
  }

  String _bankAccountVerificationId;
  String get bankAccountVerificationId => _bankAccountVerificationId;
  set bankAccountVerificationId(String val) {
    _bankAccountVerificationId = val;
    notifyListeners();
  }

  bool _isVerifying = false;
  bool get isVerifying => _isVerifying;
  set isVerifying(bool val) {
    _isVerifying = val;
    notifyListeners();
  }

  void init() async {
    PaymentProvider _paymentProvider =
        Provider.of<PaymentProvider>(appContext, listen: false);

    if (_paymentProvider.bankList == null) {
      _paymentProvider.syncBankList();
    }
  }

  void onBankAccountNumberChanged(String str) async {
    if (str.isNotEmpty && str.length == 10) {
      verifyBankAccount();
    }
  }

  void verifyBankAccount() async {
    if (selectedBank == null) {
      StaarmAppNotification.error(message: 'Select a bank');
      return;
    }

    if (bankNumberTextEditingController.text.isEmpty) {
      StaarmAppNotification.error(message: 'Enter a bank account number');
      return;
    }

    isVerifying = true;
    dynamic res = await _paymentService.verifyBankAccount(
      bankId: selectedBank.bankId,
      accountNumber: bankNumberTextEditingController.text,
    );
    isVerifying = false;

    APIHelpers.handleResponse(
      res,
      onSuccess: (response) async {
        String _acctName = response.value['data']['account_name'];
        String _verId = response.value['data']['bank_account_verification_id'];


        if (_acctName != null && _verId != null) {
          accountName = _acctName;
          bankAccountVerificationId = _verId;
        } else {
          StaarmAppNotification.error(
            message: 'Error verifying account. Contact support',
          );
        }
      },
    );
  }

  void addBankAccount() async {
    if (accountName != null && bankAccountVerificationId != null) {
      isLoading = true;
      dynamic res = await _paymentService.addVerifiedBank(
        bankAccountVerificationId: bankAccountVerificationId,
      );
      isLoading = false;

      APIHelpers.handleResponse(
        res,
        onSuccess: (response) async {
          StaarmAppNotification.success(
            message: 'Bank Account successfully added',
          );

          //sync Cards Providers
          PaymentProvider _cardProvider =
              Provider.of<PaymentProvider>(appContext, listen: false);
          _cardProvider.syncBanks();

          Navigator.of(appContext).pop();
        },
      );
    }
  }
}
