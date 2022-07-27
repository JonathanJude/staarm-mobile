import 'package:flutter/material.dart';
import 'package:staarm_mobile/styles/colors.dart';

class CarFeatureView extends StatelessWidget {
  const CarFeatureView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Color(0xFF717171),
        ),
        title: Text(
          'Features',
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
              CarFeatureItem(
                icon: Icons.place_outlined,
                text: 'All-wheel-drive',
              ),
              CarFeatureItem(
                icon: Icons.place_outlined,
                text: 'AUX input',
              ),

              CarFeatureItem(
                icon: Icons.place_outlined,
                text: 'Bluetooth',
              ),

              CarFeatureItem(
                icon: Icons.place_outlined,
                text: 'GPS',
              ),

              CarFeatureItem(
                icon: Icons.place_outlined,
                text: 'Child seat',
              ),

              CarFeatureItem(
                icon: Icons.place_outlined,
                text: 'Backup camera',
              ),

              CarFeatureItem(
                icon: Icons.place_outlined,
                text: 'USB charger',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CarFeatureItem extends StatelessWidget {
  final IconData icon;
  final String text;
  const CarFeatureItem({
    Key key,
    @required this.icon,
    @required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          padding: EdgeInsets.symmetric(vertical: 11, horizontal: 11,),
          decoration: BoxDecoration(
            color: Color(0xFF757D8A).withOpacity(.08),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: AppColors.grey5,
            size: 22,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            text,
            style: TextStyle(
              color: Color(0xFF231F20),
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}
