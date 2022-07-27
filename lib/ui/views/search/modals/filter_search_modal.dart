import 'package:flutter/material.dart';

import '../../../../styles/textstyles.dart';
import '../../../../widgets/app_divider.dart';

class FilterSearchModal extends StatefulWidget {
  const FilterSearchModal({Key key}) : super(key: key);

  @override
  _FilterSearchModalState createState() => _FilterSearchModalState();
}

class _FilterSearchModalState extends State<FilterSearchModal> {
  List<String> _features = [
    'All wheel-drive',
    'AUX Input',
    'Backup camera',
    'Bluetooth',
    'Child seat',
    'Convertible',
    'GPS',
    'USB Charger',
  ];

  List<String> _vehicleTypes = [
    'Cars',
    'SUVs',
    'Minivans',
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Align(
      alignment: Alignment.topLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Price',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 6.0),
            child: Text('₦15,000 - ₦150,000 +/day',
                style:
                    AppTextStyles.toolInfo.copyWith(color: Color(0xFF231F20))),
          ),
          AppDivider(
            height: 20,
            color: Color(0xFFE7E7E8),
          ),
          SwitchListTile.adaptive(
            contentPadding: EdgeInsets.zero,
            title: Text(
              'Book Instantly',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 6.0),
              child: Text(
                'Book without waiting for the host to respond',
                style: AppTextStyles.toolInfo.copyWith(
                  color: Color(0xFF717171),
                ),
              ),
            ),
            value: true,
            onChanged: (val) {},
          ),
          AppDivider(
            height: 20,
            color: Color(0xFFE7E7E8),
          ),
          SwitchListTile.adaptive(
            contentPadding: EdgeInsets.zero,
            title: Text(
              'Delivery',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 6.0),
              child: Text(
                'Get the car delivered directly to you',
                style: AppTextStyles.toolInfo.copyWith(
                  color: Color(0xFF717171),
                ),
              ),
            ),
            value: true,
            onChanged: (val) {},
          ),
          AppDivider(
            height: 20,
            color: Color(0xFFE7E7E8),
          ),
          SwitchListTile.adaptive(
            contentPadding: EdgeInsets.zero,
            title: Text(
              'Chauffer',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 6.0),
              child: Text(
                'Get driven around all day to anywhere at anytime',
                style: AppTextStyles.toolInfo.copyWith(
                  color: Color(0xFF717171),
                ),
              ),
            ),
            value: true,
            onChanged: (val) {},
          ),
          AppDivider(
            height: 20,
            color: Color(0xFFE7E7E8),
          ),
          SizedBox(height: 15),
          Text(
            'Features',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
          GridView.count(
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 3,
              shrinkWrap: true,
              children: _features
                  .map(
                    (feature) => CarFeatureBox(
                      text: feature,
                    ),
                  )
                  .toList()),
          AppDivider(
            height: 10,
            color: Color(0xFFE7E7E8),
          ),
          Text(
            'Vehicle type',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
          GridView.count(
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 3,
              shrinkWrap: true,
              children: _vehicleTypes
                  .map(
                    (type) => CarFeatureBox(
                      text: type,
                    ),
                  )
                  .toList()),
          AppDivider(
            height: 0,
            color: Color(0xFFE7E7E8),
          ),
          SizedBox(height: size.height * .08),
        ],
      ),
    );
  }
}

class CarFeatureBox extends StatelessWidget {
  final String text;
  const CarFeatureBox({Key key, @required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      padding: EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 12,
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: Colors.black,
          )),
      child: Column(
        children: [
          SizedBox(height: 35),
          Text(
            text ?? '',
            style: AppTextStyles.label,
          ),
        ],
      ),
    );
  }
}
