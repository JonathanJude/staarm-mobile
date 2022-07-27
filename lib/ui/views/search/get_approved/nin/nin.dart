import 'package:flutter/material.dart';
import 'package:staarm_mobile/ui/base/base_view.dart';
import 'package:staarm_mobile/widgets/buttons/app_button.dart';
import 'package:staarm_mobile/widgets/buttons/bottom_app_button_container.dart';
import 'package:staarm_mobile/widgets/textfields/normal_auth_textfield.dart';

import 'view_model.dart';

class KYCNinView extends StatelessWidget {
  const KYCNinView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<KYCNinViewModel>(
      model: KYCNinViewModel(),
      builder: (context, model, _) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(
            color: Color(0xFF717171),
          ),
          title: Text(
            'National Identity Number (NIN)',
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
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6.0),
                  child: Text(
                    'Your NIN will be used to confirm your identity.',
                    style: TextStyle(
                      color: Color(0xFF231F20),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                NormalAuthTextField(
                  labelText: 'NIN',
                  onChanged: (str){
                    model.nin = str;
                  },
                ),
    
                SizedBox(height: 40),
              ],
            ),
          ),
        ),
        bottomSheet: BottomAppButtonContainer(
          child: AppButton(
            isLoading: model.isLoading,
            disabled: model.nin.isEmpty,
            onPressed: () {
              model.storeNIN();

              // Navigator.push(
              //   context,
              //   StaarmPageRoute.routeTo(
              //     builder: (context) => KYCDriverslicenceView(),
              //   ),
              // );
            },
            text: 'Save & Continue',
          ),
        ),
      ),
    );
  }
}
