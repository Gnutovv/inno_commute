import 'package:inno_commute/future/model/directions.dart';
import 'package:inno_commute/future/model/entities/trip.dart';

class NewTripRepository {
  Trip trip = Trip(time: DateTime.now());

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
    if (comment != '') trip.comment = comment;
  }
}
