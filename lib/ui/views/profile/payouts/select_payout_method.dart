import 'package:flutter/material.dart';

class SelectPaymentMethod extends StatelessWidget {
  const SelectPaymentMethod({Key key}) : super(key: key);

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
                  'How would you like to pay?',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 21,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   StaarmPageRoute.routeTo(
                  //     builder: (context) => AddCardView(),
                  //   ),
                  // );

                  // Navigator.push(
                  //   context,
                  //   StaarmPageRoute.routeTo(
                  //     builder: (context) => PaymentMethodsView(),
                  //   ),
                  // );
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
                        'Pay with debit card',
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
              SizedBox(height: 12),
              Container(
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
                      'Pay with Paystack',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF717171),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
