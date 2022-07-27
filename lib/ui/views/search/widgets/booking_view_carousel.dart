import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:staarm_mobile/ui/views/search/booking/booking_view/image_carousel.dart';
import 'package:staarm_mobile/utils/staarm_page_route.dart';

import '../../../../styles/textstyles.dart';
import '../../../../utils/constants.dart';
import 'booking_carousel_image.dart';

class BookingViewCarousel extends StatefulWidget {
  final List<String> images;
  const BookingViewCarousel({Key key, @required this.images}) : super(key: key);

  @override
  State<BookingViewCarousel> createState() => _BookingViewCarouselState();
}

class _BookingViewCarouselState extends State<BookingViewCarousel> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          StaarmPageRoute.routeTo(
            builder: (context) => CarImagesCarousel(
              images: widget.images,
            ),
          ),
        );
      },
      child: Container(
        height: kBookingTopBarHeight,
        child: Stack(
          fit: StackFit.loose,
          clipBehavior: Clip.none,
          children: [
            CarouselSlider(
              options: CarouselOptions(
                height: (kBookingTopBarHeight - 10),
                // aspectRatio: 16 / 9,
                viewportFraction: 1,
                initialPage: 0,
                enableInfiniteScroll: false,
                scrollPhysics: ClampingScrollPhysics(),
                reverse: false,
                autoPlay: false,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: false,
                scrollDirection: Axis.horizontal,
                onPageChanged: (_index, reason) {
                      setState(() {
                        index = _index;
                      });
                    },
              ),
              items: widget.images.map((e) {
                return Builder(
                  builder: (BuildContext context) {
                    return BoookingCarouselImage(
                      image: e,
                    );
                  },
                );
              }).toList(),
            ),
            Positioned(
              right: 16,
              bottom: 20,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(.4),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  // '1 of ${images.length}',
                  '${index + 1} of  ${widget.images.length}',
                  style: AppTextStyles.toolInfo.copyWith(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
