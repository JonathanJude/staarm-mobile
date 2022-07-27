import 'package:flutter/material.dart';
import 'package:staarm_mobile/ui/base/base_view.dart';
import 'package:staarm_mobile/widgets/indicators/staarm_loader.dart';

import '../../../../utils/staarm_modal_helpers.dart';
import '../../../../widgets/app_pin_input.dart';
import '../signup/signup.dart';
import 'view_model.dart';

class VerifyPasswordResetOTPView extends StatelessWidget {
  final String phoneNumber;
  final int verificationId;

  const VerifyPasswordResetOTPView({
    Key key,
    @required this.phoneNumber,
    @required this.verificationId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<VerifyPasswordResetOTPViewModel>(
      model: VerifyPasswordResetOTPViewModel(),
      builder: (context, model, _) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text.rich(
            TextSpan(
              text: 'Enter the OTP sent to ',
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
              ),
              children: [
                TextSpan(
                  text: ' ${phoneNumber}',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: AppPinInput(
              fieldsCount: 6,
              onChanged: (str) {
                model.otp = str;
              },
              onSubmit: (str) {
                model.verifyResetPasswordRequest(
                  verificationId: verificationId,
                  phoneNumber: phoneNumber,
                );
                // StaarmModalHelpers.fullpageModal(
                //   context,
                //   child: SignupView(),
                //   title: 'Complete signing up',
                // );
              },
            ),
          ),
          SizedBox(height: 30),
          Align(
            alignment: Alignment.center,
            child: GestureDetector(
              onTap: () {
                model.resendPhoneNumberOTP(
                  verificationId: verificationId,
                  phoneNumber: phoneNumber,
                );
              },
              child: Text.rich(
                TextSpan(
                  text: 'Haven’t received a code yet? ',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                  ),
                  children: [
                    TextSpan(
                      text: ' Send again',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 25),

          if(model.isLoading)
          Center(
            child: StaarmSpinner(),
          ),

          SizedBox(height: 15),
          // GestureDetector(
          //   onTap: () {
          //     StaarmModalHelpers.normalModal(
          //       context,
          //       child: MoreConfirmationOptions(),
          //       title: 'Confirm your number',
          //     );
          //   },
          //   child: Center(
          //     child: Text(
          //       'More options',
          //       style: TextStyle(
          //           color: Color(0xFF231F20),
          //           fontSize: 14,
          //           decoration: TextDecoration.underline,
          //           fontWeight: FontWeight.w500),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
