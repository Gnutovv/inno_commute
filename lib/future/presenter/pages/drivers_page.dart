import 'package:flutter/material.dart';
import 'package:inno_commute/future/presenter/res/text_const.dart';
import 'package:inno_commute/future/presenter/res/widgets/icons.dart';

class DriverPage extends StatelessWidget {
  const DriverPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: DriverPageHasData(),
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
