import 'package:flutter/material.dart';
import 'package:staarm_mobile/core/models/address_model.dart';
import 'package:staarm_mobile/ui/views/search/widgets/search_result_tile.dart';

class AddressSearchContainer extends StatefulWidget {
  final List<PlaceModel> places;
  final Function(PlaceModel) onPlaceSelected;
  const AddressSearchContainer({
    Key key,
    @required this.places,
    @required this.onPlaceSelected,
  }) : super(key: key);

  @override
  _AddressSearchContainerState createState() => _AddressSearchContainerState();
}

class _AddressSearchContainerState extends State<AddressSearchContainer> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 6,
      ),
      padding: EdgeInsets.all(5),
      constraints: BoxConstraints(
        minHeight: size.height * .01,
        maxHeight: size.height * .28,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.grey.withOpacity(.2),
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: widget.places != null && widget.places.length == 0
              ? []
              : widget.places.map((e) {
                  return SearchResultTile(
                    title: e.name ?? '',
                    isDense: true,
                    onTap: () async {
                      widget.onPlaceSelected(e);
                    },
                  );
                }).toList(),
        ),
      ),
    );
  }
}
