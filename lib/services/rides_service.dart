import '../data/dummy_data.dart';
import '../model/ride/locations.dart';
import '../model/ride/ride.dart';

////
///   This service handles:
///   - The list of available rides
///
class RidesService {
  static List<Ride> allRides = fakeRides;
    static List<Ride> filterByDeparture(Location departure) {
  List<Ride> filteredRides = [];

  for (Ride ride in allRides) {
    if (ride.departureLocation == departure) {
      filteredRides.add(ride);
    }
  }

  return filteredRides;
}


  static List<Ride> filterBySeatRequested(int seatRequested) {
  List<Ride> filteredRides = [];

  for (Ride ride in allRides) {
    if (ride.availableSeats >= seatRequested) {
      filteredRides.add(ride);
    }
  }

  return filteredRides;
}


  static List<Ride> filterBy({
  Location? departure,
  int? seatRequested,
}) {
  List<Ride> result = [];

  for (Ride ride in allRides) {
    if ((departure == null || ride.departureLocation == departure) &&
        (seatRequested == null || ride.availableSeats >= seatRequested)) {
      result.add(ride);
    }
  }

  return result;
}

}

 
