import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inno_commute/future/model/cubit/navigator_cubit.dart';
import 'package:inno_commute/future/model/cubit/new_trip_cubit.dart';
import 'package:inno_commute/future/model/cubit/user_cubit.dart';
import 'package:inno_commute/future/model/repository/trips_repository.dart';
import 'package:inno_commute/future/presenter/res/text_const.dart';
import 'package:inno_commute/future/presenter/res/widgets/create_trip_page_widgets/date_time_picker.dart';
import 'package:inno_commute/future/presenter/res/widgets/create_trip_page_widgets/direction_picker.dart';
import 'package:inno_commute/future/presenter/res/widgets/create_trip_page_widgets/selector.dart';

class CreateTripPage extends StatelessWidget {
  const CreateTripPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return context.read<UserCubit>().state.repository.isAuthorized
        ? const NewTrip()
        : Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Для создания поездки необходимо'),
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

class NewTrip extends StatelessWidget {
  const NewTrip({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _commentController = TextEditingController();
    if (context.read<NewTripCubit>().state.repository.trip.isComment) {
      _commentController.text =
          context.read<NewTripCubit>().state.repository.trip.comment;
    }
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TypeOfTripSelector(),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Divider(),
          ),
          const TripDateTimePicker(),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            child: Divider(),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.0),
            child: Text(
              setFromDirection,
              style: TextStyle(color: Colors.cyan),
            ),
          ),
          const SelectDirectionWidget(),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Divider(),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 8),
            child: Text(
              commentDescription,
              style: TextStyle(color: Colors.cyan),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 16),
            child: TextField(
              decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      gapPadding: 2,
                      borderSide: BorderSide(color: Colors.teal)),
                  helperText: commentHelper,
                  labelText: commentText,
                  prefixIcon: Icon(
                    Icons.description_outlined,
                    color: Colors.cyan,
                  ),
                  suffixStyle: TextStyle(color: Colors.green)),
              controller: _commentController,
            ),
          ),
          ElevatedButton(
            onPressed: () {
              String _commentText = _commentController.text;
              debugPrint('Проверяем наличие коммента');
              if (_commentText.isNotEmpty) {
                debugPrint('Коммент есть, добавляем в репо, и меняем булево');
                context.read<NewTripCubit>().addComment(_commentText);
                context.read<NewTripCubit>().state.repository.trip.isComment =
                    true;
              } else {
                debugPrint('Коммента нет, обнуляем в репо, и меняем булево');
                context.read<NewTripCubit>().addComment('');
                context.read<NewTripCubit>().state.repository.trip.isComment =
                    false;
              }

              debugPrint('Создаем поездку');
              if (TripsRepository(
                          context.read<NewTripCubit>().state.repository.trip)
                      .checkTime() &&
                  context.read<NewTripCubit>().state.repository.trip.cityFrom !=
                      context
                          .read<NewTripCubit>()
                          .state
                          .repository
                          .trip
                          .cityTo) {
                String name =
                    context.read<UserCubit>().state.repository.user.name;
                String creatorId =
                    context.read<UserCubit>().state.repository.user.id;
                String alias =
                    context.read<UserCubit>().state.repository.user.alias;
                debugPrint('User: $creatorId, name: $name');
                context
                    .read<NewTripCubit>()
                    .createTrip(creatorId, name, alias)
                    .then(
                  (value) {
                    if (value) {
                      context.read<NavigatorCubit>().switchMyTripsPage();
                      const snackBar = SnackBar(
                        duration: Duration(seconds: 2),
                        content: Text(tripWasCreated),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        duration: Duration(seconds: 2),
                        content: Text('Что-то пошло не так =('),
                      ));
                    }
                  },
                );
              } else {
                const snackBar = SnackBar(
                  duration: Duration(seconds: 2),
                  content: Text(tripWasNotCreated),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
            },
            child: const Text(createTripText),
            style: ElevatedButton.styleFrom(
              primary: Colors.cyan,
            ),
          ),
        ],
      ),
    );
  }
}
