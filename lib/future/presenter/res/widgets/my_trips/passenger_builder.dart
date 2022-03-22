import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:inno_commute/future/presenter/pages/my_trip_details.dart';
import 'package:inno_commute/future/presenter/pages/my_trips_page.dart';
import 'package:inno_commute/future/presenter/res/widgets/icons.dart';

class MyTripsPassenger extends StatelessWidget {
  final String userId;
  const MyTripsPassenger({Key? key, required this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('trips_passenger')
          .where('creator_id', isEqualTo: userId)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.data?.size == 0) {
          return const MyTripsPageHasNotData();
        } else if (snapshot.hasError) {
          return const MyTripsPageHasError();
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
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MyTripDetails(
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
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
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
    );
  }
}
