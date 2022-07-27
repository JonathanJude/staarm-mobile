import 'package:flutter/material.dart';
import 'package:staarm_mobile/core/models/bank_model.dart';
import 'package:staarm_mobile/core/models/card.dart';
import 'package:staarm_mobile/core/models/user_bank.dart';

abstract class PaymentService {
  //payments
  Future<List<CardModel>> getUserCards();

  Future<dynamic> startAddNewCardProcess();

  Future<dynamic> addNewCard({
    @required String transactionReference,
  });

  Future<bool> deleteCard({
    @required int cardId,
  });

   Future<dynamic> chargeCard({
    @required int cardId,
    @required int tripId,
  });

  Future<dynamic> chargeOneOffRequest({
    @required int tripId,
  });

  Future<dynamic> completeOneOffRequest({
    @required String transactionReference,
  });

  //payouts
  Future<List<UserBankModel>> getUserBanks();

  Future<List<BankModel>> getBanks();

  Future<dynamic> addVerifiedBank({
    @required String bankAccountVerificationId,
  });

  Future<dynamic> verifyBankAccount({
    @required int bankId,
    @required String accountNumber,
  });

  Future<bool> deleteBank({
    @required int bankId,
  });
}
