import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class TripDetails extends StatelessWidget {
  final String name;
  final String cityFrom;
  final String cityTo;
  final String alias;
  final String comment;
  final DateTime time;

  const TripDetails(
      {Key? key,
      required this.cityFrom,
      required this.cityTo,
      required this.time,
      required this.alias,
      required this.name,
      required this.comment})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    void launchTelegram() async {
      var edAlias = alias[0] == '@' ? alias.substring(1, alias.length) : alias;
      String url = 'https://t.me/$edAlias';
      if (await canLaunch(url)) {
        await launch(url);
      }
    }

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
              child: Container(child: Text(comment)),
            ),
            Padding(
              padding: const EdgeInsets.all(22.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Написать в telegram:'),
                  TextButton(
                      onPressed: () {
                        launchTelegram();
                      },
                      child: Text(alias)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
