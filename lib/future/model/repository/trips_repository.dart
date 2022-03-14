import 'package:inno_commute/future/model/entities/trip.dart';

class TripsRepository {
  final Trip trip;

  TripsRepository(this.trip);

  bool createTrip() {
    if (trip.time.isBefore(DateTime.now())) return false;
    return true;
  }
}
