import 'package:hive/hive.dart';

part 'user_settings_model.g.dart';

@HiveType(typeId: 1)
class UserSettingsModel extends HiveObject {
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
  String language;

  @HiveField(7)
  bool focusImmediately;

  UserSettingsModel({
    required this.premium,
    required this.vibration,
    required this.notificationIndex,
    required this.whiteNoiseIndex,
    required this.darkMode,
    required this.backgroundUsage,
    required this.language,
    required this.focusImmediately,
  });
}
