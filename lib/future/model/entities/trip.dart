import 'package:inno_commute/future/model/directions.dart';

class Trip {
  int id;
  bool isDriver;
  String author;
  Direction cityFrom;
  Direction cityTo;
  DateTime time;
  bool isComment;
  String comment;
  bool active;
  Trip({
    this.id = 0,
    this.isDriver = false,
    this.author = 'author',
    this.cityFrom = Direction.innopolis,
    this.cityTo = Direction.kazan,
    required this.time,
    this.isComment = false,
    this.comment = '',
    this.active = true,
  });
}
