import 'package:inno_commute/future/model/directions.dart';

class Trip {
  bool isDriver;
  String author;
  String creatorId;
  Direction cityFrom;
  Direction cityTo;
  DateTime time;
  bool isComment;
  String comment;
  bool active;
  Trip({
    this.isDriver = false,
    this.author = '',
    required this.creatorId,
    this.cityFrom = Direction.innopolis,
    this.cityTo = Direction.kazan,
    required this.time,
    this.isComment = false,
    this.comment = '',
    this.active = true,
  });
}
