import 'package:flutter/material.dart';
import 'package:staarm_mobile/ui/base/base_view.dart';
import 'package:staarm_mobile/widgets/indicators/staarm_loader.dart';

import 'view_model.dart';

class PaymentProcessingView extends StatelessWidget {
  const PaymentProcessingView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<PaymentProcessingViewModel>(
      model: PaymentProcessingViewModel(),
      onModelReady: (model) => model.init(),
      builder: (context, model, _) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(
            color: Color(0xFF717171),
          ),
          title: Text(
            'Processing Payment',
            style: TextStyle(
              color: Colors.black,
              fontSize: 14,
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 15,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Spacer(),
              StaarmSpinner(size: 50),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                ),
                child: Text('Please wait..',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
              ),
              Spacer(),
    
              // SizedBox(height: 24),
              // GestureDetector(
              //   onTap: () {
              //     Navigator.push(
              //       context,
              //       StaarmPageRoute.routeTo(
              //         builder: (context) => PaymentMethodsView(),
              //       ),
              //     );
              //   },
              //   child: Container(
              //     padding: EdgeInsets.symmetric(
              //       vertical: 16,
              //       horizontal: 10,
              //     ),
              //     decoration: BoxDecoration(
              //       border: Border.all(
              //         color: Color(0xFFACB1B8),
              //       ),
              //       borderRadius: BorderRadius.circular(8),
              //     ),
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       children: [
              //         Text(
              //           'Add debit card',
              //           textAlign: TextAlign.center,
              //           style: TextStyle(
              //             color: Color(0xFF717171),
              //             fontSize: 14,
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
