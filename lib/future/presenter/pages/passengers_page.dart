import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:inno_commute/future/presenter/pages/trip_details.dart';
import 'package:inno_commute/future/presenter/res/text_const.dart';
import 'package:inno_commute/future/presenter/res/widgets/icons.dart';

class PassengerPage extends StatelessWidget {
  const PassengerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('trips_passenger')
            //.where('is_active', isEqualTo: true)
            .where('time', isGreaterThan: DateTime.now().millisecondsSinceEpoch)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
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
                  String data =
                      '${dateTime.day}-${dateTime.month}-${dateTime.year}';
                  String time = '${dateTime.hour}:${dateTime.minute}';
                  String name = snapshot.data!.docs[index].get('author');
                  String cityFrom = snapshot.data!.docs[index].get('city_from');
                  String cityTo = snapshot.data!.docs[index].get('city_to');
                  String alias = snapshot.data!.docs[index].get('alias');
                  bool isComment = snapshot.data!.docs[index].get('is_comment');
                  String? comment = isComment
                      ? snapshot.data!.docs[index].get('comment')
                      : null;
                  return Dismissible(
                      key: Key(snapshot.data!.docs[index].id),
                      child: GestureDetector(
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
                      ));
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
