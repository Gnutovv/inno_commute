import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:inno_commute/future/presenter/pages/trip_details.dart';
import 'package:inno_commute/future/presenter/res/text_const.dart';
import 'package:inno_commute/future/presenter/res/widgets/icons.dart';

class PassengerPage extends StatelessWidget {
  const PassengerPage({Key? key}) : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    return Center(
      child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('trips_passenger')
            //.where('is_active', isEqualTo: true) Не смог сделать двойное условие
            .where('time', isGreaterThan: DateTime.now().millisecondsSinceEpoch)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.data?.size == 0) {
            return const PassengerPageHasNotData();
          } else if (snapshot.hasError) {
            return const PassengerPageHasError();
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
                                    comment: isComment ? comment! : '',
                                  )));
                    },
                    child: Card(
                      color: Colors.cyan[50],
                      child: ListTile(
                          leading: peopleIcon,
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

class PassengerPageHasNotData extends StatelessWidget {
  const PassengerPageHasNotData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(isNotTrips),
    );
  }
}

class PassengerPageHasError extends StatelessWidget {
  const PassengerPageHasError({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(isError),
    );
  }
}
