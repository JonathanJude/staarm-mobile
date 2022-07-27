import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intercom_flutter/intercom_flutter.dart';
import 'package:provider/provider.dart';
import 'package:staarm_mobile/app/storage_helper.dart';
import 'package:staarm_mobile/core/providers/user_provider.dart';
import 'package:staarm_mobile/styles/colors.dart';
import 'package:staarm_mobile/ui/base/base_view.dart';
import 'package:staarm_mobile/ui/views/auth/login_or_signup/login_or_signup_view.dart';
import 'package:staarm_mobile/ui/views/hosts/select_car/select_car_1/select_car_1.dart';
import 'package:staarm_mobile/ui/views/profile/personal_information/personal_information.dart';
import 'package:staarm_mobile/utils/staarm_modal_helpers.dart';
import 'package:staarm_mobile/utils/staarm_page_route.dart';
import 'package:staarm_mobile/widgets/buttons/app_button.dart';
import 'package:staarm_mobile/widgets/indicators/staarm_loader.dart';

import '../learn_about_hosting.dart';
import '../payments_and_payouts.dart';
import '../widgets/profile_item.dart';
import 'view_model.dart';

class ProfileHomeView extends StatelessWidget {
  const ProfileHomeView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BaseView<ProfileHomeViewModel>(
      model: ProfileHomeViewModel(),
      onModelReady: (model) => model.init(),
      builder: (context, model, _) => Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: AppColors.appBackground,
        appBar: AppBar(
          backgroundColor: AppColors.appBackground,
          elevation: 0,
          automaticallyImplyLeading: false,
          centerTitle: false,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Profile',
                style: TextStyle(
                  color: Color(0xFF231F20),
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
        body: Consumer<UserProvider>(
          builder: (context, userProvider, _) => SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 13,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (!userProvider.isLoggedIn)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Login to your profile',
                          style: TextStyle(
                            color: AppColors.grey5,
                            fontSize: 13,
                          ),
                        ),
                        SizedBox(height: 15),
                        AppButton(
                          text: 'Login',
                          onPressed: () {
                            StaarmModalHelpers.fullpageModal(
                              context,
                              child: LoginOrSignupView(),
                              title: 'Log in or sign up',
                            );
                          },
                        ),
                        GestureDetector(
                          onTap: () {
                            StaarmModalHelpers.fullpageModal(
                              context,
                              child: LoginOrSignupView(),
                              title: 'Get started',
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(),
                            child: Text.rich(
                              TextSpan(
                                text: 'Don’t have an account? ',
                                style: TextStyle(
                                  color: Colors.black.withOpacity(.7),
                                  fontSize: 13,
                                ),
                                children: [
                                  TextSpan(
                                    text: ' Get Started',
                                    style: TextStyle(
                                      color: AppColors.mainPurple,
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        ProfileItem(
                          title: 'Learn about hosting',
                          isBold: false,
                          onTap: () {
                            Navigator.push(
                              context,
                              StaarmPageRoute.routeTo(
                                builder: (context) => LearnAboutHosting(),
                              ),
                            );
                          },
                        ),
                        ProfileItem(
                          title: 'Terms of service',
                          onTap: () {},
                          isBold: false,
                        ),
                        ProfileItem(
                          title: 'Privacy policy',
                          onTap: () {},
                          isBold: false,
                        ),
                        ProfileItem(
                          title: 'Contact support',
                          onTap: () async {
                            await Intercom.displayMessenger();
                          },
                          isBold: false,
                        ),
                      ],
                    )
                  else
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            GestureDetector(
                              onTap: model.uploadPhoto,
                              child: Container(
                                height: 60,
                                width: 60,
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  shape: BoxShape.circle,
                                ),
                                child: model.isUploadingPhoto ? StaarmSpinner() : userProvider.user?.profilePic != null &&
                                        userProvider.user.profilePic.isNotEmpty
                                    ? CachedNetworkImage(
                                        imageUrl: userProvider.user.profilePic,
                                        fit: BoxFit.cover,
                                      )
                                    : SizedBox(),
                              ),
                            ),
                            SizedBox(
                              width: 12,
                            ),
                            Consumer<UserProvider>(
                              builder: (context, userProvider, _) => Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    userProvider?.user?.firstName ?? '',
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 24,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(height: 7),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        StaarmPageRoute.routeTo(
                                          builder: (context) =>
                                              PersonalInformation(),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      "View and edit profile",
                                      style: TextStyle(
                                        color: AppColors.grey5,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        Divider(
                          color: AppColors.grey2,
                          thickness: 1.2,
                        ),
                        SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 7,
                          ),
                          child: Text(
                            'Account',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: AppColors.grey5,
                            ),
                          ),
                        ),
                        ProfileItem(
                          title: 'Personal information',
                          onTap: () {
                            Navigator.push(
                              context,
                              StaarmPageRoute.routeTo(
                                builder: (context) => PersonalInformation(),
                              ),
                            );
                          },
                        ),
                        ProfileItem(
                          title: 'Payments and payouts',
                          onTap: () {
                            Navigator.push(
                              context,
                              StaarmPageRoute.routeTo(
                                builder: (context) => PaymentsAndPayoutsView(),
                              ),
                            );
                          },
                        ),
                        // ProfileItem(
                        //   title: 'Favorites',
                        //   onTap: () {
                        //     Navigator.push(
                        //       context,
                        //       StaarmPageRoute.routeTo(
                        //         builder: (context) => FavoritesView(),
                        //       ),
                        //     );
                        //   },
                        // ),
                        //TODO: add favorites back
                        SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 7,
                          ),
                          child: Text(
                            'Hosting',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: AppColors.grey5,
                            ),
                          ),
                        ),
                        ProfileItem(
                          title: 'List your vehicle',
                          onTap: () {
                            Navigator.push(
                              context,
                              StaarmPageRoute.routeTo(
                                builder: (context) => SelectCar1View(),
                              ),
                            );
                          },
                        ),
                        ProfileItem(
                          title: 'Learn about hosting',
                          onTap: () {
                            Navigator.push(
                              context,
                              StaarmPageRoute.routeTo(
                                builder: (context) => LearnAboutHosting(),
                              ),
                            );
                          },
                        ),
                        SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 7,
                          ),
                          child: Text(
                            'Support',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: AppColors.grey5,
                            ),
                          ),
                        ),
                        ProfileItem(
                          title: 'How Staarm works',
                          onTap: () {},
                          isBold: false,
                        ),
                        ProfileItem(
                          title: 'Contact support',
                          onTap: () async {
                            await Intercom.displayMessenger();
                          },
                          isBold: false,
                        ),
                        ProfileItem(
                          title: 'Feedback',
                          onTap: () async {},
                          isBold: false,
                        ),
                        SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 7,
                          ),
                          child: Text(
                            'Legal',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: AppColors.grey5,
                            ),
                          ),
                        ),
                        ProfileItem(
                          title: 'Terms of service',
                          onTap: () {},
                          isBold: false,
                        ),
                        ProfileItem(
                          title: 'Privacy policy',
                          onTap: () {},
                          isBold: false,
                        ),
                        ProfileItem(
                          title: 'Logout',
                          onTap: () {
                            StorageHelper.clear();
                            Provider.of<UserProvider>(context, listen: false)
                                .isLoggedIn = false;
                            // Navigator.of(context).pushAndRemoveUntil(
                            //   StaarmPageRoute.routeTo(
                            //     builder: (context) => GettingStartedView(),
                            //   ),
                            //   (route) => false,
                            // );
                          },
                          isBold: false,
                        ),
                      ],
                    ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 6,
                      ),
                      child: Text(
                        'Version 1.1.0',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black.withOpacity(.8),
                          fontSize: 11,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: size.height * .1),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
