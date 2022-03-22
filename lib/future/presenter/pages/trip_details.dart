import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class TripDetails extends StatelessWidget {
  final String name;
  final String cityFrom;
  final String cityTo;
  final String alias;
  final DateTime time;

  const TripDetails(
      {Key? key,
      required this.cityFrom,
      required this.cityTo,
      required this.time,
      required this.alias,
      required this.name})
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
              child: Text('Когда: ${time.toLocal()}'),
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
