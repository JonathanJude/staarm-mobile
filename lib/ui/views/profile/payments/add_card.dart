import 'package:flutter/material.dart';
import 'package:staarm_mobile/widgets/buttons/app_button.dart';
import 'package:staarm_mobile/widgets/buttons/bottom_app_button_container.dart';
import 'package:staarm_mobile/widgets/textfields/normal_auth_textfield.dart';

class AddCardView extends StatelessWidget {
  const AddCardView({Key key}) : super(key: key);

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
                  vertical: 17,
                ),
                child: Text(
                  'Add card details',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 21,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              NormalAuthTextField(
                labelText: 'Card number',
                suffix: Icon(
                  Icons.credit_card,
                  color: Color(0xFF757D8A),
                  size: 19,
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: NormalAuthTextField(
                      labelText: 'Expiration date',
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: NormalAuthTextField(
                      labelText: 'Security code',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomSheet: BottomAppButtonContainer(
        child: AppButton(
          onPressed: () {
            // Navigator.push(
            //       context,
            //       StaarmPageRoute.routeTo(
            //         builder: (context) => ProfilePictureGetApproved(),
            //       ),
            //     );
          },
          text: 'Next',
        ),
      ),
    );
  }
}
