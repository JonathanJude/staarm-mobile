import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:staarm_mobile/core/models/bank_model.dart';
import 'package:staarm_mobile/core/providers/payment_provider.dart';
import 'package:staarm_mobile/ui/base/base_view.dart';
import 'package:staarm_mobile/utils/app_helper.dart';
import 'package:staarm_mobile/widgets/app_dropdown_container.dart';
import 'package:staarm_mobile/widgets/buttons/app_button.dart';
import 'package:staarm_mobile/widgets/buttons/bottom_app_button_container.dart';
import 'package:staarm_mobile/widgets/indicators/staarm_loader.dart';
import 'package:staarm_mobile/widgets/info_container.dart';
import 'package:staarm_mobile/widgets/textfields/normal_auth_textfield.dart';

import 'view_model.dart';

class AddBankView extends StatelessWidget {
  const AddBankView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<AddBankViewModel>(
      model: AddBankViewModel(),
      onModelReady: (model) => model.init(),
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
                    'Add bank account details',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 21,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                InfoContainer(
                  text:
                      'This is the bank account you would want your earnings to be deposited into.',
                ),
                Consumer<PaymentProvider>(
                  builder: (context, paymentProvider, _) => AppDropdownButton(
                      hint: 'Bank Name',
                      value: model.selectedBank?.bankName,
                      onTap: () {
                        AppHelper.showPicker<BankModel>(context,
                            items: paymentProvider.bankList,
                            dropdownItem: paymentProvider.bankList
                                .map(
                                  (e) => Text(
                                    e.bankName,
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                )
                                .toList(), onSelect: (val) {
                          model.selectedBank = val;
                        });
                      }),
                ),
                NormalAuthTextField(
                  labelText: 'Bank account number',
                  textInputType: TextInputType.number,
                  controller: model.bankNumberTextEditingController,
                  onChanged: (str) => model.onBankAccountNumberChanged(str),
                ),
                SizedBox(height: 12),
                if (model.isVerifying) StaarmSpinner(size: 30),
                if (model.accountName != null &&
                    model.bankAccountVerificationId != null)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 3,
                        ),
                        child: Text(
                          'Bank account name',
                          style: TextStyle(
                            color: Color(0xFF717171),
                            fontSize: 10,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 5,
                        ),
                        child: Text(
                          model.accountName ?? '',
                          style: TextStyle(
                            color: Color(0xFF231F20),
                            fontSize: 14,
                          ),
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
            isLoading: model.isLoading,
            onPressed: () {
              model.addBankAccount();
            },
            text: 'Next',
          ),
        ),
      ),
    );
  }
}
