import 'package:flutter/material.dart';
import 'package:staarm_mobile/ui/base/base_view.dart';
import 'package:staarm_mobile/widgets/hide_keyboard_on_tap.dart';

import '../../../../styles/textstyles.dart';
import '../../../../widgets/buttons/app_button.dart';
import '../../../../widgets/textfields/phone_number_textfield.dart';
import 'view_model.dart';

class LoginOrSignupView extends StatelessWidget {
  final bool fromBooking;
  final bool fromHost;
  const LoginOrSignupView({
    Key key,
    this.fromBooking = false,
    this.fromHost = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<LoginOrSignupViewModel>(
      model: LoginOrSignupViewModel(),
      onModelReady: (model) => model.init(isFromHost: fromHost),
      builder: (context, model, _) => HideKeyboardOnTap(
        child: Form(
          key: model.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PhoneNumberTextField(
                validator: model.phoneNumberValidator,
                onSave: model.savePhoneNumber,
              ),
              Text(
                'We’ll send a text or call to confirm your number.',
                style: AppTextStyles.toolInfo,
              ),
              SizedBox(height: 30),
              AppButton(
                text: 'Continue',
                isLoading: model.isLoading,
                onPressed: () {
                  model.startRegistration();
                },
              ),
              SizedBox(height: 20),

              // OrWidget(),

              // SizedBox(height: 20),

              // AppOutlineButton(
              //   icon: MdiIcons.phone,
              //   title: 'Continue with Phone number',
              //   onTap: () {
              //     StaarmModalHelpers.fullpageModal(
              //       context,
              //       child: LoginView(),
              //       title: 'Log in',
              //     );
              //     //LoginView
              //   },
              // ),

              // AppOutlineButton(
              //   icon: MdiIcons.apple,
              //   title: 'Continue with Apple',
              //   onTap: () {},
              // ),

              // AppOutlineButton(
              //   icon: MdiIcons.google,
              //   title: 'Continue with Google',
              //   onTap: () {},
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
