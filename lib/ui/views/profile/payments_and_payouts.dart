import 'package:flutter/material.dart';
import 'package:staarm_mobile/ui/views/profile/payouts/payout_methods/payout_methods.dart';
import 'package:staarm_mobile/utils/staarm_page_route.dart';

import 'payments/select_payment_metthod/select_payment_method.dart';
import 'widgets/profile_item.dart';

class PaymentsAndPayoutsView extends StatelessWidget {
  const PaymentsAndPayoutsView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Color(0xFF717171),
        ),
        title: Text(
          'Payments & payouts',
          style: TextStyle(
            color: Colors.black,
            fontSize: 14,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 15,
          ),
          child: Column(
            children: [
              SizedBox(height: 20),
              ProfileItem(
                title: 'Payment method',
                onTap: () {
                  Navigator.push(
                    context,
                    StaarmPageRoute.routeTo(
                      builder: (context) => SelectPaymentMethod(),
                    ),
                  );
                },
              ),
              ProfileItem(
                title: 'Payout method',
                onTap: () {
                  Navigator.push(
                    context,
                    StaarmPageRoute.routeTo(
                      builder: (context) => PayoutMethodsView(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
