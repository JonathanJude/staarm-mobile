import 'package:flutter/material.dart';
import 'package:staarm_mobile/styles/colors.dart';
import 'package:staarm_mobile/widgets/buttons/app_button.dart';

class LearnAboutHosting extends StatefulWidget {
  const LearnAboutHosting({Key key}) : super(key: key);

  @override
  _LearnAboutHostingState createState() => _LearnAboutHostingState();
}

class _LearnAboutHostingState extends State<LearnAboutHosting> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/images/learn_about_hosting.png',
            height: size.height,
            fit: BoxFit.fitWidth,
            width: size.width,
          ),
          SingleChildScrollView(
            physics: ClampingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: size.height * .5),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Amaka',
                        style: TextStyle(
                          fontFamily: 'Shadows Into Light',
                          color: Colors.white,
                          fontSize: 30,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 4,
                        ),
                        child: Text(
                          'Host in Abuja',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.only(
                    top: 10,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                  ),
                  child: Column(
                    children: [
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15,
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 10,
                                ),
                                child: Text(
                                  'A better hosting experience',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 36,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                ),
                                child: Divider(
                                  color: AppColors.grey5,
                                ),
                              ),
                              AppButton(
                                text: 'Start Hosting',
                                color: Colors.black,
                                textColor: Colors.white,
                                onPressed: () {},
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 10,
                                ),
                                child: Text(
                                  'Anyone, anywhere is welcome to be a host.',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 24,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 17),
                      SizedBox(
                        height: size.height * .5,
                        child: Stack(
                          children: [
                            Column(
                              children: [
                                Container(
                                  height: size.height * .18,
                                  color: Colors.white,
                                ),
                                Container(
                                  height: size.height * .25,
                                  color: Colors.black,
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 0,
                              ),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    HostsExperiences(
                                      image: 'assets/images/car_exp_1.png',
                                    ),
                                    HostsExperiences(
                                      image: 'assets/images/car_exp_2.png',
                                    ),
                                    HostsExperiences(
                                      image: 'assets/images/car_exp_2.png',
                                    ),
                                    HostsExperiences(
                                      image: 'assets/images/car_exp_2.png',
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 14,
                        ),
                        color: Colors.black,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.asset(
                              'assets/images/learn_about_hosting_2.png',
                              fit: BoxFit.fitWidth,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 2,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 20),
                                  Text(
                                    'Everyone is welcome to be a host',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                  ),
                                  SizedBox(height: 15),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 15,
                                    ),
                                    child: Text(
                                      'Whether you’re hosting a few cars to earn extra income or building a small shop with a portfolio of cars, you can start with one car and scale however you want',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                  Text.rich(
                                    TextSpan(
                                      text: 'Earn an average income of ',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 24,
                                      ),
                                      children: [
                                        TextSpan(
                                          text: ' N1,200,000 ',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 24,
                                          ),
                                        ),
                                        TextSpan(
                                          text: ' monthly when you host',
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 24,
                                          ),
                                        ),
                                        TextSpan(
                                          text: ' 3 cars',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 24,
                                          ),
                                        ),
                                        TextSpan(
                                          text: ' on Staarm',
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 24,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  Divider(
                                    color: Colors.white,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 6,
                                    ),
                                    child: Text(
                                      'Host you car',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                  Divider(
                                    color: Colors.white,
                                  ),
                                  SizedBox(height: 20),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20,
                                    ),
                                    child: AppButton(
                                      color: Colors.white,
                                      textColor: Colors.black,
                                      text: "Let's go!",
                                      onPressed: () {
                                        //
                                      },
                                    ),
                                  ),
                                  SizedBox(height: 30),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          GestureDetector(
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
                  color: Colors.black.withOpacity(.4), shape: BoxShape.circle),
              child: Icon(
                Icons.clear,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class HostsExperiences extends StatelessWidget {
  final String image;
  final String text;
  const HostsExperiences({Key key, this.image, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.only(
        right: 13,
        left: 10,
      ),
      width: size.width * .6,
      height: size.height * .5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.asset(
              image ?? 'assets/images/car_exp_1.png',
              height: size.height * .25,
              width: size.width * .5,
              fit: BoxFit.fill,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
            ),
            child: Text(
              text ??
                  'Hosting my car has definitely given me the financial freedom I need and now I have time for my hubbies.',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Amaka',
                  style: TextStyle(
                    fontFamily: 'Shadows Into Light',
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 4,
                  ),
                  child: Text(
                    'Host in Abuja',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
