import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:staarm_mobile/styles/textstyles.dart';
import 'package:staarm_mobile/ui/views/search/widgets/booking_appbar_icon_button.dart';

class CarImagesCarousel extends StatefulWidget {
  final List<String> images;
  const CarImagesCarousel({Key key, @required this.images}) : super(key: key);

  @override
  State<CarImagesCarousel> createState() => _CarImagesCarouselState();
}

class _CarImagesCarouselState extends State<CarImagesCarousel> {
  Widget _carImage(Size size, String image) {
    return CachedNetworkImage(
      imageUrl: image,
      fit: BoxFit.cover,
      height: size.height * .8,
      width: size.width,
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: BookingAppBarIconButton(
          icon: Icons.arrow_back_ios_new_outlined,
          padding: 2,
          iconColor: Colors.white,
          color: Colors.white.withOpacity(.5),
          onTap: () {
            if (Navigator.of(context).canPop()) {
              Navigator.of(context).pop();
            } else {
              Navigator.of(context).popAndPushNamed('/main');
            }
          },
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              SizedBox(height: size.height * .2),

              Hero(
                tag: 'car_images',
                child: CarouselSlider(
                  options: CarouselOptions(
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
                        return _carImage(size, e);
                      },
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              margin: EdgeInsets.only(bottom: 38),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(.24),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text('${index + 1} of  ${widget.images.length}',
                  style: AppTextStyles.toolInfo.copyWith(color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }

  int index = 0;
}
