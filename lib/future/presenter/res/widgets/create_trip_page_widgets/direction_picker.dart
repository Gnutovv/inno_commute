import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inno_commute/future/model/cubit/new_trip_cubit.dart';
import 'package:inno_commute/future/model/directions.dart';
import 'package:select_dialog/select_dialog.dart';

class SelectDirectionWidget extends StatelessWidget {
  const SelectDirectionWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewTripCubit, NewTripState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Город выезда:'),
                  TextButton(
                    onPressed: () {
                      String ex1 = "No value selected";
                      SelectDialog.showModal<String>(
                        context,
                        label: "Город выезда",
                        selectedValue: ex1,
                        items: Direction.values
                            .map((e) => e.cityToString())
                            .toList(),
                        onChange: (String selected) {
                          context
                              .read<NewTripCubit>()
                              .setDirectionFrom(selected);
                        },
                      );
                    },
                    child: Text(context
                        .read<NewTripCubit>()
                        .state
                        .repository
                        .trip
                        .cityFrom
                        .cityToString()),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Город назначения:'),
                  TextButton(
                    onPressed: () {
                      String ex1 = "No value selected";
                      SelectDialog.showModal<String>(
                        context,
                        label: "Город выезда",
                        selectedValue: ex1,
                        items: Direction.values
                            .map((e) => e.cityToString())
                            .toList(),
                        onChange: (String selected) {
                          context.read<NewTripCubit>().setDirectionTo(selected);
                        },
                      );
                    },
                    child: Text(context
                        .read<NewTripCubit>()
                        .state
                        .repository
                        .trip
                        .cityTo
                        .cityToString()),
                  )
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
