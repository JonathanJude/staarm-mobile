import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../utils/constants.dart';

class BoookingCarouselImage extends StatelessWidget {
  final String image;
  const BoookingCarouselImage({Key key, @required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return CachedNetworkImage(imageUrl: image,
    fit: BoxFit.cover,
      height: kBookingTopBarHeight,
      width: double.infinity,
    );

    // return Image.asset(
    //   'assets/images/mock_images/car_image_2.png',
    //   fit: BoxFit.cover,
    //   height: kBookingTopBarHeight,
    //   width: double.infinity,
    // );
  }
}