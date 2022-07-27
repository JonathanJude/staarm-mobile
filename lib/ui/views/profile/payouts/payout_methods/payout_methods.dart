import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:staarm_mobile/core/providers/payment_provider.dart';
import 'package:staarm_mobile/ui/base/base_view.dart';
import 'package:staarm_mobile/utils/staarm_page_route.dart';

import '../add_bank/add_bank.dart';
import '../widgets/payout_method_item.dart';
import 'view_model.dart';

class PayoutMethodsView extends StatelessWidget {
  const PayoutMethodsView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<PayoutMethodsViewModel>(
      model: PayoutMethodsViewModel(),
      builder: (context, model, _) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(
            color: Color(0xFF717171),
          ),
          title: Text(
            'Payout Method',
            style: TextStyle(
              color: Colors.black,
              fontSize: 14,
            ),
          ),
        ),
        body: Consumer<PaymentProvider>(
          builder: (context, paymentProvider, _) => SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 15,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 17,
                    ),
                    child: Text(
                      'Payout method',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 21,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  if (paymentProvider.banks.length > 0)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: paymentProvider.banks.map((e) {
                            return PayoutMethodItem(
                              bank: e,
                              onDelete: (c){
                                model.deleteBank(c);
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
                                builder: (context) => AddBankView(),
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 12,
                            ),
                            child: Text(
                              'Add new payout method',
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
                                builder: (context) => AddBankView(),
                              ),
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              vertical: 16,
                              horizontal: 10,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Color(0xFFACB1B8),
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Add bank account',
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
