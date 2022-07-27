import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:staarm_mobile/core/api/service_state.dart';
import 'package:staarm_mobile/core/endpoints/endpoints.dart';
import 'package:staarm_mobile/core/exceptions/unknown_exception.dart';
import 'package:staarm_mobile/core/models/bank_model.dart';
import 'package:staarm_mobile/core/models/card.dart';
import 'package:staarm_mobile/core/models/user_bank.dart';
import 'package:staarm_mobile/core/services/http_helper.dart/http_helper.dart';

import 'payment_service.dart';


class PaymentServiceImpl extends PaymentService {
  HttpHelper httpHelper;
  PaymentServiceImpl({@required this.httpHelper}) : assert(httpHelper != null);

  final _log = Logger('PaymentServiceImpl');

  @override
  Future<List<CardModel>> getUserCards() async {
    try {
      final jsonData = await httpHelper.get(
        Endpoints.cards,
      );

      _log.fine(jsonData.toString());

    if (jsonData is SuccessState) {
        final mapResponse = jsonData.value;
        print(mapResponse);
        List<CardModel> _dataList = [];

        if (mapResponse['data']['cards'] == null) {
          _dataList = [];
        } else {
          _dataList = mapResponse['data']['cards'].map<CardModel>((json) {
            return CardModel.fromJson(json);
          }).toList();
        }

        return _dataList;
      } else {
        return null;
      }
    } on Exception {
      _log.severe('Error occured');
      throw const UnknownException();
    }
  }

  @override
  Future<dynamic> startAddNewCardProcess() async {
    try {

      final jsonData = await httpHelper.get(
        Endpoints.startAddCardRequest,
      );

      _log.fine(jsonData.toString());
      print(jsonData.toString());

      return jsonData;
    } catch(e) {

      print("Error starting card -- ${e.toString()}");

      _log.severe('Error occured');
      throw const UnknownException();
    }
  }

  @override
  Future<dynamic> addNewCard({
    @required String transactionReference,
  }) async {
    try {
      Map<String, dynamic> _data = {
        'transaction_reference': transactionReference,
      };

      final jsonData = await httpHelper.post(
        Endpoints.cards,
        body: _data,
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
  Future<bool> deleteCard({
    @required int cardId,
  }) async {
    try {

      final jsonData = await httpHelper.delete(
        Endpoints.cardWIthId(cardId: cardId),
      );

      _log.fine(jsonData.toString());
      print(jsonData.toString());

      if(jsonData is SuccessState){
        return true;
      }
      return false;

    } on Exception {
      _log.severe('Error occured');
      // throw const UnknownException();
       return false;
    }
  }

  @override
  Future<dynamic> chargeCard({
    @required int cardId,
    @required int tripId,
  }) async {
    try {
      Map<String, dynamic> _data = {
        'trip_id': tripId,
      };

      final jsonData = await httpHelper.post(
        Endpoints.chargeCard(cardId: cardId),
        body: _data,
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
  Future<dynamic> chargeOneOffRequest({
    @required int tripId,
  }) async {
    try {
      Map<String, dynamic> _data = {
        'trip_id': tripId,
      };

      final jsonData = await httpHelper.post(
        Endpoints.chargeOneOffRequest,
        body: _data,
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
  Future<dynamic> completeOneOffRequest({
    @required String transactionReference,
  }) async {
    try {
      Map<String, dynamic> _data = {
        'transaction_reference': transactionReference,
      };

      final jsonData = await httpHelper.post(
        Endpoints.completeOneOffRequest,
        body: _data,
      );

      _log.fine(jsonData.toString());
      print(jsonData.toString());

      return jsonData;
    } on Exception {
      _log.severe('Error occured');
      throw const UnknownException();
    }
  }


  //payouts service
  @override
  Future<List<UserBankModel>> getUserBanks() async {
    try {
      final jsonData = await httpHelper.get(
        Endpoints.banks,
      );

      _log.fine(jsonData.toString());

    if (jsonData is SuccessState) {
        final mapResponse = jsonData.value;
        print(mapResponse);
        List<UserBankModel> _dataList = [];

        if (mapResponse['data']['bank_accounts'] == null) {
          _dataList = [];
        } else {
          _dataList = mapResponse['data']['bank_accounts'].map<UserBankModel>((json) {
            return UserBankModel.fromJson(json);
          }).toList();
        }

        return _dataList;
      } else {
        return null;
      }
    } on Exception {
      _log.severe('Error occured');
      throw const UnknownException();
    }
  }

  @override
  Future<List<BankModel>> getBanks() async {
    try {
      final jsonData = await httpHelper.get(
        Endpoints.bankListData,
      );

      _log.fine(jsonData.toString());

    if (jsonData is SuccessState) {
        final mapResponse = jsonData.value;
        print(mapResponse);
        List<BankModel> _dataList = [];

        if (mapResponse['data']['bank_list'] == null) {
          _dataList = [];
        } else {
          _dataList = mapResponse['data']['bank_list'].map<BankModel>((json) {
            return BankModel.fromJson(json);
          }).toList();
        }

        return _dataList;
      } else {
        return null;
      }
    } on Exception {
      _log.severe('Error occured');
      throw const UnknownException();
    }
  }

  @override
  Future<dynamic> addVerifiedBank({
    @required String bankAccountVerificationId,
  }) async {
    try {
      Map<String, dynamic> _data = {
        'bank_account_verification_id': bankAccountVerificationId,
      };

      final jsonData = await httpHelper.post(
        Endpoints.banks,
        body: _data,
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
  Future<dynamic> verifyBankAccount({
    @required int bankId,
    @required String accountNumber,
  }) async {
    try {
      Map<String, dynamic> _data = {
        'bank_id': bankId,
        'account_number': accountNumber,
      };

      final jsonData = await httpHelper.post(
        Endpoints.verifyBank,
        body: _data,
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
  Future<bool> deleteBank({
    @required int bankId,
  }) async {
    try {

      final jsonData = await httpHelper.delete(
        Endpoints.getBank(bankId: bankId),
      );

      _log.fine(jsonData.toString());
      print(jsonData.toString());

      if(jsonData is SuccessState){
        return true;
      }
      return false;

    } on Exception {
      _log.severe('Error occured');
      // throw const UnknownException();
       return false;
    }
  }
}
