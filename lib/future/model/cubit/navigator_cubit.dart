import 'package:bloc/bloc.dart';

class NavigatorCubit extends Cubit<int> {
  NavigatorCubit() : super(0);

  void switchPassengerPage() => emit(0);

  void switchDriverPage() => emit(1);

  void switchCreatePage() => emit(2);

  void switchMyTripsPage() => emit(3);

  void switchSettingsPage() => emit(4);
}
