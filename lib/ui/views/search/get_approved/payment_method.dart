import 'package:flutter/material.dart';
import 'package:staarm_mobile/ui/views/search/checkout/checkout_view.dart';
import 'package:staarm_mobile/utils/staarm_page_route.dart';
import 'package:staarm_mobile/widgets/buttons/app_button.dart';
import 'package:staarm_mobile/widgets/buttons/bottom_app_button_container.dart';
import 'package:staarm_mobile/widgets/textfields/normal_auth_textfield.dart';

class PaymentMethodGetApproved extends StatelessWidget {
  const PaymentMethodGetApproved({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 17,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  vertical: 13,
                  horizontal: 14,
                ),
                decoration: BoxDecoration(
                  color: Color(0xFFF8F8F8),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Icon(
                        Icons.info_outline,
                        color: Color(0xFF757D8A),
                        size: 23,
                      ),
                    ),
                    Text(
                      'You won’t be charged until you book.',
                      style: TextStyle(
                        color: Color(0xFF757D8A),
                        fontSize: 14,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Card Information',
                style: TextStyle(
                  color: Color(0xFF231F20),
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              NormalAuthTextField(
                labelText: 'Name on card',
              ),
              NormalAuthTextField(
                labelText: 'Credit card number',
                suffix: Icon(
                  Icons.credit_card,
                  color: Color(0xFF757D8A),
                ),
              ),
              NormalAuthTextField(
                labelText: 'Expiration date',
              ),
              NormalAuthTextField(
                labelText: 'Security code',
              ),

              SizedBox(height: 8),
              Text(
                'Current Address',
                style: TextStyle(
                  color: Color(0xFF231F20),
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              NormalAuthTextField(
                labelText: 'Country',
              ),

              NormalAuthTextField(
                labelText: 'Address',
              ),

              NormalAuthTextField(
                labelText: 'City',
              ),
              SizedBox(height: 40),
            ],
          ),
        ),
      ),
      bottomSheet: BottomAppButtonContainer(
        child: AppButton(
          onPressed: () {
            Navigator.push(
              context,
              StaarmPageRoute.routeTo(
                builder: (context) => CheckoutView(),
              ),
            );
          },
          text: 'Save & Continue',
        ),
      ),
    );
  }
}
