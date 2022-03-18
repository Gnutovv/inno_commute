import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:inno_commute/future/presenter/pages/application.dart';

void main() async {
  // инициализируем Firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}
