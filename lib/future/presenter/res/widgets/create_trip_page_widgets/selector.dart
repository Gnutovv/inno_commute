import 'package:flutter/material.dart';
import 'package:inno_commute/future/model/cubit/new_trip_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inno_commute/future/model/repository/new_trip_repository.dart';

class TypeOfTripSelector extends StatelessWidget {
  TypeOfTripSelector({Key? key}) : super(key: key);
  final TextStyle _unselectedTextStyle = const TextStyle(color: Colors.black);

  final ButtonStyle _activeButton = ElevatedButton.styleFrom(
    primary: Colors.cyan,
  );
  final ButtonStyle _notActiveButton = ElevatedButton.styleFrom(
    primary: Colors.white,
    side: const BorderSide(
      color: Colors.cyan,
      width: 1,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewTripCubit, NewTripState>(
      builder: (context, state) {
        //context.read<NewTripCubit>().state.repository.trip.id;

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton.icon(
              onPressed: () {
                context.read<NewTripCubit>().switchToPassengerType();
              },
              icon: Icon(
                Icons.emoji_people,
                color:
                    !context.read<NewTripCubit>().state.repository.trip.isDriver
                        ? Colors.white
                        : Colors.cyan,
              ),
              label: Text(
                'Я пассажир',
                style:
                    context.read<NewTripCubit>().state.repository.trip.isDriver
                        ? _unselectedTextStyle
                        : null,
              ),
              style:
                  !context.read<NewTripCubit>().state.repository.trip.isDriver
                      ? _activeButton
                      : _notActiveButton,
            ),
            ElevatedButton.icon(
              onPressed: () {
                context.read<NewTripCubit>().switchToDriverType();
              },
              icon: Icon(
                Icons.drive_eta_sharp,
                color:
                    context.read<NewTripCubit>().state.repository.trip.isDriver
                        ? Colors.white
                        : Colors.cyan,
              ),
              label: Text(
                'Я водитель',
                style:
                    !context.read<NewTripCubit>().state.repository.trip.isDriver
                        ? _unselectedTextStyle
                        : null,
              ),
              style: context.read<NewTripCubit>().state.repository.trip.isDriver
                  ? _activeButton
                  : _notActiveButton,
            ),
          ],
        );
      },
    );
  }
}
