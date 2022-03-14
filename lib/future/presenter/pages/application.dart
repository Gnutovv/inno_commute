import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inno_commute/future/model/cubit/navigator_cubit.dart';
import 'package:inno_commute/future/model/cubit/new_trip_cubit.dart';
import 'package:inno_commute/future/presenter/pages/create_trip_page.dart';
import 'package:inno_commute/future/presenter/pages/drivers_page.dart';
import 'package:inno_commute/future/presenter/pages/passengers_page.dart';
import 'package:inno_commute/future/presenter/pages/my_trips_page.dart';
import 'package:inno_commute/future/presenter/pages/settings_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Inno Commute',
      theme: ThemeData.light(),
      home: MultiBlocProvider(
        providers: [
          BlocProvider<NewTripCubit>(
            create: (context) => NewTripCubit(),
          ),
          BlocProvider<NavigatorCubit>(create: ((context) => NavigatorCubit())),
        ],
        child: const MainTemplate(),
      ),
    );
  }
}

class MainTemplate extends StatelessWidget {
  const MainTemplate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const List<Widget> _pages = [
      PassengerPage(),
      DriverPage(),
      CreateTripPage(),
      MyTripsPage(),
      SettingsPage(),
    ];

    return BlocBuilder<NavigatorCubit, int>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            systemOverlayStyle: SystemUiOverlayStyle.light,
            backgroundColor: Colors.cyan,
            centerTitle: true,
            title: const Text('Inno Commute'),
          ),
          body: GestureDetector(
            onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
            child: Center(
              child: _pages.elementAt(context.read<NavigatorCubit>().state),
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.emoji_people),
                label: 'Пассажиры',
                backgroundColor: Colors.cyan,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.drive_eta_sharp),
                label: 'Водители',
                backgroundColor: Colors.cyan,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.add),
                label: 'Новая поездка',
                backgroundColor: Colors.cyan,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.list),
                label: 'Мои поездки',
                backgroundColor: Colors.cyan,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Настройки',
                backgroundColor: Colors.cyan,
              ),
            ],
            currentIndex: context.read<NavigatorCubit>().state,
            selectedItemColor: Colors.white,
            onTap: (index) {
              switch (index) {
                case 0:
                  context.read<NavigatorCubit>().switchPassengerPage();
                  break;
                case 1:
                  context.read<NavigatorCubit>().switchDriverPage();
                  break;
                case 2:
                  context.read<NavigatorCubit>().switchCreatePage();
                  break;
                case 3:
                  context.read<NavigatorCubit>().switchMyTripsPage();
                  break;
                default:
                  context.read<NavigatorCubit>().switchSettingsPage();
                  break;
              }
            },
          ),
        );
      },
    );
  }
}

/*
class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = [
    PassengerPage(),
    DriverPage(),
    CreateTripPage(),
    MyTripsPage(),
    SettingsPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.light,
        backgroundColor: Colors.cyan,
        centerTitle: true,
        title: Text(widget.title),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.emoji_people),
            label: 'Пассажиры',
            backgroundColor: Colors.cyan,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.drive_eta_sharp),
            label: 'Водители',
            backgroundColor: Colors.cyan,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Новая поездка',
            backgroundColor: Colors.cyan,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Мои поездки',
            backgroundColor: Colors.cyan,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Настройки',
            backgroundColor: Colors.cyan,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        onTap: _onItemTapped,
      ),
    );
  }
}
*/