import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:inno_commute/future/presenter/pages/trip_details.dart';
import 'package:inno_commute/future/presenter/res/text_const.dart';
import 'package:inno_commute/future/presenter/res/widgets/icons.dart';

class DriverPage extends StatelessWidget {
  const DriverPage({Key? key}) : super(key: key);

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

    return Center(
      child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('trips_driver')
            //.where('is_active', isEqualTo: true)
            .where('time', isGreaterThan: DateTime.now().millisecondsSinceEpoch)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.data?.size == 0) {
            return const DriverPageHasNotData();
          } else if (snapshot.hasError) {
            return const DriverPageHasError();
          } else {
            return Scrollbar(
              child: ListView.builder(
                itemCount: snapshot.data!.docs.length,
                padding: const EdgeInsets.symmetric(vertical: 8),
                itemBuilder: (BuildContext context, int index) {
                  var dateTime = DateTime.fromMillisecondsSinceEpoch(
                      snapshot.data!.docs[index].get('time') as int);
                  String data = parseDate(dateTime);
                  String time = parseTime(dateTime);
                  String name = snapshot.data!.docs[index].get('author');
                  String cityFrom = snapshot.data!.docs[index].get('city_from');
                  String cityTo = snapshot.data!.docs[index].get('city_to');
                  String alias = snapshot.data!.docs[index].get('alias');
                  bool isComment = snapshot.data!.docs[index].get('is_comment');
                  String? comment = isComment
                      ? snapshot.data!.docs[index].get('comment')
                      : null;
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TripDetails(
                                    name: name,
                                    alias: alias,
                                    cityFrom: cityFrom,
                                    cityTo: cityTo,
                                    time: dateTime,
                                    comment: comment ?? '',
                                  )));
                    },
                    child: Card(
                      color: Colors.cyan[50],
                      child: ListTile(
                          leading: driverIcon,
                          title: Text('$cityFrom -> $cityTo'),
                          subtitle: isComment ? Text(comment!) : null,
                          trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(data),
                              Text(
                                time,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          )),
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}

class DriverPageHasNotData extends StatelessWidget {
  const DriverPageHasNotData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(isNotTrips),
    );
  }
}

class DriverPageHasError extends StatelessWidget {
  const DriverPageHasError({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(isError),
    );
  }
}

class DriverPageHasData extends StatelessWidget {
  const DriverPageHasData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8),
        children: [
          for (int i = 0; i < 20; i++)
            ListTile(
                leading: driverIcon,
                title: Text('???????????? - ?????????????????? $i'),
                subtitle: Text('?????????????????????? $i'),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('???????? $i'),
                    Text(
                      '?????????? $i',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ))
        ],
      ),
    );
  }
}
