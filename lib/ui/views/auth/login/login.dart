import 'package:flutter/material.dart';
import 'package:staarm_mobile/app/locator.dart';
import 'package:staarm_mobile/core/services/navigator_service.dart';
import 'package:staarm_mobile/ui/base/base_view.dart';
import 'package:staarm_mobile/ui/views/auth/login/view_model.dart';
import 'package:staarm_mobile/widgets/textfields/phone_number_textfield.dart';

import '../../../../styles/colors.dart';
import '../../../../utils/staarm_modal_helpers.dart';
import '../../../../values/images.dart';
import '../../../../widgets/buttons/app_button.dart';
import '../../../../widgets/textfields/normal_auth_textfield.dart';
import '../forgot_password/forgot_password.dart';

class LoginView extends StatelessWidget {
  final bool fromBooking;
  final bool fromHost;
  final String phoneNumber;
  LoginView({
    Key key,
    this.fromBooking = false,
    this.fromHost = false,
    @required this.phoneNumber,
  }) : super(key: key);

  final _navService = locator<NavigationService>();

  @override
  Widget build(BuildContext context) {
    return BaseView<LoginViewModel>(
      model: LoginViewModel(),
      onModelReady: (model) => model.init(
        phoneNumber,
        isFromHost: fromHost,
      ),
      builder: (context, model, _) => Form(
        key: model.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              AppImages.staarmPurpleLogo,
              height: 58,
              width: 58,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 22.0),
              child: Text(
                'Welcome to Staarm',
                style: TextStyle(
                  color: AppColors.mainBlack,
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(height: 10),
            PhoneNumberTextField(
              validator: model.phoneNumberValidator,
              onSave: model.savePhoneNumber,
              controller: model.phoneNumberController,
            ),
            // SizedBox(height: 10),

            NormalAuthTextField(
              labelText: 'Password',
              obscureText: !model.showPassword,
              onChanged: (str) {
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
            SizedBox(height: 30),
            AppButton(
              text: 'Continue',
              isLoading: model.isLoading,
              onPressed: () {
                model.login();
              },
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                StaarmModalHelpers.fullpageModal(
                  context,
                  child: ForgotPasswordView(),
                  title: 'Reset Password',
                );
              },
              child: Center(
                child: Text(
                  'Forgot password',
                  style: TextStyle(
                    color: Color(0xFF231F20),
                    fontSize: 14,
                    decoration: TextDecoration.underline,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
