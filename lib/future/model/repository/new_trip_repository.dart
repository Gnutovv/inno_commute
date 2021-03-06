import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inno_commute/future/model/directions.dart';
import 'package:inno_commute/future/model/entities/trip.dart';

class NewTripRepository {
  Trip trip = Trip(time: DateTime.now(), creatorId: '');

  void switchTypeOnPassenger() {
    if (trip.isDriver) trip.isDriver = false;
  }

  void switchTypeOnDriver() {
    if (!trip.isDriver) trip.isDriver = true;
  }

  void selectDateTimeTrip(DateTime date) {
    trip.time = date;
  }

  void setDirectionFrom(String city) {
    int cityPosition = -1;
    if (city == 'Казань') cityPosition = 0;
    if (city == 'Иннополис') cityPosition = 1;
    if (city == 'Зеленодольск') cityPosition = 2;
    if (city == 'Наб. Челны') cityPosition = 3;
    trip.cityFrom = Direction.values.elementAt(cityPosition);
  }

  void setDirectionTo(String city) {
    int cityPosition = -1;
    if (city == 'Казань') cityPosition = 0;
    if (city == 'Иннополис') cityPosition = 1;
    if (city == 'Зеленодольск') cityPosition = 2;
    if (city == 'Наб. Челны') cityPosition = 3;
    trip.cityTo = Direction.values.elementAt(cityPosition);
  }

  void addComment(String comment) {
    trip.comment = comment;
    if (trip.comment != '') {
      trip.isComment = true;
    } else {
      trip.isComment = false;
    }
  }

  Future<bool> createTrip(String creatorId, String name, String alias) async {
    String collection = trip.isDriver ? 'trips_driver' : 'trips_passenger';
    var fs = FirebaseFirestore.instance.collection(collection);
    await fs.add({
      'is_driver': trip.isDriver,
      'author': name,
      'creator_id': creatorId,
      'city_from': trip.cityFrom.cityToString(),
      'city_to': trip.cityTo.cityToString(),
      'time': trip.time.millisecondsSinceEpoch,
      'is_comment': trip.isComment,
      'comment': trip.comment,
      'active': trip.active,
      'alias': alias,
    });

    return true;
  }
}
