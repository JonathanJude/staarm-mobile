import 'package:flutter/material.dart';
import 'package:staarm_mobile/styles/colors.dart';
import 'package:staarm_mobile/widgets/rating_star.dart';

class RatingsView extends StatelessWidget {
  const RatingsView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Color(0xFF717171),
        ),
        title: Text(
          'Ratings & Reviews',
          style: TextStyle(
            color: Colors.black,
            fontSize: 14,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 17,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  RatingsStarWidget(
                    count: 1,
                    size: 25,
                  ),
                  SizedBox(width: 10),
                  Text(
                    '4.6  (67 reviews)',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),

              CarRatingsAndReviewWidget(),
              CarRatingsAndReviewWidget(),
              CarRatingsAndReviewWidget(),
              CarRatingsAndReviewWidget(),
              CarRatingsAndReviewWidget(),
            ],
          ),
        ),
      ),
    );
  }
}


class CarRatingsAndReviewWidget extends StatelessWidget {
  const CarRatingsAndReviewWidget({ Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 15,
      ),
      child: Column(
        children: [
          Row(
              children: [
                Container(
                  height: 40,
                  width: 40,
                  decoration:
                      BoxDecoration(color: Color(0xFFF4F5F6), shape: BoxShape.circle),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 13.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Yinka',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 6.0),
                            child: Text(
                              '13 Jul 2021',
                              style: TextStyle(
                                color: Color(0xFF717171),
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                      RatingsStarWidget(
                        count: 5,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0, bottom: 10),
              child: Text(
                'Perfect trip with this car when I expereinced Abuja for the first time. Great and fast pick up, would definitely always call for this  car.',
                style: TextStyle(
                  color: Color(0xFF717171),
                  fontSize: 14,
                ),
              ),
            ),

          Padding(
              padding: const EdgeInsets.only(top: 10.0, bottom: 10, left: 30,),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Response from Aremu:',
                    style: TextStyle(
                      color: Color(0xFF231F20),
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      'Perfect trip with this car when I expereinced Abuja for the first time. Great and fast pick up, would definitely always call for this  car.',
                      style: TextStyle(
                        color: Color(0xFF717171),
                        fontSize: 14,
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