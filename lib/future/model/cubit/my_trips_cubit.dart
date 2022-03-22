import 'package:bloc/bloc.dart';

class MyTripsCubit extends Cubit<bool> {
  MyTripsCubit() : super(false);

  void getPassengerTrips() => emit(false);
  void getDriverTrips() => emit(true);
}
