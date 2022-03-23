import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:inno_commute/future/model/repository/trips_repository.dart';

class MyTripDetails extends StatelessWidget {
  final String id;
  final String name;
  final bool isDriver;
  final bool isActive;
  final String cityFrom;
  final String cityTo;
  final String alias;
  final DateTime time;

  const MyTripDetails(
      {Key? key,
      required this.cityFrom,
      required this.cityTo,
      required this.time,
      required this.alias,
      required this.name,
      required this.id,
      required this.isDriver,
      required this.isActive})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String parseDate(DateTime date) {
      String dd = date.day.toString().length == 1
          ? '0${date.day.toString()}'
          : date.day.toString();
      String mm = date.month.toString().length == 1
          ? '0${date.month.toString()}'
          : date.month.toString();

      return '$dd.$mm.${date.year.toString()}';
    }

    String parseTime(DateTime time) {
      String hh = time.day.toString().length == 1
          ? '0${time.hour.toString()}'
          : time.hour.toString();
      String mm = time.minute.toString().length == 1
          ? '0${time.minute.toString()}'
          : time.minute.toString();
      return '$hh:$mm';
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        backgroundColor: Colors.cyan,
        title: const Text('Детали поездки'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.all(32.0),
              child: Text(
                'Подробности',
                style: TextStyle(fontSize: 32, color: Colors.cyan),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(22.0),
              child: Text('Попутчик: $name'),
            ),
            Padding(
              padding: const EdgeInsets.all(22.0),
              child: Text('Откуда едет: $cityFrom'),
            ),
            Padding(
              padding: const EdgeInsets.all(22.0),
              child: Text('Куда едет: $cityTo'),
            ),
            Padding(
              padding: const EdgeInsets.all(22.0),
              child: Text('Когда: ${parseDate(time)} ${parseTime(time)}'),
            ),
            Padding(
                padding: const EdgeInsets.all(22.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    isActive
                        ? IconButton(
                            iconSize: 36,
                            icon: const Icon(
                              Icons.cancel_sharp,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              TripOperations().cancelTrip(id, isDriver);
                              Navigator.of(context).pop();
                            },
                          )
                        : IconButton(
                            iconSize: 36,
                            icon: const Icon(
                              Icons.task_alt_outlined,
                              color: Colors.green,
                            ),
                            onPressed: () {
                              TripOperations().restoreTrip(id, isDriver);
                              Navigator.of(context).pop();
                            },
                          ),
                    IconButton(
                      iconSize: 36,
                      icon: const Icon(
                        Icons.delete_forever,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        TripOperations().deleteTrip(id, isDriver);
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
