import 'package:flutter/material.dart';
import 'package:staarm_mobile/styles/colors.dart';
import 'package:staarm_mobile/widgets/indicators/staarm_shimmers.dart';

class LoadingHostsView extends StatelessWidget {
  const LoadingHostsView({ Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          backgroundColor: AppColors.appBackground,
          appBar: AppBar(
            backgroundColor: AppColors.appBackground,
            elevation: 0,
            automaticallyImplyLeading: false,
            centerTitle: true,
            title: Text(
              'Hosts',
              style: TextStyle(
                color: Color(0xFF231F20),
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          body: Container(
            padding: EdgeInsets.symmetric(vertical: 36, horizontal: 24,),
            child: StaarmShimmers.loadCars(),
          ),
        );
  }
}