import 'package:hive/hive.dart';

part 'calender_data_model.g.dart';

@HiveType(typeId: 2)
class CalenderDataModel extends HiveObject {
  @HiveField(1)
  Map<DateTime, int> focusTimeMap;

  @HiveField(2)
  int totalFocusTime;

  @HiveField(3)
  int todayFocusTime;

  @HiveField(4)
  int weekFocusTime;

  @HiveField(5)
  int monthFocusTime;

  @HiveField(6)
  int yearFocusTime;

  @HiveField(7)
  bool numberView;

  CalenderDataModel({
    required this.focusTimeMap,
    required this.totalFocusTime,
    required this.todayFocusTime,
    required this.weekFocusTime,
    required this.monthFocusTime,
    required this.yearFocusTime,
    required this.numberView,
  });
}
