import 'package:hive/hive.dart';

part 'user_data_model.g.dart';

@HiveType(typeId: 1)
class UserDataModel extends HiveObject {
  @HiveField(0)
  bool premium;

  @HiveField(1)
  bool vibration;

  @HiveField(2)
  int notificationIndex;

  @HiveField(3)
  int whiteNoiseIndex;

  @HiveField(4)
  bool darkMode;

  @HiveField(5)
  bool backgroundUsage;

  @HiveField(6)
  int language; // 0: eng, 1: kor

  @HiveField(7)
  bool focusImmediately;

  @HiveField(8)
  List<Map> toDoList;
  /*
  [
    {
      "name": "pomo",
      "focusCount": 집중 세션 수,
      "focusTime": 집중 시간(분),
      "shortBreakTime": 짧은 휴식(분),
      "longBreakTime": 긴 휴식(분),
      "timeUnit": 시간 단위,
      "icon": 아이콘(String),
    },
  ]
  */

  @HiveField(9)
  int currentToDo;

  @HiveField(10)
  int currentSession; // 총 세션 기준 현재 세션

  @HiveField(11)
  int currentTime; // 현재 세션에서 진행 중인 시간(초)

  UserDataModel({
    required this.premium,
    required this.vibration,
    required this.notificationIndex,
    required this.whiteNoiseIndex,
    required this.darkMode,
    required this.backgroundUsage,
    required this.language,
    required this.focusImmediately,
    required this.toDoList,
    required this.currentToDo,
    required this.currentSession,
    required this.currentTime,
  });
}
