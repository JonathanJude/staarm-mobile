import 'package:flutter/material.dart';
import 'package:staarm_mobile/ui/base/base_view.dart';

import '../../../../styles/colors.dart';
import '../../../../styles/textstyles.dart';
import '../../../../utils/staarm_modal_helpers.dart';
import '../../../../widgets/buttons/app_button.dart';
import '../../../../widgets/buttons/auth_dob_button.dart';
import '../../../../widgets/textfields/normal_auth_textfield.dart';
import '../confirm_phone_number/confirm_phone_number.dart';
import 'view_model.dart';

class ResetPasswordView extends StatelessWidget {
  final String phoneNumber;
  final int verificationId;
  const ResetPasswordView({
    Key key,
    @required this.phoneNumber,
    @required this.verificationId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<ResetPasswordViewModel>(
      model: ResetPasswordViewModel(),
      builder: (context, model, _) => Form(
        key: model.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             NormalAuthTextField(
            labelText: 'Password',
            obscureText: !model.showPassword,
            onChanged: (str){
              model.password = str;
            },
            suffix: GestureDetector(
              onTap: model.togglePassword,
              child: Icon(
                !model.showPassword ? Icons.visibility : Icons.visibility_off,
                color: AppColors.grey5,
                size: 22,
              ),
            ),
          ),


           NormalAuthTextField(
            labelText: 'Password',
            obscureText: !model.showPassword,
            onChanged: (str){
              model.password = str;
            },
            suffix: GestureDetector(
              onTap: model.togglePassword,
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
            CheckboxListTile(
              controlAffinity: ListTileControlAffinity.leading,
              title: Text(
                'Send me deals, discounts and updates',
                style: AppTextStyles.toolInfo.copyWith(
                  color: Color(0xFF231F20),
                  fontSize: 13,
                ),
              ),
              value: false,
              onChanged: (val) {},
            ),
            SizedBox(height: 20),
            AppButton(
              text: 'Agree and continue',
              color: Colors.black,
              textColor: Colors.white,
              isLoading: model.isLoading,
              onPressed: () {
                model.resetPassword(
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
