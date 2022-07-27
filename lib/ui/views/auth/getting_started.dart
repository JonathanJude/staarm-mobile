import 'package:flutter/material.dart';
import 'package:staarm_mobile/styles/textstyles.dart';
import 'package:staarm_mobile/utils/staarm_modal_helpers.dart';
import 'package:staarm_mobile/widgets/buttons/app_button.dart';

import 'login/login.dart';
import 'login_or_signup/login_or_signup_view.dart';

class GettingStartedView extends StatelessWidget {
  final bool showCancelIcon;
  const GettingStartedView({
    Key key,
    this.showCancelIcon = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('assets/images/auth_bg.png'),
          ),
        ),
        child: Stack(
          // fit: StackFit.expand,
          children: [
            // Image.asset('assets/images/auth_bg.png'),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: size.height * .05,
                  ),
                  if (showCancelIcon)
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withOpacity(.26),
                        ),
                        child: Icon(
                          Icons.clear,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  Spacer(),
                  Center(
                    child: Text(
                      'A better a way to rent cars.',
                      style: AppTextStyles.input.copyWith(
                        color: Colors.white,
                        fontSize: 17,
                      ),
                    ),
                  ),
                  Spacer(),
                  AppButton(
                    text: 'Get Started',
                    onPressed: () {
                      StaarmModalHelpers.fullpageModal(
                        context,
                        child: LoginOrSignupView(),
                        title: 'Get started',
                      );
                    },
                    color: Colors.white,
                    textColor: Colors.black,
                  ),
                  AppButton(
                    text: 'Login',
                    onPressed: () {
                      StaarmModalHelpers.fullpageModal(
                        context,
                        child: LoginView(
                          phoneNumber: 'phoneNumber',
                        ),
                        title: 'Login',
                      );
                    },
                    color: Colors.white.withOpacity(.32),
                    textColor: Colors.white,
                  ),
                  Text(
                    'By tapping Get Started and using Staarm, you agree to our Terms and Privacy Policy.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white.withOpacity(.6),
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(
                    height: size.height * .07,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
