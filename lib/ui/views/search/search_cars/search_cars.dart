import 'package:flutter/material.dart';
import 'package:staarm_mobile/core/models/address_model.dart';
import 'package:staarm_mobile/styles/colors.dart';
import 'package:staarm_mobile/ui/base/base_view.dart';
import 'package:staarm_mobile/ui/views/trips/trips_empty_state.dart';
import 'package:staarm_mobile/widgets/app_divider.dart';
import 'package:staarm_mobile/widgets/indicators/staarm_shimmers.dart';

import '../../../../utils/staarm_modal_helpers.dart';
import '../../../../widgets/buttons/app_button.dart';
import '../modals/filter_search_modal.dart';
import '../widgets/search_car_widget.dart';
import 'view_model.dart';

class SearchCarsView extends StatefulWidget {
  final AddressModel location;
  final DateTime pickupDate;
  final DateTime returnDate;
  final DateTime pickupTime;
  final DateTime returnTime;
  const SearchCarsView({
    Key key,
    @required this.location,
    @required this.pickupDate,
    @required this.returnDate,
    @required this.pickupTime,
    @required this.returnTime,
  }) : super(key: key);

  @override
  _SearchCarsViewState createState() => _SearchCarsViewState();
}

class _SearchCarsViewState extends State<SearchCarsView> {
  bool _isEdit = false;

  _toggleEdit() {
    setState(() {
      _isEdit = !_isEdit;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BaseView<SearchCarsViewModel>(
      model: SearchCarsViewModel(),
      onModelReady: (model) => model.init(
        widget.location,
        widget.pickupDate,
        widget.pickupTime,
        widget.returnDate,
        widget.returnTime,
      ),
      builder: (context, model, _) => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          toolbarHeight: kToolbarHeight + (_isEdit ? 90 : 20),
          leading: Padding(
            padding: const EdgeInsets.only(left: 6.0),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Icon(Icons.arrow_back_ios,
                  color: Color(0xFF717171), size: 22),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(
                right: 14.0,
                left: 10,
              ),
              child: GestureDetector(
                onTap: () {
                  StaarmModalHelpers.fullpageModal(
                    context,
                    child: FilterSearchModal(),
                    title: 'Filters',
                    bottomChild: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      padding: EdgeInsets.symmetric(
                        vertical: 15,
                        horizontal: 27,
                      ),
                      child: Row(
                        children: [
                          Text(
                            'Reset',
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: Colors.black),
                          ),
                          Spacer(),
                          AppButton(
                            text: 'View ${model.vehicles.length} Results',
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                  );
                },
                child: Icon(
                  Icons.tune,
                  color: Color(0xFF717171),
                  size: 25,
                ),
              ),
            ),
          ],
          title: SearchCarsHeader(
            isEdit: _isEdit,
            locatioName: widget.location?.name,
            tripPeriod: model.getTripPeriod,
            onTap: () => _toggleEdit(),
          ),
          bottom: _isEdit
              ? PreferredSize(
                  preferredSize: Size.fromHeight(40),
                  child: GestureDetector(
                    onTap: () => _toggleEdit(),
                    child: Container(
                      width: double.infinity,
                      margin: EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 30,
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 17,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: Color(0xFFF7F7F7),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                              Navigator.of(context).pop();
                            },
                            child: Row(
                              children: [
                                Icon(
                                  Icons.search,
                                  color: AppColors.grey5,
                                  size: 22,
                                ),
                                Flexible(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text(
                                      widget.location.name ?? '',
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: Color(0xFF231F20),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          AppDivider(
                            color: Color(0xFFDDDDDD),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Row(
                              children: [
                                Icon(
                                  Icons.calendar_today,
                                  color: AppColors.grey5,
                                  size: 20,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    model.getTripPeriod,
                                    style: TextStyle(
                                      color: Color(0xFF231F20),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ))
              : PreferredSize(
                  preferredSize: Size.fromHeight(0),
                  child: SizedBox(),
                ),
        ),
        body: SingleChildScrollView(
          child: model.isLoading
              ? Column(
                  children: [
                    StaarmShimmers.loadCars(),
                    StaarmShimmers.loadCars(),
                    StaarmShimmers.loadCars(),
                  ],
                )
              : model.vehicles.length > 0
                  ? Column(
                      children: model.vehicles.map((e) {
                        return SearchCarWidget(
                          vehicle: e,
                          image: 'assets/images/mock_images/car_image_2.png',
                          pickupDate: widget.pickupDate ?? DateTime.now().add(Duration(days: 1)),
                          returnDate: widget.returnDate ?? DateTime.now().add(Duration(days: 5)),
                          pickupTime: widget.pickupTime ?? DateTime.now(),
                          returnTime: widget.returnTime ?? DateTime.now(),
                        );
                      }).toList(),
                    )
                  : TripsEmptyState(
                      image: 'assets/images/book_icon.png',
                      title:
                          'There are no vehicles available for this location',
                      subtitle: '',
                    ),
        ),
      ),
    );
  }
}

class EditSearchCarsHeader extends StatelessWidget {
  final String locatioName;
  final String tripPeriod;
  const EditSearchCarsHeader(
      {Key key, @required this.locatioName, @required this.tripPeriod})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.symmetric(
        horizontal: 17,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: Color(0xFFF7F7F7),
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        children: [
          Text(
            locatioName ?? '',
            style: TextStyle(
              color: Color(0xFF231F20),
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 6.0),
            child: Text(
              tripPeriod ?? '',
              // model.getTripPeriod,
              style: TextStyle(
                color: Color(0xFF231F20),
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SearchCarsHeader extends StatelessWidget {
  final bool isEdit;
  final Function onTap;
  final String locatioName;
  final String tripPeriod;
  const SearchCarsHeader({
    Key key,
    this.isEdit = false,
    this.onTap,
    @required this.locatioName,
    @required this.tripPeriod,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    if (isEdit)
      return Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Text(
          'Edit your search',
          style: TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      );

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(bottom: 10),
        padding: EdgeInsets.symmetric(
          horizontal: 17,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          color: Color(0xFFF7F7F7),
          borderRadius: BorderRadius.circular(22),
        ),
        child: Column(
          children: [
            Text(
              locatioName ?? '',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Color(0xFF231F20),
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 6.0),
              child: Text(
                tripPeriod ?? '',
                style: TextStyle(
                  color: Color(0xFF231F20),
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
