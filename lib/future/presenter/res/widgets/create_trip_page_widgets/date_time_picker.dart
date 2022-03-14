import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:inno_commute/future/model/cubit/new_trip_cubit.dart';

class TripDateTimePicker extends StatelessWidget {
  const TripDateTimePicker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime minDate = DateTime.now();
    DateTime maxDate = DateTime(minDate.year, minDate.month, minDate.day + 2,
        minDate.hour + 23, minDate.minute + 59);
    bool wasSelected = false;
    return BlocBuilder<NewTripCubit, NewTripState>(
      builder: (context, state) {
        return TextButton(
            onPressed: () {
              DatePicker.showDateTimePicker(context,
                  showTitleActions: true,
                  minTime: minDate,
                  maxTime: maxDate, onConfirm: (date) {
                context.read<NewTripCubit>().setDate(date);
                wasSelected = true;
              },
                  currentTime:
                      context.read<NewTripCubit>().state.repository.trip.time,
                  locale: LocaleType.ru);
            },
            child: wasSelected
                ? Text(context
                    .read<NewTripCubit>()
                    .state
                    .repository
                    .trip
                    .time
                    .toLocal()
                    .toString()
                    .substring(0, 16))
                : const Text('Выбрать дату и время поездки'));
      },
    );
  }
}
