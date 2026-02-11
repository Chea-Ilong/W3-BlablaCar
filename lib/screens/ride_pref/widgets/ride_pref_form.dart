import 'package:blabla/screens/ride_pref/widgets/ride_pref_tile.dart';
import 'package:blabla/theme/theme.dart';
import 'package:blabla/utils/date_time_util.dart';
import 'package:blabla/widgets/actions/bla_button.dart';
import 'package:blabla/widgets/display/bla_divider.dart';
import 'package:blabla/widgets/input/bla_location_picker.dart';
import 'package:flutter/material.dart';
import '../../../model/ride/locations.dart';
import '../../../model/ride_pref/ride_pref.dart';

///
/// A Ride Preference From is a view to select:
///   - A depcarture location
///   - An arrival location
///   - A date
///   - A number of seats
///
/// The form can be created with an existing RidePref (optional).
///
class RidePrefForm extends StatefulWidget {
  // The form can be created with an optional initial RidePref.
  final RidePref? initRidePref;

  const RidePrefForm({super.key, this.initRidePref});

  @override
  State<RidePrefForm> createState() => _RidePrefFormState();
}

class _RidePrefFormState extends State<RidePrefForm> {
  Location? departure;
  late DateTime departureDate;
  Location? arrival;
  late int requestedSeats;

  // ----------------------------------
  // Initialize the Form attributes
  // ----------------------------------

  @override
  void initState() {
    super.initState();
    //initialize the data when first come in
    if (widget.initRidePref != null) {
      departure = widget.initRidePref!.departure;
      arrival = widget.initRidePref!.arrival;
      departureDate = widget.initRidePref!.departureDate;
      requestedSeats = widget.initRidePref!.requestedSeats;
    } else {
      //defualt value for the form if user dont pick anything
      departure = null;
      arrival = null;
      departureDate = DateTime.now();
      requestedSeats = 1;

      // Mock data for testing the swap icon
      // departure = Location(name: 'Phnom Penh', country: Country.uk);
      // arrival = Location(name: 'Siem Reap', country: Country.france);
    }
  }

  // ----------------------------------
  // Handle events
  // ----------------------------------
  void onDeparture() async {
    //go to the location picker
    Location? selectedLocation = await Navigator.of(context).push<Location>(
      MaterialPageRoute(
        builder: (context) => BlaLocationPicker()
      ),
    );

    // if user select location, rebuild
    if (selectedLocation != null) {
      setState(() {
        departure = selectedLocation;
      });
    }
  }

  void onArrival() async {
    //go to the location picker
    Location? selectedLocation = await Navigator.of(context).push<Location>(
      MaterialPageRoute(
        builder: (context) => BlaLocationPicker(),
      ),
    );

    // if user select location, rebuild
    if (selectedLocation != null) {
      setState(() {
        arrival = selectedLocation;
      });
    }
  }

  void onSwapLocation() {
    setState(() {
      //can switch location if the two is not  null
      if (departure != null && arrival != null) {
        Location temp = departure!;
        departure = arrival;
        arrival = temp;
      }
    });
  }

  // ----------------------------------
  // Compute the widgets rendering
  // ----------------------------------
  String get departureLabel => departure?.name ?? "Leaving from";
  String get arrivalLabel => arrival?.name ?? "Going to";
  String get dateLabel => DateTimeUtils.formatDateTime(departureDate);
  bool get switchVisible => arrival != null && departure != null;

  // Build the widgets
  // ----------------------------------x
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: BlaSpacings.m),
          child: Column(
            children: [
              //tile 1: departure
              RidePrefTile(
                isPlaceHolder: departure == null,
                title: departureLabel,
                leftIcon: Icons.location_on,
                onPressed: onDeparture,
                rightIcon: switchVisible ? Icons.swap_vert : null,
                onRightIcon: switchVisible ? onSwapLocation : null,
              ),

              const BlaDivider(),

              //tile 2: arrival
              RidePrefTile(
                isPlaceHolder: arrival == null,
                title: arrivalLabel,
                leftIcon: Icons.location_on,
                onPressed: onArrival,
              ),
              const BlaDivider(),

              // tile 3: the date
              RidePrefTile(
                title: dateLabel,
                leftIcon: Icons.calendar_month,
                onPressed: () => {},
              ),
              const BlaDivider(),

              // tile 4: the requested seats
              RidePrefTile(
                title: requestedSeats.toString(),
                leftIcon: Icons.person_2_outlined,
                onPressed: () => {},
              ),
            ],
          ),
        ),

        // the search button
        BlaButton(
          title: 'Search',
          type: ButtonType.primary,
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => BlaLocationPicker(),
            ),
          ),
        ),
      ],
    );
  }
}
