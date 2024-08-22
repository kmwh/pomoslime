import 'package:hive/hive.dart';

part 'focus_time_model.g.dart';

@HiveType(typeId: 2)
class FocusTimeModel extends HiveObject {
  @HiveField(0)
  DateTime date;

  @HiveField(1)
  int focusTime;

  FocusTimeModel({
    required this.date,
    required this.focusTime,
  });
}
