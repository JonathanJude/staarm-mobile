import 'package:provider/provider.dart';
import 'package:staarm_mobile/app/locator.dart';
import 'package:staarm_mobile/core/models/card.dart';
import 'package:staarm_mobile/core/providers/payment_provider.dart';
import 'package:staarm_mobile/core/services/payment_service/payment_service.dart';
import 'package:staarm_mobile/ui/base/base_view_model.dart';
import 'package:staarm_mobile/utils/staarm_app_notification.dart';

class SelectPaymentMethodViewModel extends BaseViewModel {
  final _paymentService = locator<PaymentService>();

  Future<void> deleteCard(CardModel card) async {
    isLoading = true;
    dynamic res =
        await _paymentService.deleteCard(cardId: card.id);
    isLoading = false;

    if(res){
      StaarmAppNotification.success(message: 'Card successfully removed');

      //sync Cards Providers
      PaymentProvider _cardProvider =
          Provider.of<PaymentProvider>(appContext, listen: false);
      _cardProvider.syncCards();
    }
  }
}