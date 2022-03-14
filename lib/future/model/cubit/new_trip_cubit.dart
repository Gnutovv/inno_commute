import 'package:bloc/bloc.dart';
import 'package:inno_commute/future/model/repository/new_trip_repository.dart';
import 'package:meta/meta.dart';

part 'new_trip_state.dart';

class NewTripCubit extends Cubit<NewTripState> {
  NewTripCubit() : super(NewTripInitial(NewTripRepository()));

  void switchToPassengerType() {
    state.repository.switchTypeOnPassenger();
    emit(NewTripSelectTypeOnPassenger(state.repository));
  }

  void switchToDriverType() {
    state.repository.switchTypeOnDriver();
    emit(NewTripSelectTypeOnDriver(state.repository));
  }

  void setDate(DateTime date) {
    state.repository.selectDateTimeTrip(date);
    emit(NewTripSetDate(state.repository));
  }

  void setDirectionFrom(String city) {
    state.repository.setDirectionFrom(city);
    emit(NewTripSetDirectionFrom(state.repository));
  }

  void setDirectionTo(String city) {
    state.repository.setDirectionTo(city);
    emit(NewTripSetDirectionTo(state.repository));
  }

  void addComment(String comment) {
    state.repository.addComment(comment);
    emit(NewTripAddComment(state.repository));
  }
}
