import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:staarm_mobile/widgets/indicators/staarm_shimmers.dart';

class SkeletalLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SizedBox(
        child: Shimmer.fromColors(
            highlightColor: Colors.white,
            baseColor: Colors.grey[300],
            child: Column(
              children: [
                StaarmShimmers.loadCars(),
              ],
            )),
      ),
    );
  }
}