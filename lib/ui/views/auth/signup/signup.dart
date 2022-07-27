import 'package:flutter/material.dart';
import 'package:staarm_mobile/ui/base/base_view.dart';

import '../../../../styles/colors.dart';
import '../../../../styles/textstyles.dart';
import '../../../../widgets/buttons/app_button.dart';
import '../../../../widgets/textfields/normal_auth_textfield.dart';
import 'view_model.dart';

class SignupView extends StatelessWidget {
  final String phoneNumber;
  final int verificationId;
  final bool fromHost;
  const SignupView({
    Key key,
    @required this.phoneNumber,
    @required this.verificationId,
    this.fromHost = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<SignupViewModel>(
      model: SignupViewModel(),
      onModelReady: (model) => model.init(isFromHost: fromHost),
      builder: (context, model, _) => Form(
        key: model.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            NormalAuthTextField(
              labelText: 'First name',
              validator: model.fieldValidator,
              onSave: model.saveFirstName,
              maxLines: 1,
            ),
            NormalAuthTextField(
              labelText: 'Last name',
              validator: model.fieldValidator,
              onSave: model.saveLastName,
              maxLines: 1,
            ),
            Text(
              'Make sure it matches the name on your government ID.',
              style: AppTextStyles.toolInfo,
            ),
            SizedBox(height: 15),
            NormalAuthTextField(
              labelText: 'Email address',
              validator: model.emailValidator,
              onSave: model.saveEmail,
              maxLines: 1,
            ),
            Text(
              'We’ll email you trip confirmations and receipts.',
              style: AppTextStyles.toolInfo,
            ),
            // SizedBox(height: 15),
            // AuthDOBButton(),
            // Text(
            //   'You must at least be 18 to sign up on Starrm.',
            //   style: AppTextStyles.toolInfo,
            // ),
            SizedBox(height: 15),
            NormalAuthTextField(
              labelText: 'Password',
              validator: model.fieldValidator,
              onSave: model.savePassword,
              obscureText: !model.showPassword,
              maxLines: 1,
              suffix: GestureDetector(
                onTap: () {
                  model.showPassword = !model.showPassword;
                },
                child: Icon(
                  !model.showPassword ? Icons.visibility : Icons.visibility_off,
                  color: AppColors.grey5,
                  size: 22,
                ),
              ),
            ),
            SizedBox(height: 14),
            Text.rich(
              TextSpan(
                text:
                    'By selecting agree and continue below, I agree to Staarm’s ',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                ),
                children: [
                  TextSpan(
                    text: ' Terms of Service ',
                    style: TextStyle(
                      color: AppColors.mainPurple,
                      fontSize: 14,
                    ),
                  ),
                  TextSpan(
                    text: 'and',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  ),
                  TextSpan(
                    text: ' Privacy policy. ',
                    style: TextStyle(
                      color: AppColors.mainPurple,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 14),
            // CheckboxListTile(
            //   controlAffinity: ListTileControlAffinity.leading,
            //   title: Text(
            //     'Send me deals, discounts and updates',
            //     style: AppTextStyles.toolInfo.copyWith(
            //       color: Color(0xFF231F20),
            //       fontSize: 13,
            //     ),
            //   ),
            //   value: false,
            //   onChanged: (val) {},
            // ),
            // SizedBox(height: 20),
            AppButton(
              text: 'Agree and continue',
              color: Colors.black,
              textColor: Colors.white,
              isLoading: model.isLoading,
              onPressed: () {
                model.completeRegistration(
                  phoneNumber: phoneNumber,
                  verificationId: verificationId,
                );

                // StaarmModalHelpers.fullpageModal(
                //   context,
                //   child: ConfirmPhoneNumber(),
                //   title: 'Confirm your number',
                // );
              },
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
