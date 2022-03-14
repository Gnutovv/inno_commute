import 'package:flutter/material.dart';
import 'package:inno_commute/future/presenter/res/text_const.dart';
import 'package:inno_commute/future/presenter/res/widgets/icons.dart';

class PassengerPage extends StatelessWidget {
  const PassengerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: PassengerPageHasData(),
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

class PassengerPageHasData extends StatelessWidget {
  const PassengerPageHasData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8),
        children: [
          for (int i = 0; i < 20; i++)
            ListTile(
                leading: peopleIcon,
                title: Text('Казань - Иннополис $i'),
                subtitle: Text('Комментарий $i'),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Дата $i'),
                    Text(
                      'Время $i',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ))
        ],
      ),
    );
  }
}
