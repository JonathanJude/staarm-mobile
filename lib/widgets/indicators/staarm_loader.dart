import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:staarm_mobile/styles/colors.dart';

class StaarmSpinner extends StatelessWidget {
  final double size;
  final bool isBlue;

  const StaarmSpinner({
    Key key,
    this.size = 40.0,
    this.isBlue = true,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SpinKitCircle(
      color: isBlue ? AppColors.mainPurple : Colors.white,
      size: size,
    );
  }
}
