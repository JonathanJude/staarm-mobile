import 'package:flutter/material.dart';
import 'package:staarm_mobile/ui/base/base_view.dart';
import 'package:staarm_mobile/ui/views/auth/forgot_password/view_model.dart';
import 'package:staarm_mobile/widgets/textfields/phone_number_textfield.dart';

import '../../../../styles/textstyles.dart';
import '../../../../utils/staarm_modal_helpers.dart';
import '../../../../widgets/buttons/app_button.dart';
import '../../../../widgets/textfields/normal_auth_textfield.dart';
import '../confirm_phone_number/confirm_phone_number.dart';

class ForgotPasswordView extends StatelessWidget {
  const ForgotPasswordView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<ResetPasswordViewModel>(
      model: ResetPasswordViewModel(),
      builder: (context, model, _) => Form(
        key: model.formKey,
              child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Kindly enter the phone number associate with your account, and we’d send an OTP to reset your password',
              style: AppTextStyles.input,
            ),
            SizedBox(height: 30),
            PhoneNumberTextField(
              validator: model.phoneNumberValidator,
              onSave: model.savePhoneNumber,
            ),

            // NormalAuthTextField(
            //   labelText: 'Email address',
            // ),
            SizedBox(height: 20),
            AppButton(
              text: 'Reset Password',
              color: Colors.black,
              textColor: Colors.white,
              isLoading: model.isLoading,
              onPressed: () {

                model.requestResetPassword();
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
