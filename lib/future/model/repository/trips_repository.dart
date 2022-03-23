import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inno_commute/future/model/entities/trip.dart';

class TripsRepository {
  final Trip trip;

  TripsRepository(this.trip);

  bool checkTime() {
    if (trip.time.isBefore(DateTime.now())) return false;
    return true;
  }
}

class TripOperations {
  Future<void> cancelTrip(String id, bool isDriver) async {
    var fs = FirebaseFirestore.instance
        .collection(isDriver ? 'trips_driver' : 'trips_passenger');
    await fs.doc(id).update({'active': false});
  }

  Future<void> restoreTrip(String id, bool isDriver) async {
    var fs = FirebaseFirestore.instance
        .collection(isDriver ? 'trips_driver' : 'trips_passenger');
    await fs.doc(id).update({'active': true});
  }

  Future<void> deleteTrip(String id, bool isDriver) async {
    var fs = FirebaseFirestore.instance
        .collection(isDriver ? 'trips_driver' : 'trips_passenger');
    await fs.doc(id).delete();
  }
}
