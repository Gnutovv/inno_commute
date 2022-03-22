import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inno_commute/future/model/cubit/my_trips_cubit.dart';
import 'package:inno_commute/future/model/cubit/navigator_cubit.dart';
import 'package:inno_commute/future/model/cubit/user_cubit.dart';
import 'package:inno_commute/future/presenter/res/text_const.dart';
import 'package:inno_commute/future/presenter/res/widgets/my_trips/driver_builder.dart';
import 'package:inno_commute/future/presenter/res/widgets/my_trips/passenger_builder.dart';

class MyTripsPage extends StatelessWidget {
  const MyTripsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isAuthorized = context.read<UserCubit>().state.repository.isAuthorized;
    String userId = context.read<UserCubit>().state.repository.user.id;
    if (isAuthorized) {
      return Center(
        child: BlocBuilder<MyTripsCubit, bool>(
          builder: (context, state) {
            return GestureDetector(
              onPanUpdate: (details) {
                // Swiping in right direction.
                if (details.delta.dx > 0) {
                  context.read<MyTripsCubit>().getPassengerTrips();
                }

                // Swiping in left direction.
                if (details.delta.dx < 0) {
                  context.read<MyTripsCubit>().getDriverTrips();
                }
              },
              child: state
                  ? MyTripsDriver(userId: userId)
                  : MyTripsPassenger(userId: userId),
            );
          },
        ),
      );
    } else {
      return Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Для просмотра поездок необходимо'),
            TextButton(
              onPressed: () {
                context.read<NavigatorCubit>().switchSettingsPage();
              },
              child: const Text('авторизоваться'),
            ),
          ],
        ),
      );
    }
  }
}

class MyTripsPageHasNotData extends StatelessWidget {
  const MyTripsPageHasNotData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(isNotTrips),
    );
  }
}

class MyTripsPageHasError extends StatelessWidget {
  const MyTripsPageHasError({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(isError),
    );
  }
}
