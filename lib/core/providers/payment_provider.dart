import 'package:flutter/material.dart';
import 'package:staarm_mobile/app/locator.dart';
import 'package:staarm_mobile/core/models/bank_model.dart';
import 'package:staarm_mobile/core/models/card.dart';
import 'package:staarm_mobile/core/models/user_bank.dart';
import 'package:staarm_mobile/core/services/payment_service/payment_service.dart';

class PaymentProvider extends ChangeNotifier {
  final _paymentService = locator<PaymentService>();
  
  List<CardModel> _cards = [];
  List<CardModel> get cards => _cards;
  set cards(List<CardModel> val) {
    _cards = val;
    notifyListeners();
  }

  List<UserBankModel> _banks = [];
  List<UserBankModel> get banks => _banks;
  set banks(List<UserBankModel> val) {
    _banks = val;
    notifyListeners();
  }

  List<BankModel> _bankList = [];
  List<BankModel> get bankList => _bankList;
  set bankList(List<BankModel> val) {
    _bankList = val;
    notifyListeners();
  }

  bool _isSyncingCards;
  bool get isSyncingCards => _isSyncingCards;
  set isSyncingCards(bool val) {
    _isSyncingCards = val;
    notifyListeners();
  }

  bool _isSyncingBanks;
  bool get isSyncingBanks => _isSyncingBanks;
  set isSyncingBanks(bool val) {
    _isSyncingBanks = val;
    notifyListeners();
  }

  bool _isSyncingBankList;
  bool get isSyncingBankList => _isSyncingBankList;
  set isSyncingBankList(bool val) {
    _isSyncingBankList = val;
    notifyListeners();
  }

  Future<void> syncCards() async {
    isSyncingCards = true;
    dynamic res = await _paymentService.getUserCards();
    isSyncingCards = false;

    if(res != null){
      cards = res;
    }
    notifyListeners();
  }

  Future<void> syncBanks() async {
    isSyncingBanks = true;
    dynamic res = await _paymentService.getUserBanks();
    isSyncingBanks = false;

    if(res != null){
      banks = res;
    }
    notifyListeners();
  }

  Future<void> syncBankList() async {
    isSyncingBankList = true;
    dynamic res = await _paymentService.getBanks();
    isSyncingBankList = false;

    if(res != null){
      bankList = res;
    }
    notifyListeners();
  }
}
