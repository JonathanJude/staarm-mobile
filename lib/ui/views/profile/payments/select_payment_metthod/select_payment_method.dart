import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:staarm_mobile/core/models/card.dart';
import 'package:staarm_mobile/core/providers/payment_provider.dart';
import 'package:staarm_mobile/ui/base/base_view.dart';
import 'package:staarm_mobile/utils/staarm_page_route.dart';

import '../payment_processing/payment_processing_view.dart';
import '../widgets/payment_method_item.dart';
import 'view_model.dart';

class SelectPaymentMethod extends StatelessWidget {
  final bool displayHowToPay;
  final Function(CardModel) onSelect;
  const SelectPaymentMethod({
    Key key,
    this.displayHowToPay = false, this.onSelect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<SelectPaymentMethodViewModel>(
      model: SelectPaymentMethodViewModel(),
      builder: (context, model, _) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(
            color: Color(0xFF717171),
          ),
          title: Text(
            'Payment Method',
            style: TextStyle(
              color: Colors.black,
              fontSize: 14,
            ),
          ),
        ),
        body: Consumer<PaymentProvider>(
          builder: (context, cardProvider, _) => SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 15,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 22,
                    ),
                    child: Text(
                      displayHowToPay
                          ? 'How would you like to pay?'
                          : 'Payment method',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 21,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  if (cardProvider.cards.length > 0)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: cardProvider.cards.map((e) {
                            return PaymentMethodItem(
                              card: e,
                              onSelect: onSelect,
                              onDelete: (c){
                                model.deleteCard(c);
                              },
                            );
                          }).toList(),
                        ),
                        SizedBox(height: 10),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              StaarmPageRoute.routeTo(
                                builder: (context) => PaymentProcessingView(),
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 12,
                            ),
                            child: Text(
                              'Add new payment method',
                              style: TextStyle(
                                color: Color(0xFF5A6474),
                                fontSize: 14,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  else
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              StaarmPageRoute.routeTo(
                                builder: (context) => PaymentProcessingView(),
                              ),
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              vertical: 16,
                              horizontal: 10,
                            ),
                            width: double.maxFinite,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Color(0xFFACB1B8),
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Add debit card',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color(0xFF717171),
                                    fontSize: 14,
                                  ),
                                ),
                                  Text(
                                  "You'll be charged ₦100 and it'll be refunded",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color(0xFF717171),
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  SizedBox(height: 12),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
