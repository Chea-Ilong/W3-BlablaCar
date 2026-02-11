import 'package:blabla/model/ride/locations.dart';
import 'package:blabla/service/locations_service.dart';
import 'package:blabla/theme/theme.dart';
import 'package:blabla/widgets/input/bla_location_picker/location_tile.dart';
import 'package:flutter/material.dart';

class BlaLocationPicker extends StatefulWidget {
  const BlaLocationPicker({super.key});

  @override
  State<BlaLocationPicker> createState() => _BlaLocationPickerState();
}

class _BlaLocationPickerState extends State<BlaLocationPicker> {
  //one for search and other for the filter list to show
  late TextEditingController _searchController;
  late List<Location> _filteredLocations;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _filteredLocations = LocationsService.availableLocations;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  //for fliter the location
  void filterLocations(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredLocations = LocationsService.availableLocations;
      } else {
        _filteredLocations = LocationsService.availableLocations
            .where(
              (location) =>
                  location.name.toLowerCase().contains(query.toLowerCase()) ||
                  location.country.name.toLowerCase().contains(
                    query.toLowerCase(),
                  ),
            )
            .toList();
      }
    });
  }

  bool get _searchIsNotEmpty => _searchController.text.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          left: BlaSpacings.m,
          right: BlaSpacings.m,
          top: BlaSpacings.s,
        ),
        child: Column(
          children: [
            // Search Bar
            Container(
              decoration: BoxDecoration(
                color: BlaColors.backgroundAccent,
                borderRadius: BorderRadius.circular(BlaSpacings.radius),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: BlaColors.iconLight,
                        size: 18,
                      ),
                    ),
                  ),

                  //this is where the filter function happens
                  //on change value will rebuild the widget and show the new list
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        filterLocations(value);
                        setState(() {});
                      },
                      controller: _searchController,
                      style: TextStyle(color: BlaColors.textLight),
                      decoration: InputDecoration(
                        hintText: "Any city, street...",
                        border: InputBorder.none,
                        filled: false,
                      ),
                    ),
                  ),
                  //this is just an icon for the reset of the filter
                  _searchIsNotEmpty
                      ? IconButton(
                          icon: Icon(Icons.close, color: BlaColors.iconLight),
                          onPressed: () {
                            _searchController.clear();
                            filterLocations("");
                          },
                        )
                      : SizedBox.shrink(),
                ],
              ),
            ),
            // render location list tile
            Expanded(
              child: ListView.builder(
                itemCount: _filteredLocations.length,
                itemBuilder: (context, index) {
                  return LocationTile(
                    location: _filteredLocations[index],
                    onTap: () {
                      Navigator.pop(context, _filteredLocations[index]);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
