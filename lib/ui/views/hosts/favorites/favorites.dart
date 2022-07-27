import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:staarm_mobile/core/providers/vehicle_provider.dart';
import 'package:staarm_mobile/ui/base/base_view.dart';
import 'package:staarm_mobile/ui/views/search/widgets/search_car_widget.dart';

import 'view_model.dart';

class FavoritesView extends StatelessWidget {
  const FavoritesView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<FavoritesViewModel>(
      model: FavoritesViewModel(),
      builder: (context, model, _) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(
            color: Color(0xFF717171),
          ),
          title: Text(
            'Favorites',
            style: TextStyle(
              color: Colors.black,
              fontSize: 14,
            ),
          ),
        ),
        body: Consumer<VehicleProvider>(
          builder: (contetxt, vehicleProvider, _) => SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 15,
              ),
              child: Column(
                children: [
                  SizedBox(height: 20),
                  if (vehicleProvider.favoriteVehicles.length == 0)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 16),
                        Center(
                          child: Image.asset(
                            'assets/images/favorite_icon.png',
                            height: 68,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 24,
                          ),
                          child: Text(
                            'You have no favorites yet',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    )
                  else
                    Column(
                        children: vehicleProvider.favoriteVehicles.map((e) {
                      return SearchCarWidget(
                        widthFactor: .7,
                        vehicle: e,
                      );
                    }).toList()),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
