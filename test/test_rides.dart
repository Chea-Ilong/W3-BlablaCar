import 'package:blabla/model/ride/ride.dart';

import 'package:blabla/model/ride/locations.dart';
import 'package:blabla/service/rides_service.dart';

void main() {
  
  Location dijon = Location(country: Country.spain, name: "Dijon");

  List<Ride> filteredRide = RidesService.filterByDeparture(dijon);

  for (Ride ride in filteredRide) {
    print(ride);  
  }

  
}
