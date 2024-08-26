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
  Map<String, List> toDoMap; // { "pomodoro": [집중 세션 수, 집중 시간(초), 짧은 휴식, 긴 휴식] }

  @HiveField(9)
  List currentToDo; // ['name', 총 세션 수, 집중 시간(초), 짧은 휴식, 긴 휴식]

  @HiveField(10)
  int currentSession;

  UserDataModel({
    required this.premium,
    required this.vibration,
    required this.notificationIndex,
    required this.whiteNoiseIndex,
    required this.darkMode,
    required this.backgroundUsage,
    required this.language,
    required this.focusImmediately,
    required this.toDoMap,
    required this.currentToDo,
    required this.currentSession,
  });
}
