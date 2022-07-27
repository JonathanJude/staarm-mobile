import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:staarm_mobile/core/providers/user_provider.dart';
import 'package:staarm_mobile/ui/views/auth/login_or_signup/login_or_signup_view.dart';
import 'package:staarm_mobile/ui/views/hosts/select_car/select_car_1/select_car_1.dart';
import 'package:staarm_mobile/utils/staarm_modal_helpers.dart';
import 'package:staarm_mobile/utils/staarm_page_route.dart';
import 'package:staarm_mobile/widgets/buttons/app_button.dart';

import 'widgets/host_info_row_widget.dart';

class GetStartedHostsView extends StatelessWidget {
  final bool showNavIcon;
  const GetStartedHostsView({
    Key key,
    this.showNavIcon = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Image.asset(
              'assets/images/host_vehicle_1.png',
              height: size.height * .4,
              width: size.width,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: size.height * .35,
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 14,
                ),
                width: size.width,
                constraints: BoxConstraints(
                  minHeight: size.height * .4,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 5,
                      ),
                      child: Text(
                        'Earn on your own terms',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 5,
                      ),
                      child: Text(
                        'Make extra income when you list your car on Staarm.',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    SizedBox(height: 14),
                    HostInfoRowWidget(
                      icon:
                          'assets/icons/svgs/hosts_reliable_earnings_icon.svg',
                      title: 'Reliable earnings',
                      text:
                          'Make money, keep your tips, and use in-app tools to help maximize your earnings.',
                    ),
                    HostInfoRowWidget(
                      icon: 'assets/icons/svgs/hosts_flexibility_icon.svg',
                      title: 'Flexibility',
                      text:
                          'Be your own boss and manage your vehicles availability, schedule for whenever works for you.',
                    ),
                    HostInfoRowWidget(
                      icon: 'assets/icons/svgs/hosts_scalable_icon.svg',
                      title: 'Scalable',
                      text:
                          'Reinvest your earnings and scale your car sharing business or cash out on your investment.',
                    ),
                    SizedBox(height: 20),
                    Consumer<UserProvider>(
                      builder: (context, userProvider, _) => AppButton(
                        text: 'Get Started',
                        onPressed: () {
                          if (userProvider.isLoggedIn) {
                            Navigator.push(
                              context,
                              StaarmPageRoute.routeTo(
                                builder: (context) => SelectCar1View(),
                              ),
                            );
                          } else {
                            StaarmModalHelpers.fullpageModal(
                              context,
                              child: LoginOrSignupView(
                                fromHost: true,
                              ),
                              title: 'Log in or sign up',
                            );
                          }
                        },
                        color: Color(0xFF231F20),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          if(showNavIcon)
          Positioned(
            top: 0,
            left: 0,
            child: GestureDetector(
              onTap: () {
                if (Navigator.of(context).canPop()) {
                  Navigator.of(context).pop();
                }
              },
              child: Container(
                margin: EdgeInsets.only(
                  top: 40,
                  left: 15,
                ),
                padding: EdgeInsets.all(7),
                decoration: BoxDecoration(
                    color: Colors.black.withOpacity(.4),
                    shape: BoxShape.circle),
                child: Icon(
                  Icons.clear,
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
