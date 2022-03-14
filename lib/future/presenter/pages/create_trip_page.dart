import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inno_commute/future/model/cubit/new_trip_cubit.dart';
import 'package:inno_commute/future/model/repository/trips_repository.dart';
import 'package:inno_commute/future/presenter/res/widgets/create_trip_page_widgets/date_time_picker.dart';
import 'package:inno_commute/future/presenter/res/widgets/create_trip_page_widgets/direction_picker.dart';
import 'package:inno_commute/future/presenter/res/widgets/create_trip_page_widgets/selector.dart';

class CreateTripPage extends StatelessWidget {
  const CreateTripPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _commentController = TextEditingController();
    return SingleChildScrollView(
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        children: [
          TypeOfTripSelector(),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            child: Divider(),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.0),
            child: Text(
              'Укажите дату и время окончания активности поездки',
              textAlign: TextAlign.center,
            ),
          ),
          const TripDateTimePicker(),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            child: Divider(),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.0),
            child: Text('Укажите город выезда и назначения'),
          ),
          const SelectDirectionWidget(),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            child: Divider(),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 8),
            child: Text(
              'Добавить комментарий к поездке',
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
                  helperText: 'Кол-во человек, точное место и т.д.',
                  labelText: 'Комментарий',
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
              if (_commentText != '') {
                context.read<NewTripCubit>().addComment(_commentText);
              }
              if (TripsRepository(
                      context.read<NewTripCubit>().state.repository.trip)
                  .createTrip()) {
                const snackBar = SnackBar(
                  duration: Duration(seconds: 2),
                  content: Text('Поездка создана'),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              } else {
                const snackBar = SnackBar(
                  duration: Duration(seconds: 2),
                  content: Text(
                      'Ошибка. Проверьте, все ли данные корректно заполнены.'),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
            },
            child: const Text('Создать поездку'),
            style: ElevatedButton.styleFrom(
              primary: Colors.cyan,
            ),
          ),
        ],
      ),
    );
  }
}
